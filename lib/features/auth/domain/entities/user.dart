import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String role; // GUARDIAN, STUDENT, TEACHER, COORDINATOR, ADMIN
  final String? avatarUrl;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, email, name, role, avatarUrl];
}
