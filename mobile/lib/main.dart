import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/theme/app_theme.dart';
import 'widgets/go_sport_logo.dart';
import 'widgets/connection_status_indicator.dart';
import 'features/auth/screens/phone_registration_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/providers/auth_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'firebase_options.dart';
// New GetIt dependency injection
import 'core/dependency_injection/injection_container.dart';
// AutoRoute app for coexistence testing
import 'app/app.dart' as auto_route_app;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Hive for local storage
  await Hive.initFlutter();

  // Initialize GetIt dependency injection (alongside existing Riverpod)
  await configureDependencies();

  runApp(
    const ProviderScope( // Keep existing Riverpod
      child: AppSelector(),
    ),
  );
}

/// App Selector để demo coexistence của GoRouter và AutoRoute
/// 
/// Trong production, chỉ một routing system sẽ được sử dụng
/// Đây là để demonstration migration foundation setup
class AppSelector extends StatefulWidget {
  const AppSelector({super.key});

  @override
  State<AppSelector> createState() => _AppSelectorState();
}

class _AppSelectorState extends State<AppSelector> {
  bool useAutoRoute = false; // Switch between routing systems

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go Sport - Routing Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4A90E2),
          foregroundColor: Colors.white,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Go Sport - Migration Demo'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.route,
                size: 80,
                color: Color(0xFF4A90E2),
              ),
              const SizedBox(height: 32),
              
              const Text(
                'Routing System Coexistence Demo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'Cả GoRouter (hiện tại) và AutoRoute (mới) đã được setup thành công và có thể hoạt động song song trong thời gian migration.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF64748B),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              const SizedBox(height: 48),
              
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.settings,
                            color: Color(0xFF4A90E2),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Chọn hệ thống routing:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Switch(
                            value: useAutoRoute,
                            onChanged: (value) {
                              setState(() {
                                useAutoRoute = value;
                              });
                            },
                            activeColor: const Color(0xFF4A90E2),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        useAutoRoute ? 'AutoRoute (Mới)' : 'GoRouter (Hiện tại)',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to the selected app
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => useAutoRoute
                          ? const auto_route_app.GoSportApp()
                          : const GoSportApp(),
                    ),
                  );
                },
                icon: const Icon(Icons.launch, color: Colors.white),
                label: const Text(
                  'Khởi chạy ứng dụng',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A90E2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GoSportApp extends ConsumerWidget {
  const GoSportApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Go Sport',
      debugShowCheckedModeBanner: false,
      
      // Localization
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi', 'VN'), // Vietnamese
        Locale('en', 'US'), // English fallback
      ],
      locale: const Locale('vi', 'VN'), // Default to Vietnamese
      
      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final authState = ref.watch(authProvider);
    
    return Scaffold(
      body: Column(
        children: [
          const ConnectionStatusIndicator(),
          Expanded(
            child: Container(
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
                      // Go Sport Logo/Branding
                      const GoSportLogo(
                        size: 120,
                        showText: false,
                        variant: LogoVariant.primary,
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // App Title
                      Text(
                        l10n.appTitle,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Welcome Message
                      Text(
                        l10n.welcomeMessage,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                
                const SizedBox(height: 48),
                
                // Authentication or Navigation Cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      if (!authState.isAuthenticated) ...[
                        // Authentication Buttons
                        _buildAuthButton(
                          'Đăng ký tài khoản',
                          Icons.person_add,
                          Colors.white,
                          const Color(0xFF2E5BDA),
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PhoneRegistrationScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildAuthButton(
                          'Đăng nhập',
                          Icons.login,
                          Colors.transparent,
                          Colors.white,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          borderColor: Colors.white,
                        ),
                      ] else ...[
                        // Main Navigation Cards
                        _buildNavigationCard(
                          l10n.groupsTab,
                          Icons.group,
                          () {
                            // TODO: Navigate to groups
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildNavigationCard(
                          l10n.attendanceTab,
                          Icons.how_to_reg,
                          () {
                            // TODO: Navigate to attendance
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildNavigationCard(
                          l10n.paymentsTab,
                          Icons.payment,
                          () {
                            // TODO: Navigate to payments
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationCard(String title, IconData icon, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: const Color(0xFF3A7BD5),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xFF64748B),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthButton(
    String title,
    IconData icon,
    Color backgroundColor,
    Color textColor,
    VoidCallback onTap, {
    Color? borderColor,
  }) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: borderColor != null 
            ? Border.all(color: borderColor, width: 2)
            : null,
        boxShadow: backgroundColor != Colors.transparent
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: textColor,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor,
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