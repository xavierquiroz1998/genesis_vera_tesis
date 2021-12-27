import 'dart:convert';

class RegistUser {
  int? idUsuario;
  String cedula = "";
  String nombres = "";
  String direccion = "";
  String correo = "";
  String celular = "";
  String contrasenia = "";
  String estado = "";

  RegistUser({
    this.idUsuario,
    this.cedula = "",
    this.nombres = "",
    this.direccion = "",
    this.correo = "",
    this.celular = "",
    this.contrasenia = "",
    this.estado = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'idUsuario': idUsuario,
      'cedula': cedula,
      'nombres': nombres,
      'direccion': direccion,
      'correo': correo,
      'celular': celular,
      'contrasenia': contrasenia,
      'estado': estado,
    };
  }

  factory RegistUser.fromMap(Map<String, dynamic> map) {
    return RegistUser(
      idUsuario: map['idUsuario']?.toInt(),
      cedula: map['cedula'] ?? '',
      nombres: map['nombres'] ?? '',
      direccion: map['direccion'] ?? '',
      correo: map['correo'] ?? '',
      celular: map['celular'] ?? '',
      contrasenia: map['contrasenia'] ?? '',
      estado: map['estado'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistUser.fromJson(String source) =>
      RegistUser.fromMap(json.decode(source));

  RegistUser copyWith({
    int? idUsuario,
    String? cedula,
    String? nombres,
    String? direccion,
    String? correo,
    String? celular,
    String? contrasenia,
  }) {
    return RegistUser(
      idUsuario: idUsuario ?? this.idUsuario,
      cedula: cedula ?? this.cedula,
      nombres: nombres ?? this.nombres,
      direccion: direccion ?? this.direccion,
      correo: correo ?? this.correo,
      celular: celular ?? this.celular,
      contrasenia: contrasenia ?? this.contrasenia,
    );
  }

  @override
  String toString() {
    return 'RegistUser(idUsuario: $idUsuario, cedula: $cedula, nombres: $nombres, direccion: $direccion, correo: $correo, celular: $celular, contrasenia: $contrasenia)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegistUser &&
        other.idUsuario == idUsuario &&
        other.cedula == cedula &&
        other.nombres == nombres &&
        other.direccion == direccion &&
        other.correo == correo &&
        other.celular == celular &&
        other.contrasenia == contrasenia;
  }

  @override
  int get hashCode {
    return idUsuario.hashCode ^
        cedula.hashCode ^
        nombres.hashCode ^
        direccion.hashCode ^
        correo.hashCode ^
        celular.hashCode ^
        contrasenia.hashCode;
  }
}
