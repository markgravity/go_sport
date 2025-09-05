import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api_client.dart';
import 'exceptions/api_exception.dart';

class HealthCheckResult {
  final bool isHealthy;
  final String status;
  final Map<String, dynamic>? details;
  final String? error;

  HealthCheckResult({
    required this.isHealthy,
    required this.status,
    this.details,
    this.error,
  });

  factory HealthCheckResult.success(Map<String, dynamic> data) {
    return HealthCheckResult(
      isHealthy: true,
      status: data['status']?.toString() ?? 'OK',
      details: data,
    );
  }

  factory HealthCheckResult.failure(String error) {
    return HealthCheckResult(
      isHealthy: false,
      status: 'ERROR',
      error: error,
    );
  }
}

class HealthService {
  final ApiClient _apiClient;

  HealthService(this._apiClient);

  Future<HealthCheckResult> checkHealth() async {
    try {
      final response = await _apiClient.healthCheck();
      return HealthCheckResult.success(response);
    } on ApiException catch (e) {
      return HealthCheckResult.failure(e.message);
    } catch (e) {
      return HealthCheckResult.failure('Lỗi kết nối không xác định: ${e.toString()}');
    }
  }

  Future<bool> isServerHealthy() async {
    try {
      final result = await checkHealth();
      return result.isHealthy;
    } catch (e) {
      return false;
    }
  }
}

// Provider for health service
final healthServiceProvider = Provider<HealthService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return HealthService(apiClient);
});

// Provider for health check result
final healthCheckProvider = FutureProvider<HealthCheckResult>((ref) async {
  final healthService = ref.watch(healthServiceProvider);
  return await healthService.checkHealth();
});