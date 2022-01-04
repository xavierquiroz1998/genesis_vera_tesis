import 'dart:convert';

import 'package:genesis_vera_tesis/domain/entities/productos.dart';

class DevolucionDet {
  int? idProducto;
  String? detalle;
  int? cantidad;
  double? precio;
  double? total;
  Productos prdSelect = new Productos(precio: 0);
  DevolucionDet({
    this.idProducto,
    this.detalle,
    this.cantidad,
    this.precio,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'idProducto': idProducto,
      'detalle': detalle,
      'cantidad': cantidad,
      'precio': precio,
      'total': total,
    };
  }

  factory DevolucionDet.fromMap(Map<String, dynamic> map) {
    return DevolucionDet(
      idProducto: map['idProducto']?.toInt(),
      detalle: map['detalle'],
      cantidad: map['cantidad']?.toInt(),
      precio: map['precio']?.toDouble(),
      total: map['total']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DevolucionDet.fromJson(String source) =>
      DevolucionDet.fromMap(json.decode(source));
}
