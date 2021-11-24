import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';

class ProductosProvider extends ChangeNotifier {
  Productos _productos = new Productos(precio: 0);

  Productos get product => _productos;

  set product(Productos p) {
    _productos = p;
    notifyListeners();
  }

  bool guardar() {
    try {
      product.id = Estaticas.listProductos.length + 1;
      Estaticas.listProductos.add(product);
      product = new Productos(precio: 0);
      return true;
    } catch (e) {
      return false;
    }
  }
}
