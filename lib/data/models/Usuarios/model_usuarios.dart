import 'dart:convert';

import 'package:genesis_vera_tesis/domain/entities/usuarios/registroUsuarios.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ModelUsuarios extends RegistUser {
  ModelUsuarios({
    this.id = 0,
    this.nombre = "",
    this.email = "",
    this.clave = "",
    this.estado = false,
    this.expiracion,
    this.createdAt,
    this.updatedAt,
  }) : super(
            id: id,
            nombre: nombre,
            email: email,
            clave: clave,
            estado: estado,
            expiracion: expiracion,
            createdAt: createdAt,
            updatedAt: updatedAt);

  int id;
  String nombre;
  String email;
  String clave;
  bool estado;
  DateTime? expiracion;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ModelUsuarios.fromJson(String str) =>
      ModelUsuarios.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelUsuarios.fromMap(Map<String, dynamic> json) => ModelUsuarios(
        id: json["id"],
        nombre: json["nombre"],
        email: json["email"],
        clave: json["clave"],
        estado: json["estado"],
        expiracion: DateTime.parse(json["expiracion"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "email": email,
        "clave": clave,
        "estado": estado,
        "expiracion": expiracion!.toIso8601String(),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
