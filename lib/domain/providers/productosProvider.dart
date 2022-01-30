import 'package:flutter/cupertino.dart';

import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/productos/insert_producto.dart';

class ProductosProvider extends ChangeNotifier {
  Productos _productos = new Productos(precio: 0);
  TextEditingController _controllerDescripcion = new TextEditingController();
  TextEditingController _controllerCodigo = new TextEditingController();
  TextEditingController _controllerStock = new TextEditingController();
  TextEditingController _controllerPrecio = new TextEditingController();

  final InsertarProducto insertarProducto;
  ProductosProvider(this.insertarProducto);

  final _keyProducto = GlobalKey<FormState>();

  GlobalKey<FormState> get keyProducto => _keyProducto;

  TextEditingController get controllerPrecio => _controllerPrecio;

  set controllerPrecio(TextEditingController controllerPrecio) {
    _controllerPrecio = controllerPrecio;
  }

  TextEditingController get controllerStock => _controllerStock;

  set controllerStock(TextEditingController controllerStock) {
    _controllerStock = controllerStock;
  }

  TextEditingController get controllerCodigo => _controllerCodigo;

  set controllerCodigo(TextEditingController controllerCodigo) {
    _controllerCodigo = controllerCodigo;
  }

  TextEditingController get controllerDescripcion => _controllerDescripcion;

  set controllerDescripcion(TextEditingController controllerDescripcion) {
    _controllerDescripcion = controllerDescripcion;
  }

  Productos get product => _productos;

  set product(Productos p) {
    _productos = p;
    controllerDescripcion.text = p.descripcion ?? "";
    controllerCodigo.text = p.codigo ?? "";
    controllerStock.text = p.stock == null ? "" : p.stock!.toString();
    controllerPrecio.text = p.precio == null ? "" : p.precio!.toString();
    notifyListeners();
  }

  void notificar() {
    notifyListeners();
  }

  Future<Productos?> guardar() async {
    var opt = false;
    try {
      await insertarProducto();

      if (keyProducto.currentState!.validate()) {
        product.id = Estaticas.listProductos.length + 1;
        product.descripcion = controllerDescripcion.text;
        product.codigo = controllerCodigo.text;
        product.stock = double.tryParse(controllerStock.text);
        product.precio = double.tryParse(controllerPrecio.text);

        Estaticas.listProductos.forEach((element) {
          if (element.codigo == controllerCodigo.text) {
            element.descripcion = controllerDescripcion.text;
            element.stock = double.tryParse(controllerStock.text);
            element.precio = double.tryParse(controllerPrecio.text);
            opt = true;
          }
        });
        if (!opt) {
          Estaticas.listProductos.add(product);
        }
        /* product = new Productos(precio: 0); */

        return product;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
