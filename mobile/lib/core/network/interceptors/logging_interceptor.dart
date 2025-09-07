import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  static int _requestCounter = 0;
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      final requestId = ++_requestCounter;
      final timestamp = DateTime.now().toIso8601String();
      
      print('\n╔══════════════════════════════════════════════════════════════════════════════');
      print('║ 🚀 REQUEST #$requestId [$timestamp]');
      print('║ ${options.method} ${options.baseUrl}${options.path}');
      print('╟──────────────────────────────────────────────────────────────────────────────');
      
      // Request Headers
      if (options.headers.isNotEmpty) {
        print('║ 📋 Headers:');
        options.headers.forEach((key, value) {
          print('║   $key: $value');
        });
        print('║');
      }
      
      // Query Parameters
      if (options.queryParameters.isNotEmpty) {
        print('║ 🔗 Query Parameters:');
        options.queryParameters.forEach((key, value) {
          print('║   $key: $value');
        });
        print('║');
      }
      
      // Request Body
      if (options.data != null) {
        print('║ 📤 Request Body:');
        final bodyString = _formatData(options.data);
        bodyString.split('\n').forEach((line) {
          print('║   $line');
        });
        print('║');
      }
      
      print('╚══════════════════════════════════════════════════════════════════════════════\n');
      
      // Store request start time for duration calculation
      options.extra['requestStartTime'] = DateTime.now().millisecondsSinceEpoch;
      options.extra['requestId'] = requestId;
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      final requestId = response.requestOptions.extra['requestId'] ?? 0;
      final startTime = response.requestOptions.extra['requestStartTime'] as int?;
      final duration = startTime != null 
          ? DateTime.now().millisecondsSinceEpoch - startTime 
          : 0;
      final timestamp = DateTime.now().toIso8601String();
      
      print('\n╔══════════════════════════════════════════════════════════════════════════════');
      print('║ ✅ RESPONSE #$requestId [$timestamp] (${duration}ms)');
      print('║ ${response.statusCode} ${response.statusMessage}');
      print('║ ${response.requestOptions.method} ${response.requestOptions.baseUrl}${response.requestOptions.path}');
      print('╟──────────────────────────────────────────────────────────────────────────────');
      
      // Response Headers
      if (response.headers.map.isNotEmpty) {
        print('║ 📋 Response Headers:');
        response.headers.map.forEach((key, values) {
          print('║   $key: ${values.join(', ')}');
        });
        print('║');
      }
      
      // Response Body
      if (response.data != null) {
        print('║ 📥 Response Body:');
        final bodyString = _formatData(response.data);
        bodyString.split('\n').forEach((line) {
          print('║   $line');
        });
        print('║');
      }
      
      print('╚══════════════════════════════════════════════════════════════════════════════\n');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      final requestId = err.requestOptions.extra['requestId'] ?? 0;
      final startTime = err.requestOptions.extra['requestStartTime'] as int?;
      final duration = startTime != null 
          ? DateTime.now().millisecondsSinceEpoch - startTime 
          : 0;
      final timestamp = DateTime.now().toIso8601String();
      
      print('\n╔══════════════════════════════════════════════════════════════════════════════');
      print('║ ❌ ERROR #$requestId [$timestamp] (${duration}ms)');
      print('║ ${err.response?.statusCode ?? 'NO_STATUS'} ${err.response?.statusMessage ?? err.type.toString()}');
      print('║ ${err.requestOptions.method} ${err.requestOptions.baseUrl}${err.requestOptions.path}');
      print('╟──────────────────────────────────────────────────────────────────────────────');
      
      // Error Information
      print('║ 🚨 Error Type: ${err.type}');
      if (err.message != null) {
        print('║ 💬 Error Message: ${err.message}');
      }
      
      // Error Response Headers
      if (err.response?.headers.map.isNotEmpty == true) {
        print('║');
        print('║ 📋 Error Response Headers:');
        err.response!.headers.map.forEach((key, values) {
          print('║   $key: ${values.join(', ')}');
        });
      }
      
      // Error Response Body
      if (err.response?.data != null) {
        print('║');
        print('║ 📥 Error Response Body:');
        final bodyString = _formatData(err.response!.data);
        bodyString.split('\n').forEach((line) {
          print('║   $line');
        });
      }
      
      print('║');
      print('╚══════════════════════════════════════════════════════════════════════════════\n');
    }
    super.onError(err, handler);
  }
  
  String _formatData(dynamic data) {
    if (data == null) return 'null';
    
    if (data is Map || data is List) {
      // Pretty print JSON with proper indentation
      try {
        return _prettyPrintJson(data);
      } catch (e) {
        return data.toString();
      }
    }
    
    return data.toString();
  }
  
  String _prettyPrintJson(dynamic json, [int indent = 0]) {
    final spaces = '  ' * indent;
    
    if (json is Map) {
      if (json.isEmpty) return '{}';
      
      final buffer = StringBuffer('{\n');
      final entries = json.entries.toList();
      
      for (int i = 0; i < entries.length; i++) {
        final entry = entries[i];
        buffer.write('$spaces  "${entry.key}": ');
        
        if (entry.value is Map || entry.value is List) {
          buffer.write(_prettyPrintJson(entry.value, indent + 1));
        } else if (entry.value is String) {
          buffer.write('"${entry.value}"');
        } else {
          buffer.write('${entry.value}');
        }
        
        if (i < entries.length - 1) buffer.write(',');
        buffer.write('\n');
      }
      
      buffer.write('$spaces}');
      return buffer.toString();
    }
    
    if (json is List) {
      if (json.isEmpty) return '[]';
      
      final buffer = StringBuffer('[\n');
      
      for (int i = 0; i < json.length; i++) {
        buffer.write('$spaces  ');
        
        if (json[i] is Map || json[i] is List) {
          buffer.write(_prettyPrintJson(json[i], indent + 1));
        } else if (json[i] is String) {
          buffer.write('"${json[i]}"');
        } else {
          buffer.write('${json[i]}');
        }
        
        if (i < json.length - 1) buffer.write(',');
        buffer.write('\n');
      }
      
      buffer.write('$spaces]');
      return buffer.toString();
    }
    
    return json.toString();
  }
}