import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api_client.dart';

enum NetworkConnectionStatus {
  connected,
  disconnected,
  checking,
  error,
}

class NetworkStatusNotifier extends StateNotifier<NetworkConnectionStatus> {
  final ApiClient _apiClient;
  
  NetworkStatusNotifier(this._apiClient) : super(NetworkConnectionStatus.checking) {
    checkConnection();
  }

  Future<void> checkConnection() async {
    state = NetworkConnectionStatus.checking;
    
    try {
      await _apiClient.healthCheck();
      state = NetworkConnectionStatus.connected;
    } catch (e) {
      state = NetworkConnectionStatus.disconnected;
    }
  }

  Future<bool> isConnected() async {
    try {
      await _apiClient.healthCheck();
      state = NetworkConnectionStatus.connected;
      return true;
    } catch (e) {
      state = NetworkConnectionStatus.disconnected;
      return false;
    }
  }

  void setError() {
    state = NetworkConnectionStatus.error;
  }

  void reset() {
    state = NetworkConnectionStatus.checking;
    checkConnection();
  }
}

// Provider for network status
final networkStatusProvider = StateNotifierProvider<NetworkStatusNotifier, NetworkConnectionStatus>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return NetworkStatusNotifier(apiClient);
});

// Provider for connection status as bool
final isConnectedProvider = Provider<bool>((ref) {
  final status = ref.watch(networkStatusProvider);
  return status == NetworkConnectionStatus.connected;
});