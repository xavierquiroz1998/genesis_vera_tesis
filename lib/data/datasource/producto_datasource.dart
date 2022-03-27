import 'dart:convert';

import 'package:genesis_vera_tesis/data/models/productos/modelProductos.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/productos.dart';

abstract class ProductosDataSource {
  Future<ModelProducto> insertProducto(Productos model);
  Future<List<ModelProducto>> getProducto();
}

class ProductosDataSourceImp extends ProductosDataSource {
  final http.Client cliente;
  ProductosDataSourceImp(this.cliente);
  String urlBase = "http://localhost:8000/api/productos";

  @override
  Future<ModelProducto> insertProducto(Productos modelo) async {
    var prd = json.encode(modelo.toMap());

    try {
      final result = await cliente.post(Uri.parse(urlBase),
          body: prd, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ModelProducto.fromMap(json.decode(result.body));
      }
      return new ModelProducto();
    } catch (ex) {
      return new ModelProducto();
    }
  }

  @override
  Future<List<ModelProducto>> getProducto() async {
    try {
      String url = urlBase + "/fill";
      List<ModelProducto> tem = [];
      final result = await cliente.get(Uri.parse(url));
      if (result.statusCode == 200) {
        tem = decodeProducts(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }

  List<ModelProducto> decodeProducts(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<ModelProducto>((json) => ModelProducto.fromMap(json))
        .toList();
  }
}
