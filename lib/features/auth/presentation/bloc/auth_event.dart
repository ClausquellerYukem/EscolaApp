import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  final String tenantId;

  const LoginRequested(this.email, this.password, this.tenantId);

  @override
  List<Object> get props => [email, password, tenantId];
}

class LogoutRequested extends AuthEvent {}
