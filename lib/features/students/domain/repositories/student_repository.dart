import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/student.dart';

abstract class StudentRepository {
  Future<Either<Failure, List<Student>>> getStudentsByGuardian();
}
