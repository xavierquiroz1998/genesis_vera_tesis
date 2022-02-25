import 'dart:convert';

import 'package:genesis_vera_tesis/domain/entities/productos.dart';

class EgresoCabecera {
  int? idEgreso;
  String observacion;
  double total;
  String estado;
  List<EgresoDetalle>? detalle = [];

  EgresoCabecera({
    this.idEgreso,
    this.observacion = "",
    this.total = 0,
    this.estado = "",
    this.detalle,
  });

  Map<String, dynamic> toMap() {
    return {
      'idEgreso': idEgreso,
      'observacion': observacion,
      'total': total,
      'estado': estado,
      'detalle': detalle!.map((x) => x.toMap()).toList(),
    };
  }

  factory EgresoCabecera.fromMap(Map<String, dynamic> map) {
    return EgresoCabecera(
      idEgreso: map['idEgreso']?.toInt(),
      observacion: map['observacion'] ?? '',
      total: map['total']?.toInt() ?? 0,
      estado: map['estado'] ?? '',
      detalle: List<EgresoDetalle>.from(
          map['detalle']?.map((x) => EgresoDetalle.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory EgresoCabecera.fromJson(String source) =>
      EgresoCabecera.fromMap(json.decode(source));
}

class EgresoDetalle {
  int? idEgresoDetalle;
  int? idProducto;
  int? secuencia;
  String? detalle;
  int cantidad;
  double? precio;
  double? total;
  Productos? prd;

  EgresoDetalle({
    this.idEgresoDetalle,
    this.idProducto,
    this.secuencia,
    this.detalle,
    this.cantidad = 0,
    this.precio,
    this.total,
    this.prd,
  });

  Map<String, dynamic> toMap() {
    return {
      'idEgresoDetalle': idEgresoDetalle,
      'idProducto': idProducto,
      'secuencia': secuencia,
      'detalle': detalle,
      'cantidad': cantidad,
      'precio': precio,
      'total': total,
      'prd': prd?.toMap(),
    };
  }

  factory EgresoDetalle.fromMap(Map<String, dynamic> map) {
    return EgresoDetalle(
      idEgresoDetalle: map['idEgresoDetalle']?.toInt(),
      idProducto: map['idProducto']?.toInt(),
      secuencia: map['secuencia']?.toInt(),
      detalle: map['detalle'],
      cantidad: map['cantidad']?.toInt() ?? 0,
      precio: map['precio']?.toDouble(),
      total: map['total']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory EgresoDetalle.fromJson(String source) =>
      EgresoDetalle.fromMap(json.decode(source));
}
