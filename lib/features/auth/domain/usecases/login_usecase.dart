import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

@injectable
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, User>> call(LoginParams params) async {
    return await repository.login(params.email, params.password, params.tenantId);
  }
}

class LoginParams {
  final String email;
  final String password;
  final String tenantId;

  LoginParams({required this.email, required this.password, required this.tenantId});
}
