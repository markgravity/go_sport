/// Feature flags for controlling architecture migration
/// 
/// Cho phép switching giữa Riverpod và Cubit architecture trong thời gian migration
/// Hỗ trợ gradual rollout và safe rollback
class FeatureFlags {
  /// Control việc sử dụng Cubit cho authentication thay vì Riverpod
  /// 
  /// `true`: Sử dụng AuthCubit (new architecture)
  /// `false`: Sử dụng AuthProvider (legacy Riverpod)
  static const bool USE_CUBIT_AUTH = true;
  
  /// Control percentage-based rollout cho authentication Cubit
  /// 
  /// Value từ 0.0 (0%) đến 1.0 (100%)
  /// Cho phép gradual rollout đến một phần users
  static const double CUBIT_AUTH_ROLLOUT_PERCENTAGE = 1.0;
  
  /// Enable debug settings để toggle architecture systems
  /// 
  /// `true`: Hiện debug options trong settings
  /// `false`: Ẩn debug options (production mode)
  static const bool ENABLE_ARCHITECTURE_DEBUG = true;
  
  /// Control việc sử dụng AutoRoute thay vì GoRouter
  /// 
  /// `true`: Sử dụng AutoRoute (new routing)
  /// `false`: Sử dụng GoRouter (legacy routing)
  static const bool USE_AUTO_ROUTE = false; // Chưa ready cho production
  
  /// Control việc log architecture transitions
  /// 
  /// `true`: Log state changes và transitions
  /// `false`: Tắt architecture logging
  static const bool LOG_ARCHITECTURE_TRANSITIONS = true;
}

/// Runtime feature flag controller
/// 
/// Cho phép dynamic control feature flags trong debug mode
class RuntimeFeatureFlags {
  static bool _useCubitAuth = FeatureFlags.USE_CUBIT_AUTH;
  static bool _useAutoRoute = FeatureFlags.USE_AUTO_ROUTE;
  static bool _logTransitions = FeatureFlags.LOG_ARCHITECTURE_TRANSITIONS;
  
  /// Get current state của Cubit auth flag
  static bool get useCubitAuth => _useCubitAuth;
  
  /// Get current state của AutoRoute flag
  static bool get useAutoRoute => _useAutoRoute;
  
  /// Get current state của logging flag
  static bool get logTransitions => _logTransitions;
  
  /// Toggle Cubit auth flag (debug mode only)
  static void toggleCubitAuth() {
    if (FeatureFlags.ENABLE_ARCHITECTURE_DEBUG) {
      _useCubitAuth = !_useCubitAuth;
    }
  }
  
  /// Toggle AutoRoute flag (debug mode only)
  static void toggleAutoRoute() {
    if (FeatureFlags.ENABLE_ARCHITECTURE_DEBUG) {
      _useAutoRoute = !_useAutoRoute;
    }
  }
  
  /// Toggle logging flag (debug mode only)
  static void toggleLogging() {
    if (FeatureFlags.ENABLE_ARCHITECTURE_DEBUG) {
      _logTransitions = !_logTransitions;
    }
  }
  
  /// Set Cubit auth flag programmatically
  static void setCubitAuth(bool enabled) {
    if (FeatureFlags.ENABLE_ARCHITECTURE_DEBUG) {
      _useCubitAuth = enabled;
    }
  }
  
  /// Reset all flags to compile-time defaults
  static void resetToDefaults() {
    if (FeatureFlags.ENABLE_ARCHITECTURE_DEBUG) {
      _useCubitAuth = FeatureFlags.USE_CUBIT_AUTH;
      _useAutoRoute = FeatureFlags.USE_AUTO_ROUTE;
      _logTransitions = FeatureFlags.LOG_ARCHITECTURE_TRANSITIONS;
    }
  }
  
  /// Get flag status summary (for debugging)
  static Map<String, bool> getStatusSummary() {
    return {
      'useCubitAuth': _useCubitAuth,
      'useAutoRoute': _useAutoRoute,
      'logTransitions': _logTransitions,
      'debugEnabled': FeatureFlags.ENABLE_ARCHITECTURE_DEBUG,
    };
  }
}