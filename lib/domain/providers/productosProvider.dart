import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';

import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/productos/getproductos.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/productos/insert_producto.dart';

class ProductosProvider extends ChangeNotifier {
  Productos _productos = new Productos();
  TextEditingController _controllerDescripcion = new TextEditingController();
  TextEditingController _controllerCodigo = new TextEditingController();
  TextEditingController _controllerStock = new TextEditingController();
  TextEditingController _controllerPrecio = new TextEditingController();

  final InsertarProducto insertarProducto;
  final GetProductos getProductos;
  ProductosProvider(this.insertarProducto, this.getProductos);

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
    controllerDescripcion.text = p.detalle ?? "";
    controllerCodigo.text = p.referencia ?? "";
    //controllerStock.text = p.stock == null ? "" : p.stock!.toString();
    controllerPrecio.text = p.precio == null ? "" : p.precio!.toString();
    notifyListeners();
  }

  void notificar() {
    notifyListeners();
  }

  Future<void> cargarPrd() async {
    String a = "";
    var temporal = await getProductos.call();
    List<Productos> listado = [];
    var result = temporal.fold((fail) => failure(fail), (prd) => prd);
    try {
      listado = result as List<Productos>;
    } catch (ex) {
      print("error${result.toString()}");
    }
  }

  String failure(Failure fail) {
    switch (fail.runtimeType) {
      case ServerFailure:
        return "Ocurrio un Error";

      default:
        return "Error";
    }
  }

  Future<Productos?> guardar(Productos? p) async {
    var opt = false;
    try {
      /*  await insertarProducto(); */

      if (keyProducto.currentState!.validate()) {
        product.id = Estaticas.listProductos.length + 1;
        product.detalle = controllerDescripcion.text;
        product.referencia = controllerCodigo.text;
        //product.stock = double.tryParse(controllerStock.text);
        product.precio = double.parse(controllerPrecio.text);
        product.estado = true;
        Estaticas.listProductos.forEach((element) {
          if (element.referencia == controllerCodigo.text) {
            element.detalle = controllerDescripcion.text;
            // element.stock =
            //     element.stock! + double.tryParse(controllerStock.text)!;
            element.precio = double.parse(controllerPrecio.text);
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
