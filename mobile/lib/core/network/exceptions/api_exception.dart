enum ApiExceptionType {
  networkTimeout,
  networkError,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  validationError,
  tooManyRequests,
  serverError,
  requestCancelled,
  unknown,
}

class ApiException implements Exception {
  final String message;
  final ApiExceptionType type;
  final int? statusCode;
  final dynamic errors;

  ApiException({
    required this.message,
    required this.type,
    this.statusCode,
    this.errors,
  });

  @override
  String toString() {
    return 'ApiException: $message (Status: $statusCode, Type: $type)';
  }

  bool get isNetworkError => type == ApiExceptionType.networkError || 
                           type == ApiExceptionType.networkTimeout;

  bool get isServerError => type == ApiExceptionType.serverError;

  bool get isClientError => type == ApiExceptionType.badRequest ||
                          type == ApiExceptionType.unauthorized ||
                          type == ApiExceptionType.forbidden ||
                          type == ApiExceptionType.notFound ||
                          type == ApiExceptionType.validationError ||
                          type == ApiExceptionType.tooManyRequests;

  bool get requiresAuth => type == ApiExceptionType.unauthorized;

  bool get canRetry => isNetworkError || isServerError;
}