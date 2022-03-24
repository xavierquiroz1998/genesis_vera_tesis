import 'package:genesis_vera_tesis/domain/entities/registro/entityRegistor.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class ModelRegistro extends EntityRegistro {
  ModelRegistro({
    this.id = 0,
    this.idTipo = 0,
    this.detalle = "",
    this.estado = false,
    this.createdAt = "",
  }) : super(
            id: id,
            idTipo: idTipo,
            detalle: detalle,
            estado: estado,
            createdAt: createdAt);
  int id;
  int idTipo;
  String detalle;
  bool estado;
  String createdAt;

  factory ModelRegistro.fromJson(String str) =>
      ModelRegistro.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelRegistro.fromMap(Map<String, dynamic> json) => ModelRegistro(
        id: json["id"],
        idTipo: json["idTipo"],
        detalle: json["detalle"],
        estado: json["estado"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "idTipo": idTipo,
        "detalle": detalle,
        "estado": estado,
        "createdAt": createdAt,
      };
}
