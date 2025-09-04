import 'package:flutter/foundation.dart';
import 'main.dart' as main_app;

/// Development entry point với Vietnamese development configuration
void main() {
  // Development-specific configuration
  if (kDebugMode) {
    print('🚀 Starting Go Sport App - Development Mode');
    print('🌍 Locale: Vietnamese (vi)');
    print('🔗 API: Local Laravel (http://localhost:8000)');
  }
  
  main_app.main();
}