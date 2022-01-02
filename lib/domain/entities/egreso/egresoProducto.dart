import 'dart:convert';

class EgresoDetalle {
  int? idEgreso;
  int? idProducto;
  String? detalle;
  int? cantidad;
  double? precio;
  double? total;

  EgresoDetalle({
    this.idEgreso,
    this.idProducto,
    this.detalle,
    this.cantidad,
    this.precio,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'idEgreso': idEgreso,
      'idProducto': idProducto,
      'detalle': detalle,
      'cantidad': cantidad,
      'precio': precio,
      'total': total,
    };
  }

  factory EgresoDetalle.fromMap(Map<String, dynamic> map) {
    return EgresoDetalle(
      idEgreso: map['idEgreso']?.toInt(),
      idProducto: map['idProducto']?.toInt(),
      detalle: map['detalle'],
      cantidad: map['cantidad']?.toInt(),
      precio: map['precio']?.toDouble(),
      total: map['total']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory EgresoDetalle.fromJson(String source) =>
      EgresoDetalle.fromMap(json.decode(source));
}
