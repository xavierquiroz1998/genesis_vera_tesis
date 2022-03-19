import 'package:equatable/equatable.dart';

class RegistUser extends Equatable {
  int id;
  String nombre;
  String email;
  String clave;
  bool estado;
  DateTime? expiracion;
  DateTime? createdAt;
  DateTime? updatedAt;

  RegistUser({
    this.id = 0,
    this.nombre = "",
    this.email = "",
    this.clave = "",
    this.estado = false,
    this.expiracion,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props =>
      [id, nombre, email, clave, estado, expiracion, createdAt, updatedAt];
}
