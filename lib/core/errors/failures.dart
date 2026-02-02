import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({String message = 'Error en el servidor'}) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure({String message = 'Error al guardar datos locales'}) : super(message);
}