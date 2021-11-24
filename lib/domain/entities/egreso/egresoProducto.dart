import 'dart:convert';

class EgresoDetalle {
  int? idProducto;
  String? detalle;
  int? cantidad;
  double? precio;
  double? total;

  EgresoDetalle({
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

  factory EgresoDetalle.fromMap(Map<String, dynamic> map) {
    return EgresoDetalle(
      idProducto: map['idProducto'] != null ? map['idProducto'] : null,
      detalle: map['detalle'] != null ? map['detalle'] : null,
      cantidad: map['cantidad'] != null ? map['cantidad'] : null,
      precio: map['precio'] != null ? map['precio'] : null,
      total: map['total'] != null ? map['total'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EgresoDetalle.fromJson(String source) =>
      EgresoDetalle.fromMap(json.decode(source));
}
