import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/domain/entities/egreso/egresoProducto.dart';

class EProductoProvider extends ChangeNotifier {
  List<EgresoDetalle> _listPRoduct = [];

  List<EgresoDetalle> get listaProducto => _listPRoduct;

  set _listaProducto(List<EgresoDetalle> lista) {
    _listPRoduct = lista;
    notifyListeners();
  }

  void agregar() {
    listaProducto.add(new EgresoDetalle());
    notifyListeners();
  }

  void remover(EgresoDetalle e) {
    listaProducto.remove(e);
    notifyListeners();
  }
}
