import 'dart:convert';

import 'package:equatable/equatable.dart';

class Productos extends Equatable {
  int id;
  String referencia;
  String nombre;
  String detalle;
  double precio;
  int idUnidad;
  int idProveedor;
  bool estado;

  Productos({
    this.id = 0,
    this.referencia = "",
    this.nombre = "",
    this.detalle = "",
    this.precio = 0,
    this.idUnidad = 0,
    this.idProveedor = 0,
    this.estado = false,
  });

  List<Object?> get props =>
      [id, referencia, nombre, detalle, precio, idUnidad, idProveedor, estado];
}
