import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'auth_interceptor.dart';
import 'tenant_interceptor.dart';

@singleton
class ApiClient {
  final Dio dio;

  ApiClient(this.dio, AuthInterceptor authInterceptor, TenantInterceptor tenantInterceptor) {
    dio.interceptors.addAll([
      tenantInterceptor,
      authInterceptor,
      LogInterceptor(responseBody: true, requestBody: true),
    ]);
  }
}
