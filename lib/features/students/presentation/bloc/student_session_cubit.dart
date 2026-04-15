import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/student.dart';

@singleton
class StudentSessionCubit extends Cubit<StudentSessionState> {
  StudentSessionCubit() : super(const StudentSessionState());

  void setActiveStudent(Student student) {
    emit(state.copyWith(activeStudent: student));
  }
}

class StudentSessionState extends Equatable {
  final Student? activeStudent;

  const StudentSessionState({this.activeStudent});

  StudentSessionState copyWith({Student? activeStudent}) {
    return StudentSessionState(
      activeStudent: activeStudent ?? this.activeStudent,
    );
  }

  @override
  List<Object?> get props => [activeStudent];
}
