import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ProyectoEntity extends Equatable {
  ProyectoEntity({
    this.id = 0,
    this.referencia = "",
    this.nombre = "",
    this.detalle = "",
    this.ruta = "",
    this.estado = true,
  });

  int id;
  String referencia;
  String nombre;
  String detalle;
  String ruta;
  bool estado;

  @override
  List<Object?> get props => [id, referencia, nombre, detalle, ruta, estado];
}
