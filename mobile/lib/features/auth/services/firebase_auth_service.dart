import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import '../models/user_model.dart';
import 'api_service.dart';

@injectable
class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ApiService _apiService = ApiService();
  
  // Vietnamese phone number format validation
  static final RegExp _vietnamesePhoneRegex = 
      RegExp(r'^(\+84|84|0)[3-9][0-9]{8}$');

  // Stream of authentication state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Get current Firebase user
  User? get currentFirebaseUser => _firebaseAuth.currentUser;

  // Check if user is signed in
  bool get isSignedIn => currentFirebaseUser != null;

  // Format Vietnamese phone number to +84 format
  String formatVietnamesePhone(String phone) {
    // Remove all non-digit characters
    String digitsOnly = phone.replaceAll(RegExp(r'[^\d]'), '');
    
    // Handle different Vietnamese phone formats
    if (digitsOnly.startsWith('0') && digitsOnly.length == 10) {
      // 0xxxxxxxxx -> +84xxxxxxxxx
      return '+84${digitsOnly.substring(1)}';
    } else if (digitsOnly.startsWith('84') && digitsOnly.length == 11) {
      // 84xxxxxxxxx -> +84xxxxxxxxx
      return '+$digitsOnly';
    } else if (digitsOnly.startsWith('84') && digitsOnly.length == 12) {
      // +84xxxxxxxxx (already correct format)
      return '+$digitsOnly';
    }
    
    // Return as-is if format doesn't match expected patterns
    return phone;
  }

  // Validate Vietnamese phone number
  bool isValidVietnamesePhone(String phone) {
    return _vietnamesePhoneRegex.hasMatch(phone);
  }

  // Send SMS verification code - returns verification ID or throws exception
  Future<String> sendSMSVerification({
    required String phoneNumber,
    Function(PhoneAuthCredential credential)? onAutoVerify,
  }) async {
    final formattedPhone = formatVietnamesePhone(phoneNumber);
    
    if (!isValidVietnamesePhone(formattedPhone)) {
      throw FirebaseAuthException(
        code: 'invalid-phone-number',
        message: 'Số điện thoại không đúng định dạng Việt Nam',
      );
    }

    // Use a Completer to convert callback-based API to Future-based
    final completer = Completer<String>();
    
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: formattedPhone,
        verificationCompleted: (PhoneAuthCredential credential) {
          debugPrint('Phone verification completed automatically');
          if (onAutoVerify != null) {
            onAutoVerify(credential);
          }
          // For auto-verification, we complete with a special identifier
          // This will be handled in completeRegistration method
          if (!completer.isCompleted) {
            completer.complete('auto-verified:${credential.verificationId ?? 'instant'}');
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint('Phone verification failed: ${e.code} - ${e.message}');
          debugPrint('Error details: ${e.toString()}');
          debugPrint('Phone number attempted: $formattedPhone');
          if (!completer.isCompleted) {
            completer.completeError(e);
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          debugPrint('SMS code sent to $formattedPhone');
          if (!completer.isCompleted) {
            completer.complete(verificationId);
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          debugPrint('Code auto-retrieval timeout');
          // Don't complete here as this is just a timeout notification
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      debugPrint('SMS verification error: $e');
      if (!completer.isCompleted) {
        if (e is FirebaseAuthException) {
          completer.completeError(e);
        } else {
          completer.completeError(FirebaseAuthException(
            code: 'unknown',
            message: e.toString(),
          ));
        }
      }
    }

    return completer.future;
  }

  // Verify SMS code and sign in
  Future<UserCredential?> verifyAndSignIn({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      debugPrint('Firebase sign-in successful: ${userCredential.user?.uid}');
      return userCredential;
    } catch (e) {
      debugPrint('SMS verification failed: $e');
      rethrow;
    }
  }

  // Authenticate with Laravel backend after Firebase sign-in
  Future<UserModel?> authenticateWithBackend({
    String? name,
    List<String>? preferredSports,
  }) async {
    try {
      final user = currentFirebaseUser;
      if (user == null) {
        throw Exception('No Firebase user found');
      }

      // Get Firebase ID token
      final idToken = await user.getIdToken();
      if (idToken == null) {
        throw Exception('Failed to get Firebase ID token');
      }
      
      // Call Laravel authentication endpoint
      final response = await _apiService.authenticateWithFirebase(
        idToken: idToken,
        name: name,
        preferredSports: preferredSports,
      );

      if (response['success'] == true) {
        final userData = response['user'] as Map<String, dynamic>;
        return UserModel.fromJson(userData);
      } else {
        throw Exception(response['message'] ?? 'Authentication failed');
      }
    } catch (e) {
      debugPrint('Backend authentication error: $e');
      rethrow;
    }
  }

  // Send SMS and complete registration flow (Firebase + Backend)
  Future<UserModel> completeRegistration({
    required String phoneNumber,
    required String smsCode,
    required String name,
    List<String>? preferredSports,
    String? verificationId,
  }) async {
    try {
      // Validate inputs
      if (phoneNumber.isEmpty) {
        throw Exception('Phone number is required');
      }
      if (smsCode.isEmpty) {
        throw Exception('SMS code is required');
      }
      if (name.isEmpty) {
        throw Exception('Name is required');
      }

      // Step 1: Get verification ID (either provided or generate new one)
      String actualVerificationId;
      if (verificationId != null && verificationId.isNotEmpty) {
        actualVerificationId = verificationId;
      } else {
        // Generate new verification ID by sending SMS
        actualVerificationId = await sendSMSVerification(phoneNumber: phoneNumber);
      }
      
      // Step 2: Check if this is auto-verification case
      if (actualVerificationId.startsWith('auto-verified:')) {
        // Auto-verification occurred, user should already be signed in
        final currentUser = currentFirebaseUser;
        if (currentUser == null) {
          throw Exception('Auto-verification completed but no user found');
        }
        debugPrint('Auto-verification detected, user already signed in: ${currentUser.uid}');
      } else {
        // Validate verification ID format
        if (actualVerificationId.isEmpty) {
          throw Exception('Invalid verification ID');
        }
        
        // Normal verification flow
        final userCredential = await verifyAndSignIn(
          verificationId: actualVerificationId,
          smsCode: smsCode,
        );
        
        if (userCredential?.user == null) {
          throw Exception('Firebase sign-in failed');
        }
      }

      // Step 3: Authenticate with Laravel backend
      final user = await authenticateWithBackend(
        name: name,
        preferredSports: preferredSports,
      );

      if (user == null) {
        throw Exception('Backend authentication failed');
      }

      return user;
    } catch (e) {
      debugPrint('Registration error: $e');
      // Clean up Firebase user if backend authentication fails
      if (currentFirebaseUser != null) {
        await signOut();
      }
      rethrow;
    }
  }

  // Sign out from both Firebase and clear local state
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      debugPrint('Successfully signed out');
    } catch (e) {
      debugPrint('Sign out error: $e');
      rethrow;
    }
  }

  // Delete user account from both Firebase and backend
  Future<void> deleteAccount() async {
    try {
      final user = currentFirebaseUser;
      if (user == null) {
        throw Exception('No user to delete');
      }

      // Get ID token for backend deletion
      final idToken = await user.getIdToken();
      if (idToken == null) {
        throw Exception('Failed to get Firebase ID token for deletion');
      }
      
      // Delete from backend first
      await _apiService.deleteFirebaseAccount(idToken: idToken);
      
      // Delete from Firebase (this will be handled by backend)
      debugPrint('Account deletion completed');
    } catch (e) {
      debugPrint('Account deletion error: $e');
      rethrow;
    }
  }

  // Get fresh Firebase ID token
  Future<String?> getIdToken({bool forceRefresh = false}) async {
    try {
      final user = currentFirebaseUser;
      if (user == null) return null;
      
      return await user.getIdToken(forceRefresh);
    } catch (e) {
      debugPrint('Get ID token error: $e');
      return null;
    }
  }

  // Listen to Firebase auth state changes
  void onAuthStateChanged(Function(User?) callback) {
    authStateChanges.listen(callback);
  }

  // Check if phone number is already registered
  Future<bool> isPhoneRegistered(String phoneNumber) async {
    try {
      // This would require a backend endpoint to check phone registration
      // For now, we'll assume it's handled during the registration flow
      return false;
    } catch (e) {
      debugPrint('Phone registration check error: $e');
      return false;
    }
  }

  // Format phone for display
  String formatPhoneForDisplay(String phone) {
    final formatted = formatVietnamesePhone(phone);
    if (formatted.startsWith('+84')) {
      // +84912345678 -> (+84) 91 234 5678
      final digits = formatted.substring(3);
      if (digits.length >= 9) {
        return '(+84) ${digits.substring(0, 2)} ${digits.substring(2, 5)} ${digits.substring(5)}';
      }
    }
    return formatted;
  }
}