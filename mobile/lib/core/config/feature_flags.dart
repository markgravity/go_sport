/// Feature flags for controlling app behavior
/// 
/// Production-ready flags for the Go Sport Vietnamese app
class FeatureFlags {
  /// AutoRoute is the primary routing system
  /// 
  /// `true`: AutoRoute is enabled (production ready)
  /// `false`: Fallback routing (for emergency only)
  static const bool useAutoRoute = true; // Production ready
  
  /// Enable debug settings for development
  /// 
  /// `true`: Show debug options in settings
  /// `false`: Hide debug options (production mode)
  static const bool enableArchitectureDebug = false; // Set to false for production
  
  /// Control logging of state transitions
  /// 
  /// `true`: Log state changes and transitions
  /// `false`: Disable architecture logging
  static const bool logArchitectureTransitions = false; // Set to false for production
}

/// Runtime feature flag controller
/// 
/// Allows dynamic control of feature flags in debug mode
class RuntimeFeatureFlags {
  static bool _useAutoRoute = FeatureFlags.useAutoRoute;
  static bool _logTransitions = FeatureFlags.logArchitectureTransitions;
  
  /// Get current state of AutoRoute flag
  static bool get useAutoRoute => _useAutoRoute;
  
  /// Get current state of logging flag
  static bool get logTransitions => _logTransitions;
  
  /// Toggle AutoRoute flag (debug mode only)
  static void toggleAutoRoute() {
    if (FeatureFlags.enableArchitectureDebug) {
      _useAutoRoute = !_useAutoRoute;
    }
  }
  
  /// Toggle logging flag (debug mode only)
  static void toggleLogging() {
    if (FeatureFlags.enableArchitectureDebug) {
      _logTransitions = !_logTransitions;
    }
  }
  
  /// Reset all flags to compile-time defaults
  static void resetToDefaults() {
    if (FeatureFlags.enableArchitectureDebug) {
      _useAutoRoute = FeatureFlags.useAutoRoute;
      _logTransitions = FeatureFlags.logArchitectureTransitions;
    }
  }
  
  /// Get flag status summary (for debugging)
  static Map<String, bool> getStatusSummary() {
    return {
      'useAutoRoute': _useAutoRoute,
      'logTransitions': _logTransitions,
      'debugEnabled': FeatureFlags.enableArchitectureDebug,
    };
  }
}