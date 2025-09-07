import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../../core/dependency_injection/injection_container.dart';
import '../../../app/auto_router.dart';
import '../services/auth_service.dart';

/// Authentication state wrapper that checks login status on app startup
/// 
/// Automatically redirects users to the appropriate screen based on authentication state
/// NOTE: Not used as a route page anymore - authentication is handled in LoginScreen
class AuthStateWrapper extends StatefulWidget {
  const AuthStateWrapper({super.key});

  @override
  State<AuthStateWrapper> createState() => _AuthStateWrapperState();
}

class _AuthStateWrapperState extends State<AuthStateWrapper> {
  bool _isChecking = true;
  late final AuthService _authService;

  @override
  void initState() {
    super.initState();
    _authService = getIt<AuthService>();
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    try {
      // Check if user has a valid stored token
      final isLoggedIn = await _authService.isLoggedIn();
      
      if (mounted) {
        if (isLoggedIn) {
          // User is logged in, navigate to groups list
          context.router.push(const GroupsListRoute());
        } else {
          // User is not logged in, navigate to login screen
          context.router.push(const LoginRoute());
        }
      }
    } catch (e) {
      // On error, default to login screen
      if (mounted) {
        context.router.push(const LoginRoute());
      }
    }
    
    if (mounted) {
      setState(() {
        _isChecking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking) {
      return const Scaffold(
        backgroundColor: Color(0xFF2E5BDA),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo/Icon
              Icon(
                Icons.sports_soccer,
                size: 80,
                color: Colors.white,
              ),
              SizedBox(height: 24),
              
              // App Name
              Text(
                'Go Sport',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              
              // Tagline
              Text(
                'Kết nối cộng đồng thể thao Việt Nam',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 48),
              
              // Loading indicator
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 3,
              ),
              SizedBox(height: 16),
              
              Text(
                'Đang kiểm tra trạng thái đăng nhập...',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      );
    }
    
    // This should never be reached as we navigate away
    return const SizedBox.shrink();
  }
}