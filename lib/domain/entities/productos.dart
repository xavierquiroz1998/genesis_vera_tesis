import 'package:equatable/equatable.dart';

class Productos extends Equatable {
  int id;
  String referencia;
  String nombre;
  String detalle;
  double precio;
  double cantidad;
  int pedido;
  int idUnidad;
  int idProveedor;
  int idGrupo;
  bool estado;

  Productos({
    this.id = 0,
    this.referencia = "",
    this.nombre = "",
    this.detalle = "",
    this.pedido = 0,
    this.precio = 0,
    this.cantidad = 0,
    this.idUnidad = 0,
    this.idProveedor = 0,
    this.idGrupo = 0,
    this.estado = false,
  });

  List<Object?> get props =>
      [id, referencia, nombre, detalle, precio, idUnidad, idProveedor, estado];

  Map<String, dynamic> toMap() => {
        "id": id,
        "referencia": referencia,
        "nombre": nombre,
        "detalle": detalle,
        "precio": precio,
        "cantidad": cantidad,
        "idUnidad": idUnidad,
        "idProveedor": idProveedor,
        "idGrupo": idGrupo,
        "estado": estado,
      };
}
