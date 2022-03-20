import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ProyectoEntity extends Equatable {
  ProyectoEntity({
    this.id = 0,
    this.referencia = "",
    this.nombre = "",
    this.detalle = "",
    this.ruta = "",
    this.estado = false,
    this.crear = false,
    this.modificar = false,
    this.anular = false,
    this.consultar = false,
  });

  int id;
  String referencia;
  String nombre;
  String detalle;
  String ruta;
  bool estado;
  bool crear;
  bool modificar;
  bool anular;
  bool consultar;

  @override
  List<Object?> get props => [id, referencia, nombre, detalle, ruta, estado];

  Map<String, dynamic> toMap() => {
        "id": id,
        "referencia": referencia,
        "nombre": nombre,
        "detalle": detalle,
        "ruta": ruta,
        "estado": estado,
      };
}
