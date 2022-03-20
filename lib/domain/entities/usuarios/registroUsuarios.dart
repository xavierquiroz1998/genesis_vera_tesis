import 'package:equatable/equatable.dart';

class RegistUser extends Equatable {
  int id;
  String nombre;
  String email;
  String clave;
  bool estado;
  DateTime? expiracion;
  DateTime? createdAt;
  DateTime? updatedAt;

  RegistUser({
    this.id = 0,
    this.nombre = "",
    this.email = "",
    this.clave = "",
    this.estado = false,
    this.expiracion,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props =>
      [id, nombre, email, clave, estado, expiracion, createdAt, updatedAt];
  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "email": email,
        "clave": clave,
        "estado": estado,
        "expiracion": expiracion == null
            ? DateTime.now().toIso8601String()
            : expiracion!.toIso8601String(),
        "createdAt": createdAt == null
            ? DateTime.now().toIso8601String()
            : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null
            ? DateTime.now().toIso8601String()
            : updatedAt!.toIso8601String(),
      };

  factory RegistUser.fromMap(Map<String, dynamic> json) => RegistUser(
        id: json["id"],
        nombre: json["nombre"],
        email: json["email"],
        clave: json["clave"],
        estado: json["estado"],
        expiracion: DateTime.parse(json["expiracion"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}
