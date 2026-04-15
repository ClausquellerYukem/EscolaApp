import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/student.dart';
import '../../domain/repositories/student_repository.dart';

@Injectable(as: StudentRepository)
class StudentRepositoryImpl implements StudentRepository {
  @override
  Future<Either<Failure, List<Student>>> getStudentsByGuardian() async {
    return const Right([]);
  }
}
