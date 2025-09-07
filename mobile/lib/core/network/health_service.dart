import 'package:injectable/injectable.dart';
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

@injectable
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

// HealthService is available through GetIt dependency injection
// Use getIt<HealthService>() to access the instance