import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import '../models/login_request_model.dart';
import '../models/token_model.dart';
import '../models/user_model.dart';

part 'auth_remote_datasource.g.dart';

@injectable
@RestApi()
abstract class AuthRemoteDataSource {
  @factoryMethod
  factory AuthRemoteDataSource(Dio dio) = _AuthRemoteDataSource;

  @POST("/api/v1/auth/login")
  Future<LoginResponse> login(@Body() LoginRequestModel request);
}

@JsonSerializable()
class LoginResponse {
  final UserModel user;
  final TokenModel tokens;

  LoginResponse({required this.user, required this.tokens});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
