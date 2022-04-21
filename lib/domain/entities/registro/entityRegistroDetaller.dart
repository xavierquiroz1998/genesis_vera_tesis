import 'package:equatable/equatable.dart';

import '../../../data/models/movimiento/modelMovimiento.dart';
import '../productos.dart';

class EntityRegistroDetalle extends Equatable {
  EntityRegistroDetalle({
    this.cantidad = 0,
    this.id = 0,
    this.total = 0,
    this.secuencia = 0,
    this.idProducto = 0,
    this.idRegistro = 0,
    this.observacion = "",
    this.lote = "",
    this.to = 0,
  });

  int cantidad;
  int id;
  double total;
  int idProducto;
  int idRegistro;
  String observacion;
  double to;
  String lote;
  int secuencia;
  Productos productos = new Productos();
  ModelMovimiento? mov;
  List<ModelMovimiento> movimientos = [];

  Map<String, dynamic> toMap() => {
        "id": id,
        "cantidad": cantidad,
        "total": total,
        "idProducto": idProducto,
        "idRegistro": idRegistro,
        "lote": lote,
        "observacion": observacion,
      };

  @override
  // TODO: implement props
  List<Object?> get props =>
      [cantidad, total, idProducto, idRegistro, lote, observacion, id];
}
