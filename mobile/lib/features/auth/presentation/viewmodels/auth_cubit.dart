import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../models/user_model.dart';
import '../../models/auth_tokens.dart';
import '../../services/firebase_auth_service.dart';
import '../../services/api_service.dart';
import 'auth_state.dart';

/// AuthCubit cho Go Sport authentication system
/// 
/// Migrate từ AuthProvider sang Cubit architecture với:
/// - Vietnamese phone validation
/// - Firebase SMS authentication
/// - Token refresh và session management
/// - Cultural error messages
@injectable
class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuthService _firebaseAuthService;

  AuthCubit({
    required FirebaseAuthService firebaseAuthService,
    required ApiService apiService,
  })  : _firebaseAuthService = firebaseAuthService,
        super(const AuthState.unauthenticated()) {
    _initializeAuth();
  }

  /// Khởi tạo authentication state khi app bắt đầu
  Future<void> _initializeAuth() async {
    try {
      emit(const AuthState.authenticating(message: 'Đang kiểm tra phiên đăng nhập...'));
      
      final firebaseUser = _firebaseAuthService.currentFirebaseUser;
      
      if (firebaseUser != null) {
        // User đã đăng nhập Firebase, kiểm tra backend authentication
        await _authenticateWithBackend();
      } else {
        // Chưa có Firebase user, trạng thái unauthenticated
        emit(const AuthState.unauthenticated());
      }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint('AuthCubit initialization error: $error');
        debugPrint('Stack trace: $stackTrace');
      }
      emit(AuthState.error(
        message: _getVietnameseErrorMessage(error),
        errorCode: 'INIT_ERROR',
      ));
    }
  }

  /// Xác thực với backend API sau khi đã có Firebase user
  Future<void> _authenticateWithBackend({
    String? name,
    List<String>? preferredSports,
  }) async {
    try {
      final user = await _firebaseAuthService.authenticateWithBackend(
        name: name,
        preferredSports: preferredSports,
      );

      if (user != null) {
        final idToken = await _firebaseAuthService.getIdToken();
        
        if (idToken != null) {
          final tokens = AuthTokens(
            firebaseIdToken: idToken,
            laravelToken: '', // Sẽ được trả về từ backend
            firebaseUid: user.firebaseUid ?? '',
            expiresAt: DateTime.now().add(const Duration(hours: 1)),
          );

          emit(AuthState.authenticated(user: user, tokens: tokens));
          
          if (kDebugMode) {
            debugPrint('AuthCubit: Backend authentication successful for user ${user.name}');
          }
        } else {
          throw Exception('Không thể lấy Firebase ID token');
        }
      } else {
        throw Exception('Xác thực backend không thành công');
      }
    } catch (error) {
      emit(AuthState.error(
        message: _getVietnameseErrorMessage(error),
        errorCode: 'BACKEND_AUTH_ERROR',
      ));
      
      // Sign out từ Firebase nếu backend auth thất bại
      await _firebaseAuthService.signOut();
    }
  }

  /// Gửi mã xác thực SMS đến số điện thoại Vietnamese
  /// 
  /// [phoneNumber] - Số điện thoại Vietnamese (format: +84xxxxxxxxx)
  /// Trả về verification ID nếu thành công
  Future<String?> sendVerificationCode(String phoneNumber) async {
    try {
      emit(const AuthState.authenticating(
        message: 'Đang gửi mã xác thực SMS...',
      ));
      
      final verificationId = await _firebaseAuthService.sendSMSVerification(
        phoneNumber: phoneNumber,
      );
      
      emit(AuthState.phoneVerificationRequired(
        phoneNumber: phoneNumber,
        verificationId: verificationId,
      ));
      
      if (kDebugMode) {
        debugPrint('AuthCubit: SMS sent to $phoneNumber, verification ID: $verificationId');
      }
      
      return verificationId;
    } catch (error) {
      if (kDebugMode) {
        debugPrint('AuthCubit SMS sending error: $error');
      }
      
      emit(AuthState.error(
        message: _getVietnameseSMSErrorMessage(error),
        errorCode: 'SMS_SEND_ERROR',
      ));
      return null;
    }
  }

  /// Hoàn thành đăng ký với mã SMS verification
  /// 
  /// [phoneNumber] - Số điện thoại Vietnamese
  /// [verificationId] - Firebase verification ID
  /// [smsCode] - Mã SMS 6 digits
  /// [name] - Tên người dùng
  /// [preferredSports] - Danh sách thể thao yêu thích (optional)
  Future<bool> completeRegistration({
    required String phoneNumber,
    required String verificationId,
    required String smsCode,
    required String name,
    List<String>? preferredSports,
  }) async {
    try {
      emit(const AuthState.authenticating(
        message: 'Đang xác thực và tạo tài khoản...',
      ));
      
      final user = await _firebaseAuthService.completeRegistration(
        phoneNumber: phoneNumber,
        verificationId: verificationId,
        smsCode: smsCode,
        name: name,
        preferredSports: preferredSports,
      );

      final idToken = await _firebaseAuthService.getIdToken();
      
      if (idToken != null) {
        final tokens = AuthTokens(
          firebaseIdToken: idToken,
          laravelToken: '', // Sẽ được trả về từ backend
          firebaseUid: user.firebaseUid ?? '',
          expiresAt: DateTime.now().add(const Duration(hours: 1)),
        );

        emit(AuthState.authenticated(user: user, tokens: tokens));
        
        if (kDebugMode) {
          debugPrint('AuthCubit: Registration completed for ${user.name} with phone $phoneNumber');
        }
        
        return true;
      } else {
        throw Exception('Không thể lấy Firebase ID token sau đăng ký');
      }
    } catch (error) {
      if (kDebugMode) {
        debugPrint('AuthCubit registration error: $error');
      }
      
      emit(AuthState.error(
        message: _getVietnameseRegistrationErrorMessage(error),
        errorCode: 'REGISTRATION_ERROR',
      ));
      return false;
    }
  }

  /// Đăng xuất người dùng
  Future<void> signOut() async {
    try {
      emit(const AuthState.authenticating(message: 'Đang đăng xuất...'));
      
      await _firebaseAuthService.signOut();
      emit(const AuthState.unauthenticated());
      
      if (kDebugMode) {
        debugPrint('AuthCubit: User signed out successfully');
      }
    } catch (error) {
      if (kDebugMode) {
        debugPrint('AuthCubit sign out error: $error');
      }
      
      emit(AuthState.error(
        message: 'Có lỗi xảy ra khi đăng xuất. Vui lòng thử lại.',
        errorCode: 'SIGNOUT_ERROR',
      ));
    }
  }

  /// Xóa tài khoản người dùng
  Future<bool> deleteAccount() async {
    try {
      emit(const AuthState.authenticating(message: 'Đang xóa tài khoản...'));
      
      await _firebaseAuthService.deleteAccount();
      emit(const AuthState.unauthenticated());
      
      if (kDebugMode) {
        debugPrint('AuthCubit: Account deleted successfully');
      }
      
      return true;
    } catch (error) {
      if (kDebugMode) {
        debugPrint('AuthCubit account deletion error: $error');
      }
      
      emit(AuthState.error(
        message: 'Có lỗi xảy ra khi xóa tài khoản. Vui lòng thử lại.',
        errorCode: 'DELETE_ACCOUNT_ERROR',
      ));
      return false;
    }
  }

  /// Làm mới thông tin user và tokens
  Future<void> refreshUser() async {
    final currentState = state;
    
    // Chỉ refresh khi đã authenticated
    if (!currentState.isAuthenticated || currentState.currentUser == null) {
      return;
    }
    
    try {
      emit(AuthState.refreshingToken(
        user: currentState.currentUser!,
        tokens: currentState.currentTokens!,
      ));
      
      // Làm mới Firebase token
      final idToken = await _firebaseAuthService.getIdToken(forceRefresh: true);
      
      if (idToken != null && currentState.currentTokens != null) {
        final updatedTokens = currentState.currentTokens!.copyWith(
          firebaseIdToken: idToken,
          expiresAt: DateTime.now().add(const Duration(hours: 1)),
        );
        
        emit(AuthState.authenticated(
          user: currentState.currentUser!,
          tokens: updatedTokens,
        ));
        
        if (kDebugMode) {
          debugPrint('AuthCubit: Token refreshed successfully');
        }
      } else {
        throw Exception('Không thể làm mới token');
      }
    } catch (error) {
      if (kDebugMode) {
        debugPrint('AuthCubit token refresh error: $error');
      }
      
      emit(AuthState.error(
        message: 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
        errorCode: 'TOKEN_REFRESH_ERROR',
      ));
    }
  }

  /// Xóa lỗi hiện tại
  void clearError() {
    if (state.hasError) {
      emit(const AuthState.unauthenticated());
    }
  }

  /// Kiểm tra tokens có hợp lệ và chưa hết hạn không
  bool get hasValidTokens {
    final tokens = state.currentTokens;
    return tokens != null && tokens.isValid;
  }

  /// Lấy user hiện tại
  UserModel? get currentUser => state.currentUser;

  /// Kiểm tra trạng thái authenticated
  bool get isAuthenticated => state.isAuthenticated && hasValidTokens;

  /// Transform error thành thông báo tiếng Việt cho authentication
  String _getVietnameseErrorMessage(Object error) {
    final errorString = error.toString().toLowerCase();
    
    if (errorString.contains('network') || errorString.contains('connection')) {
      return 'Không thể kết nối đến máy chủ. Kiểm tra kết nối internet và thử lại.';
    }
    
    if (errorString.contains('timeout')) {
      return 'Kết nối quá chậm. Vui lòng thử lại.';
    }
    
    if (errorString.contains('firebase')) {
      return 'Có lỗi xảy ra với hệ thống xác thực. Vui lòng thử lại sau.';
    }
    
    return 'Có lỗi xảy ra. Vui lòng thử lại.';
  }

  /// Transform SMS error thành thông báo tiếng Việt
  String _getVietnameseSMSErrorMessage(Object error) {
    final errorString = error.toString().toLowerCase();
    
    if (errorString.contains('invalid-phone-number')) {
      return 'Số điện thoại không hợp lệ. Vui lòng nhập số điện thoại Việt Nam.';
    }
    
    if (errorString.contains('too-many-requests')) {
      return 'Bạn đã gửi quá nhiều yêu cầu. Vui lòng chờ một lúc rồi thử lại.';
    }
    
    if (errorString.contains('quota-exceeded')) {
      return 'Hệ thống đang quá tải. Vui lòng thử lại sau.';
    }
    
    return 'Không thể gửi mã xác thực SMS. Kiểm tra số điện thoại và thử lại.';
  }

  /// Transform registration error thành thông báo tiếng Việt
  String _getVietnameseRegistrationErrorMessage(Object error) {
    final errorString = error.toString().toLowerCase();
    
    if (errorString.contains('invalid-verification-code')) {
      return 'Mã xác thực không đúng. Vui lòng kiểm tra và nhập lại.';
    }
    
    if (errorString.contains('code-expired')) {
      return 'Mã xác thực đã hết hạn. Vui lòng gửi lại mã mới.';
    }
    
    if (errorString.contains('phone-already-exists')) {
      return 'Số điện thoại này đã được đăng ký. Vui lòng đăng nhập hoặc sử dụng số khác.';
    }
    
    return 'Không thể tạo tài khoản. Vui lòng thử lại.';
  }

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    
    if (kDebugMode) {
      debugPrint('AuthCubit state changed: ${change.currentState.runtimeType} -> ${change.nextState.runtimeType}');
    }
  }

  @override
  Future<void> close() {
    if (kDebugMode) {
      debugPrint('AuthCubit closed');
    }
    return super.close();
  }
}