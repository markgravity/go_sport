import 'package:flutter/foundation.dart';
import 'main.dart' as main_app;

/// Production entry point với Vietnamese production configuration
void main() {
  // Production-specific configuration
  if (kDebugMode) {
    print('🏆 Starting Go Sport App - Production Mode');
    print('🌍 Locale: Vietnamese (vi)');
    print('🔗 API: Production (https://api.gosport.vn)');
  }
  
  // Disable debug banner in production
  main_app.main();
}