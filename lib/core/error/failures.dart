import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? code;
  final Map<String, dynamic>? details;

  const Failure({required this.message, this.code, this.details});

  @override
  List<Object?> get props => [message, code, details];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code, super.details});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code, super.details});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = "No Internet Connection"});
}
