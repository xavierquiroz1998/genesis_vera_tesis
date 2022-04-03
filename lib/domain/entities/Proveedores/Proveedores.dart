import 'package:equatable/equatable.dart';

class ProveedoresEntity extends Equatable {
  int id;
  String identificacion;
  String nombre;
  String correo;
  String telefono;
  String direccion;
  int holgura;
  bool estado;

  ProveedoresEntity({
    this.id = 0,
    this.identificacion = "",
    this.nombre = "",
    this.correo = "",
    this.telefono = "",
    this.direccion = "",
    this.holgura = 0,
    this.estado = false,
  });

  @override
  List<Object?> get props => [
        id,
        identificacion,
        nombre,
        correo,
        telefono,
        holgura,
        direccion,
        estado
      ];

  Map<String, dynamic> toMap() => {
        "id": id,
        "identificacion": identificacion,
        "nombre": nombre,
        "correo": correo,
        "telefono": telefono,
        "direccion": direccion,
        "holgura": holgura,
        "estado": estado,
      };
}
