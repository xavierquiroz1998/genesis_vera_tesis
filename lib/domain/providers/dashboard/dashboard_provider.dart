import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';

import '../../entities/productos.dart';

class DashboardProvider extends ChangeNotifier {
  List<Productos> _listProductos = [];

  List<Productos> get listProductos => _listProductos;

  set listProductos(List<Productos> listProductos) {
    _listProductos = listProductos;
  }

  void cargarLista(String idTipo) {
    listProductos =
        Estaticas.listProductos.where((x) => x.tipoProdcuto == idTipo).toList();

    notifyListeners();
  }
}
