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
  List<Object?> get props =>
      [id, identificacion, nombre, correo, telefono, direccion, estado];

  Map<String, dynamic> toMap() => {
        "id": id,
        "identificacion": identificacion,
        "nombre": nombre,
        "correo": correo,
        "telefono": telefono,
        "direccion": direccion,
        "estado": estado,
      };
}
