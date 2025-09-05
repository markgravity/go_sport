import 'package:dio/dio.dart';
import 'dart:math';

class RetryInterceptor extends Interceptor {
  static const int maxRetries = 3;
  static const Duration baseDelay = Duration(seconds: 1);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err) && _getRetryCount(err.requestOptions) < maxRetries) {
      await _performRetry(err, handler);
    } else {
      super.onError(err, handler);
    }
  }

  bool _shouldRetry(DioException err) {
    // Retry on network errors and server errors (5xx)
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return true;
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        return statusCode != null && statusCode >= 500;
      default:
        return false;
    }
  }

  int _getRetryCount(RequestOptions requestOptions) {
    return requestOptions.extra['retryCount'] as int? ?? 0;
  }

  void _setRetryCount(RequestOptions requestOptions, int count) {
    requestOptions.extra['retryCount'] = count;
  }

  Future<void> _performRetry(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final retryCount = _getRetryCount(err.requestOptions) + 1;
    _setRetryCount(err.requestOptions, retryCount);

    // Calculate exponential backoff delay with jitter
    final delayMs = _calculateDelay(retryCount);
    await Future.delayed(Duration(milliseconds: delayMs));

    try {
      // Create a new Dio instance to avoid interceptor conflicts
      final dio = Dio();
      
      // Copy interceptors except retry interceptor to avoid infinite recursion
      for (final interceptor in err.requestOptions.extra['dio_interceptors'] ?? <Interceptor>[]) {
        if (interceptor is! RetryInterceptor) {
          dio.interceptors.add(interceptor);
        }
      }

      final response = await dio.request(
        err.requestOptions.path,
        data: err.requestOptions.data,
        queryParameters: err.requestOptions.queryParameters,
        options: Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers,
          contentType: err.requestOptions.contentType,
          responseType: err.requestOptions.responseType,
          receiveTimeout: err.requestOptions.receiveTimeout,
          sendTimeout: err.requestOptions.sendTimeout,
        ),
      );

      handler.resolve(response);
    } catch (retryError) {
      if (retryError is DioException) {
        _setRetryCount(retryError.requestOptions, retryCount);
        onError(retryError, handler);
      } else {
        super.onError(err, handler);
      }
    }
  }

  int _calculateDelay(int retryCount) {
    // Exponential backoff with jitter
    final exponentialDelay = baseDelay.inMilliseconds * pow(2, retryCount - 1);
    final jitter = Random().nextInt(1000); // Add up to 1 second of jitter
    return (exponentialDelay + jitter).toInt();
  }
}