import 'dart:convert';

import 'package:genesis_vera_tesis/domain/entities/unidad_medida/unidadMedida.dart';

class UnidadMedidaModelo extends UnidadMedidaEntity {
  UnidadMedidaModelo({
    required this.id,
    required this.codigo,
    required this.detalle,
    required this.estado,
  }) : super(
          id: id,
          codigo: codigo,
          detalle: detalle,
          estado: estado,
        );

  int id;
  String codigo;
  String detalle;
  bool estado;

  factory UnidadMedidaModelo.fromJson(String str) =>
      UnidadMedidaModelo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UnidadMedidaModelo.fromMap(Map<String, dynamic> json) =>
      UnidadMedidaModelo(
        id: json["id"],
        codigo: json["codigo"],
        detalle: json["detalle"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "codigo": codigo,
        "detalle": detalle,
        "estado": estado,
      };
}
