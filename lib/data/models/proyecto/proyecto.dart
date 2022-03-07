import 'dart:convert';

import 'package:genesis_vera_tesis/domain/entities/proyecto/proyecto_entity.dart';

class ProyectoModelo extends ProyectoEntity {
  ProyectoModelo({
    required this.id,
    required this.referencia,
    required this.nombre,
    required this.detalle,
    required this.ruta,
    required this.estado,
  }) : super(
            id: id,
            referencia: referencia,
            nombre: nombre,
            detalle: detalle,
            ruta: ruta,
            estado: estado);

  int id;
  String referencia;
  String nombre;
  String detalle;
  String ruta;
  bool estado;

  factory ProyectoModelo.fromJson(String str) =>
      ProyectoModelo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProyectoModelo.fromMap(Map<String, dynamic> json) => ProyectoModelo(
        id: json["id"],
        referencia: json["referencia"],
        nombre: json["nombre"],
        detalle: json["detalle"],
        ruta: json["ruta"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "referencia": referencia,
        "nombre": nombre,
        "detalle": detalle,
        "ruta": ruta,
        "estado": estado,
      };
}
