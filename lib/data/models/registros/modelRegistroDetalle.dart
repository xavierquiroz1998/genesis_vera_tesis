// To parse this JSON data, do
//
//     final modelRegistroDetalle = modelRegistroDetalleFromMap(jsonString);

import 'dart:convert';

import '../../../domain/entities/registro/entityRegistroDetaller.dart';

ModelRegistroDetalle modelRegistroDetalleFromMap(String str) =>
    ModelRegistroDetalle.fromMap(json.decode(str));

String modelRegistroDetalleToMap(ModelRegistroDetalle data) =>
    json.encode(data.toMap());

class ModelRegistroDetalle extends EntityRegistroDetalle {
  ModelRegistroDetalle({
    this.id = 0,
    this.cantidad = 0,
    this.total = 0,
    this.idProducto = 0,
    this.idRegistro = 0,
    this.lote = "",
    this.observacion = "",
  }) : super(
            id: id,
            cantidad: cantidad,
            total: total,
            lote: lote,
            idProducto: idProducto,
            idRegistro: idRegistro,
            observacion: observacion);

  int id;
  int cantidad;
  double total;
  int idProducto;
  int idRegistro;
  String lote;
  String observacion;

  factory ModelRegistroDetalle.fromMap(Map<String, dynamic> json) =>
      ModelRegistroDetalle(
        id: json["id"],
        cantidad: json["cantidad"],
        total: json["total"].toDouble(),
        idProducto: json["idProducto"],
        idRegistro: json["idRegistro"],
        observacion: json["observacion"],
        lote: json["lote"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "cantidad": cantidad,
        "total": total,
        "idProducto": idProducto,
        "idRegistro": idRegistro,
        "observacion": observacion,
      };
}
