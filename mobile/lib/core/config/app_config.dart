/// Application configuration for different environments (dev, staging, production)
/// Supports Vietnamese localization and API endpoints
class AppConfig {
  static const String _defaultLocale = 'vi';
  
  // Environment detection
  static bool get isDebug {
    bool debug = false;
    assert(debug = true);
    return debug;
  }
  
  static bool get isRelease => !isDebug;
  
  // API Configuration
  static String get apiBaseUrl {
    if (isDebug) {
      // Local development - Laravel Sail
      return 'http://10.0.2.2:80'; // Android emulator
      // For iOS simulator use: 'http://127.0.0.1:80'
    }
    // Production API endpoint
    return 'https://api.gosport.vn';
  }
  
  // Localization
  static String get defaultLocale => _defaultLocale;
  static List<String> get supportedLocales => ['vi', 'en'];
  
  // Vietnamese app configuration
  static const String appName = 'Go Sport';
  static const String appNameVi = 'Go Sport';
  
  // Network configuration
  static const int connectionTimeoutMs = 30000; // 30 seconds
  static const int receiveTimeoutMs = 30000;    // 30 seconds
  static const int maxRetries = 3;
  
  // Vietnamese date/time formats
  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
  
  // Vietnamese currency
  static const String currency = 'VND';
  static const String currencySymbol = '₫';
  
  // Feature flags
  static bool get enableFirebaseMessaging => true;
  static bool get enableCrashlytics => isRelease;
  static bool get enableAnalytics => isRelease;
  
  // Debug settings
  static bool get showDebugBanner => isDebug;
  static bool get logNetworkRequests => isDebug;
}