import 'dart:convert';

class Proveedores {
  int? idProveedor;
  String? identificacion;
  String? nombres;
  String? direccion;
  String? correo;
  DateTime? fechaNacimiento;
  String? celular;
  String? estado;

  Proveedores({
    this.idProveedor,
    this.identificacion,
    this.nombres,
    this.direccion,
    this.correo,
    this.fechaNacimiento,
    this.celular,
    this.estado,
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
      'estado': estado,
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
      estado: map['estado'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Proveedores.fromJson(String source) =>
      Proveedores.fromMap(json.decode(source));

  Proveedores copyWith({
    int? idProveedor,
    String? identificacion,
    String? nombres,
    String? direccion,
    String? correo,
    DateTime? fechaNacimiento,
    String? celular,
    String? estado,
  }) {
    return Proveedores(
      idProveedor: idProveedor ?? this.idProveedor,
      identificacion: identificacion ?? this.identificacion,
      nombres: nombres ?? this.nombres,
      direccion: direccion ?? this.direccion,
      correo: correo ?? this.correo,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      celular: celular ?? this.celular,
      estado: estado ?? this.estado,
    );
  }

  @override
  String toString() {
    return 'Proveedores(idProveedor: $idProveedor, identificacion: $identificacion, nombres: $nombres, direccion: $direccion, correo: $correo, fechaNacimiento: $fechaNacimiento, celular: $celular, estado: $estado)';
  }
}
