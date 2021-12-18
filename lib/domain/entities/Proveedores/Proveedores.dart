import 'dart:convert';

class Proveedores {
  int? idProveedor;
  String? identificacion;
  String? nombres;
  String? direccion;
  String? correo;
  DateTime? fechaNacimiento;
  String? celular;

  Proveedores({
    this.idProveedor,
    this.identificacion,
    this.nombres,
    this.direccion,
    this.correo,
    this.fechaNacimiento,
    this.celular,
  });

  Map<String, dynamic> toMap() {
    return {
      'idProveedor': idProveedor,
      'identificacion': identificacion,
      'nombres': nombres,
      'direccion': direccion,
      'correo': correo,
      'fechaNacimiento': fechaNacimiento?.millisecondsSinceEpoch,
      'celular': celular,
    };
  }

  factory Proveedores.fromMap(Map<String, dynamic> map) {
    return Proveedores(
      idProveedor: map['idProveedor']?.toInt(),
      identificacion: map['identificacion'],
      nombres: map['nombres'],
      direccion: map['direccion'],
      correo: map['correo'],
      fechaNacimiento: map['fechaNacimiento'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['fechaNacimiento'])
          : null,
      celular: map['celular'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Proveedores.fromJson(String source) =>
      Proveedores.fromMap(json.decode(source));
}
