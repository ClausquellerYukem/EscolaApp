import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../security/session_manager.dart';

@injectable
class AuthInterceptor extends Interceptor {
  final SessionManager sessionManager;
  final Dio dio;

  AuthInterceptor(this.sessionManager) : dio = Dio();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await sessionManager.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Implement silent refresh logic here
      // For now, pass the error
    }
    handler.next(err);
  }
}
