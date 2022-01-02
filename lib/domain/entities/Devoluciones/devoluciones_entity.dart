import 'dart:convert';

class DevolucionesEntity {
  int? idDevolucion;
  int? idProducto;
  String? detalle;
  int? cantidad;
  double? precio;
  double? total;

  DevolucionesEntity({
    this.idDevolucion,
    this.idProducto,
    this.detalle,
    this.cantidad,
    this.precio,
    this.total,
  });

  DevolucionesEntity copyWith({
    int? idDevolucion,
    int? idProducto,
    String? detalle,
    int? cantidad,
    double? precio,
    double? total,
  }) {
    return DevolucionesEntity(
      idDevolucion: idDevolucion ?? this.idDevolucion,
      idProducto: idProducto ?? this.idProducto,
      detalle: detalle ?? this.detalle,
      cantidad: cantidad ?? this.cantidad,
      precio: precio ?? this.precio,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idDevolucion': idDevolucion,
      'idProducto': idProducto,
      'detalle': detalle,
      'cantidad': cantidad,
      'precio': precio,
      'total': total,
    };
  }

  factory DevolucionesEntity.fromMap(Map<String, dynamic> map) {
    return DevolucionesEntity(
      idDevolucion: map['idDevolucion']?.toInt(),
      idProducto: map['idProducto']?.toInt(),
      detalle: map['detalle'],
      cantidad: map['cantidad']?.toInt(),
      precio: map['precio']?.toDouble(),
      total: map['total']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DevolucionesEntity.fromJson(String source) =>
      DevolucionesEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DevolucionesEntity(idDevolucion: $idDevolucion, idProducto: $idProducto, detalle: $detalle, cantidad: $cantidad, precio: $precio, total: $total)';
  }
}
