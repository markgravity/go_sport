import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/theme/app_theme.dart';
import 'widgets/go_sport_logo.dart';
import 'widgets/connection_status_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for local storage
  await Hive.initFlutter();

  runApp(
    const ProviderScope(
      child: GoSportApp(),
    ),
  );
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
                
                // Basic Navigation Cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
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
            color: Colors.black.withOpacity(0.1),
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
}