import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String mensaje;

  Failure({required this.mensaje});

  @override
  List<Object> get props => [mensaje];
}

class ServerFailure extends Failure {
  ServerFailure({required String mensaje}) : super(mensaje: mensaje);
}

class CacheFailure extends Failure {
  CacheFailure({required String mensaje}) : super(mensaje: mensaje);
}
