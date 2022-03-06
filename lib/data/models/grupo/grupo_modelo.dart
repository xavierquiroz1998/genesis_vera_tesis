import 'dart:convert';

import 'package:genesis_vera_tesis/domain/entities/tipo/grupo.dart';

class GruposModelo extends GrupoEntity {
  GruposModelo({
    required this.id,
    required this.referencia,
    required this.nombre,
    required this.detalle,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
  }) : super(
            id: id,
            referencia: referencia,
            nombre: nombre,
            detalle: detalle,
            estado: estado,
            createdAt: createdAt,
            updatedAt: updatedAt);

  int id;
  String referencia;
  String nombre;
  String detalle;
  bool estado;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory GruposModelo.fromJson(String str) =>
      GruposModelo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GruposModelo.fromMap(Map<String, dynamic> json) => GruposModelo(
        id: json["id"],
        referencia: json["referencia"],
        nombre: json["nombre"],
        detalle: json["detalle"],
        estado: json["estado"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "referencia": referencia,
        "nombre": nombre,
        "detalle": detalle,
        "estado": estado,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
