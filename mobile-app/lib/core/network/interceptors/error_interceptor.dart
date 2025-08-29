import 'package:dio/dio.dart';
import '../exceptions/api_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    ApiException apiException;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        apiException = ApiException(
          message: 'Kết nối chậm hoặc không ổn định. Vui lòng kiểm tra mạng và thử lại.',
          type: ApiExceptionType.networkTimeout,
          statusCode: null,
        );
        break;
      case DioExceptionType.badResponse:
        apiException = _handleResponseError(err);
        break;
      case DioExceptionType.cancel:
        apiException = ApiException(
          message: 'Yêu cầu đã bị hủy.',
          type: ApiExceptionType.requestCancelled,
          statusCode: null,
        );
        break;
      case DioExceptionType.connectionError:
        apiException = ApiException(
          message: 'Không thể kết nối đến máy chủ. Vui lòng kiểm tra kết nối mạng.',
          type: ApiExceptionType.networkError,
          statusCode: null,
        );
        break;
      case DioExceptionType.badCertificate:
        apiException = ApiException(
          message: 'Lỗi bảo mật kết nối. Vui lòng thử lại sau.',
          type: ApiExceptionType.networkError,
          statusCode: null,
        );
        break;
      case DioExceptionType.unknown:
        apiException = ApiException(
          message: 'Đã xảy ra lỗi không xác định. Vui lòng thử lại.',
          type: ApiExceptionType.unknown,
          statusCode: null,
        );
        break;
    }

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: apiException,
        type: err.type,
        response: err.response,
      ),
    );
  }

  ApiException _handleResponseError(DioException err) {
    final statusCode = err.response?.statusCode;
    String message;
    ApiExceptionType type;

    switch (statusCode) {
      case 400:
        message = 'Yêu cầu không hợp lệ. Vui lòng kiểm tra thông tin và thử lại.';
        type = ApiExceptionType.badRequest;
        break;
      case 401:
        message = 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.';
        type = ApiExceptionType.unauthorized;
        break;
      case 403:
        message = 'Bạn không có quyền truy cập tính năng này.';
        type = ApiExceptionType.forbidden;
        break;
      case 404:
        message = 'Không tìm thấy thông tin yêu cầu.';
        type = ApiExceptionType.notFound;
        break;
      case 422:
        message = _parseValidationErrors(err.response?.data);
        type = ApiExceptionType.validationError;
        break;
      case 429:
        message = 'Quá nhiều yêu cầu. Vui lòng chờ một chút rồi thử lại.';
        type = ApiExceptionType.tooManyRequests;
        break;
      case 500:
      case 502:
      case 503:
      case 504:
        message = 'Máy chủ đang bảo trì. Vui lòng thử lại sau.';
        type = ApiExceptionType.serverError;
        break;
      default:
        message = 'Đã xảy ra lỗi. Vui lòng thử lại sau.';
        type = ApiExceptionType.unknown;
        break;
    }

    return ApiException(
      message: message,
      type: type,
      statusCode: statusCode,
      errors: err.response?.data,
    );
  }

  String _parseValidationErrors(dynamic data) {
    if (data is Map<String, dynamic> && data.containsKey('errors')) {
      final errors = data['errors'] as Map<String, dynamic>;
      final errorMessages = <String>[];
      
      errors.forEach((field, messages) {
        if (messages is List) {
          for (final message in messages) {
            errorMessages.add(message.toString());
          }
        }
      });
      
      return errorMessages.isNotEmpty 
          ? errorMessages.first
          : 'Dữ liệu không hợp lệ.';
    }
    
    return 'Dữ liệu không hợp lệ.';
  }
}