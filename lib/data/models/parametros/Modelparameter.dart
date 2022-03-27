import 'dart:convert';

import '../../../domain/entities/parametros/entityParameter.dart';

class ModelParametros extends EntityParametros {
  ModelParametros({
    this.id = 0,
    this.detalle = "",
    this.holgura = 0,
    this.estado = false,
  }) : super(id: id, detalle: detalle, holgura: holgura, estado: estado);

  int id;
  String detalle;
  int holgura;
  bool estado;

  factory ModelParametros.fromJson(String str) =>
      ModelParametros.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelParametros.fromMap(Map<String, dynamic> json) => ModelParametros(
        id: json["id"],
        detalle: json["detalle"],
        holgura: json["holgura"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "detalle": detalle,
        "holgura": holgura,
        "estado": estado,
      };
}
