import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/security/session_manager.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/login_request_model.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SessionManager sessionManager;

  AuthRepositoryImpl(this.remoteDataSource, this.sessionManager);

  @override
  Future<Either<Failure, User>> login(String email, String password, String tenantId) async {
    try {
      final response = await remoteDataSource.login(
        LoginRequestModel(email: email, password: password, tenantId: tenantId),
      );

      await sessionManager.saveTokens(
        accessToken: response.tokens.accessToken,
        refreshToken: response.tokens.refreshToken,
      );

      return Right(response.user);
    } on DioException catch (e) {
      if (e.response != null) {
         return Left(ServerFailure(message: e.response?.data['error']['message'] ?? 'Login failed'));
      }
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    await sessionManager.clearTokens();
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> refreshToken() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> loginWithBiometrics(String biometricToken) {
    throw UnimplementedError();
  }
}
