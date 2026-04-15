import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final String id;
  final String name;
  final String className;
  final String grade;
  final String? avatarUrl;

  const Student({
    required this.id,
    required this.name,
    required this.className,
    required this.grade,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, name, className, grade, avatarUrl];
}
