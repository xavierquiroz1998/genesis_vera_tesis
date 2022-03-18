import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/egreso/egresoProducto.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/productos/getproductos.dart';

import '../../services/fail.dart';

class EProductoProvider extends ChangeNotifier {
  EgresoCabecera _listPRoduct = new EgresoCabecera();
  TextEditingController _ctrObservacion = new TextEditingController();
  List<Productos> listado = [];
  final GetProductos getProductos;

  EProductoProvider(this.getProductos);

  TextEditingController get ctrObservacion => _ctrObservacion;

  set ctrObservacion(TextEditingController ctrObservacion) {
    _ctrObservacion = ctrObservacion;
  }

  Productos _prd = new Productos(precio: 0);

  Productos get prd => _prd;

  set prd(Productos prd) {
    _prd = prd;
    notifyListeners();
  }

  EgresoCabecera get listaProducto => _listPRoduct;

  set listaProducto(EgresoCabecera cab) {
    cab.detalle = [];
    _listPRoduct = cab;
    notifyListeners();
  }

  void agregar() {
    listaProducto.detalle!.add(new EgresoDetalle());
    notifyListeners();
  }

  void remover(EgresoDetalle e) {
    listaProducto.detalle!.remove(e);
    notifyListeners();
  }

  Future<void> cargarPrd() async {
    var temporal = await getProductos.call();
    var result = temporal.fold((fail) => Extras.failure(fail), (prd) => prd);
    try {
      listado = result as List<Productos>;
    } catch (ex) {
      print("error${result.toString()}");
    }
    notifyListeners();
  }

  Future<void> guardarEgreso() async {
    try {
      int sec = 0;
      for (var item in listaProducto.detalle!) {
        var result =
            Estaticas.listProductos.firstWhere((e) => e.id == item.idProducto);
        if (result.id > 0) {
          //double totalStock = result.stock! - item.cantidad;
          Estaticas.listProductos.remove(result);
          //result.stock = totalStock;
          Estaticas.listProductos.add(result);
          item.idEgresoDetalle = item.secuencia = sec++;
          item.total = item.cantidad * item.precio!;
        }
      }
      listaProducto.observacion = ctrObservacion.text;
      listaProducto.estado = "A";
      listaProducto.detalle!.forEach((e) {
        listaProducto.total += e.total!;
      });
      listaProducto.idEgreso = Estaticas.listProductosEgreso.length + 1;
      Estaticas.listProductosEgreso.add(listaProducto);
    } catch (e) {
      print("Error en guardar ${e.toString()}");
    }
  }
}
