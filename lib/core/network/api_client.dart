import 'package:dio/dio.dart';

class ApiClient {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://jsonplaceholder.typicode.com/",
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Accept': 'application/json',
    },
  ));

  // Add authentication token (if required)
  static void setAuthToken(String token) {
    _dio.options.headers["Authorization"] = "Bearer $token";
  }

  // GET Request
  static Future<Response> get(String endpoint, {Map<String, dynamic>? query}) async {
    try {
      return await _dio.get(endpoint, queryParameters: query);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // POST Request
  static Future<Response> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Error Handling
  static String _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return "Connection timeout!";
        case DioExceptionType.receiveTimeout:
          return "Receive timeout!";
        case DioExceptionType.badResponse:
          return "Bad response: ${error.response?.statusCode}";
        case DioExceptionType.cancel:
          return "Request cancelled!";
        default:
          return "Something went wrong!";
      }
    }
    return "Unknown error!";
  }
}
