import 'package:equatable/equatable.dart';

class GrupoEntity extends Equatable {
  GrupoEntity({
    this.id = 0,
    this.referencia = "",
    this.nombre = "",
    this.detalle = "",
    this.estado = false,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String referencia;
  String nombre;
  String detalle;
  bool estado;
  DateTime? createdAt;
  DateTime? updatedAt;

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, referencia, nombre, detalle, estado, createdAt, updatedAt];
}
