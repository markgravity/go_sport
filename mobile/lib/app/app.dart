import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// AutoRoute configuration
import 'auto_router.dart';
import '../core/services/navigation_service.dart';
import '../core/dependency_injection/injection_container.dart';

/// Go Sport App with AutoRoute navigation
/// 
/// Vietnamese sports group coordination app using AutoRoute for navigation
class GoSportApp extends StatelessWidget {
  const GoSportApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    
    return MaterialApp.router(
      title: 'Go Sport - Vietnamese Sports App',
      debugShowCheckedModeBanner: false,
      
      // Localization setup
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('vi', 'VN'), // Default to Vietnamese
      
      // Theme configuration
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4A90E2),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      
      // AutoRoute configuration with global navigator key
      routerConfig: appRouter.config(
        navigatorKey: NavigationService.navigatorKey,
      ),
    );
  }
}