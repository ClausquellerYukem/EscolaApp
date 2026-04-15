import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/student.dart';
import '../repositories/student_repository.dart';

@injectable
class GetStudentsByGuardianUseCase {
  final StudentRepository repository;

  GetStudentsByGuardianUseCase(this.repository);

  Future<Either<Failure, List<Student>>> call() async {
    return await repository.getStudentsByGuardian();
  }
}
