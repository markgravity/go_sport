import 'package:flutter/material.dart';

// Import screens for routing
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/phone_registration_screen.dart';

/// AutoRoute routing configuration
/// 
/// Centralized routing for Go Sport Vietnamese sports app:
/// 1. Home/Welcome screen
/// 2. Authentication screens (login, register)
/// 3. 404 error handling
/// 4. Vietnamese localization throughout
class AppRouter {
  static const String initialRoute = '/';

  /// Route generator function 
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const WelcomeWrapper(),
          settings: settings,
        );
        
      case '/login':
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
        
      case '/register':
        return MaterialPageRoute(
          builder: (_) => const PhoneRegistrationScreen(),
          settings: settings,
        );
        
      default:
        return MaterialPageRoute(
          builder: (_) => const NotFoundWrapper(),
          settings: settings,
        );
    }
  }
}

/// Home screen với Vietnamese localization và AutoRoute integration
class WelcomeWrapper extends StatelessWidget {
  const WelcomeWrapper({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4A90E2), // Primary start
              Color(0xFF2E5BDA), // Primary end
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo
                const Icon(
                  Icons.sports_soccer,
                  size: 120,
                  color: Colors.white,
                ),
                
                const SizedBox(height: 32),
                
                // App Title
                const Text(
                  'Go Sport',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Subtitle
                const Text(
                  'Ứng dụng quản lý nhóm thể thao Việt Nam',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 48),
                
                // Authentication Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          icon: const Icon(Icons.login, color: Color(0xFF2E5BDA)),
                          label: const Text(
                            'Đăng nhập',
                            style: TextStyle(
                              color: Color(0xFF2E5BDA),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 2,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Register Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          icon: const Icon(Icons.person_add, color: Colors.white),
                          label: const Text(
                            'Đăng ký tài khoản',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white, width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 404 Not Found screen
class NotFoundWrapper extends StatelessWidget {
  const NotFoundWrapper({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Không tìm thấy trang'),
        backgroundColor: const Color(0xFF4A90E2),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Color(0xFFEF4444),
            ),
            const SizedBox(height: 16),
            const Text(
              'Không tìm thấy trang',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Trang bạn tìm kiếm không tồn tại',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
              icon: const Icon(Icons.home, color: Colors.white),
              label: const Text(
                'Về trang chủ',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A90E2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}