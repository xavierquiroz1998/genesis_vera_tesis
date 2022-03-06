import 'package:equatable/equatable.dart';

class ProveedoresEntity extends Equatable {
  int id;
  String identificacion;
  String nombre;
  String correo;
  String telefono;
  String direccion;
  bool estado;

  ProveedoresEntity({
    this.id = 0,
    this.identificacion = "",
    this.nombre = "",
    this.correo = "",
    this.telefono = "",
    this.direccion = "",
    this.estado = false,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, identificacion, nombre, correo, telefono, direccion, estado];
}
