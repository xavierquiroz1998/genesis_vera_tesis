import 'dart:convert';

class RegistUser {
  String cedula = "";
  String nombres = "";
  String direccion = "";
  String correo = "";
  String celular = "";
  String contrasenia = "";
  RegistUser({
    this.cedula = "",
    this.nombres = "",
    this.direccion = "",
    this.correo = "",
    this.celular = "",
    this.contrasenia = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'cedula': cedula,
      'nombres': nombres,
      'direccion': direccion,
      'correo': correo,
      'celular': celular,
      'contrasenia': contrasenia,
    };
  }

  factory RegistUser.fromMap(Map<String, dynamic> map) {
    return RegistUser(
      cedula: map['cedula'],
      nombres: map['nombres'],
      direccion: map['direccion'],
      correo: map['correo'],
      celular: map['celular'],
      contrasenia: map['contrasenia='],
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistUser.fromJson(String source) =>
      RegistUser.fromMap(json.decode(source));
}
