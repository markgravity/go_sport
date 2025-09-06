import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// AutoRoute configuration
import 'app_router.dart';

/// Go Sport App configuration with AutoRoute Foundation
/// 
/// This demonstrates AutoRoute foundation setup alongside existing GoRouter
/// Both routing systems can coexist during migration period
class GoSportApp extends ConsumerWidget {
  const GoSportApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Go Sport - AutoRoute Foundation',
      debugShowCheckedModeBanner: false,
      
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
      
      // AutoRoute foundation setup
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.initialRoute,
    );
  }
}