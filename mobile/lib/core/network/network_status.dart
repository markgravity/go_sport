import 'package:flutter_bloc/flutter_bloc.dart';
import 'api_client.dart';

enum NetworkConnectionStatus {
  connected,
  disconnected,
  checking,
  error,
}

/// Cubit for managing network connection status
/// 
/// Provides real-time network connectivity status using API health checks
class NetworkStatusCubit extends Cubit<NetworkConnectionStatus> {
  final ApiClient _apiClient;
  
  NetworkStatusCubit(this._apiClient) : super(NetworkConnectionStatus.checking) {
    checkConnection();
  }

  /// Check current network connection status
  Future<void> checkConnection() async {
    emit(NetworkConnectionStatus.checking);
    
    try {
      await _apiClient.healthCheck();
      emit(NetworkConnectionStatus.connected);
    } catch (e) {
      emit(NetworkConnectionStatus.disconnected);
    }
  }

  /// Check if currently connected
  Future<bool> isConnected() async {
    try {
      await _apiClient.healthCheck();
      emit(NetworkConnectionStatus.connected);
      return true;
    } catch (e) {
      emit(NetworkConnectionStatus.disconnected);
      return false;
    }
  }

  /// Force reconnection check
  Future<void> reconnect() async {
    await checkConnection();
  }
}

// NetworkStatusCubit is available through GetIt dependency injection
// Use getIt<NetworkStatusCubit>() to access the instance