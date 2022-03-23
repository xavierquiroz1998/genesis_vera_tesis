import 'package:equatable/equatable.dart';

import '../productos.dart';

class EntityRegistroDetalle extends Equatable {
  EntityRegistroDetalle({
    this.cantidad = 0,
    this.id = 0,
    this.total = 0,
    this.idProducto = 0,
    this.idRegistro = 0,
    this.observacion = "",
    this.to = 0,
  });

  int cantidad;
  int id;
  double total;
  int idProducto;
  int idRegistro;
  String observacion;
  double to;
  Productos? productos;

  Map<String, dynamic> toMap() => {
        "cantidad": cantidad,
        "total": total,
        "idProducto": idProducto,
        "idRegistro": idRegistro,
        "observacion": observacion,
      };

  @override
  // TODO: implement props
  List<Object?> get props =>
      [cantidad, total, idProducto, idRegistro, observacion, id];
}
