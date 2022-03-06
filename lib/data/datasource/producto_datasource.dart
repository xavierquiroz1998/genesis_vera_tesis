import 'dart:convert';

import 'package:genesis_vera_tesis/data/models/productos/modelProductos.dart';
import 'package:http/http.dart' as http;

abstract class ProductosDataSource {
  Future<String> insertProducto();
  Future<List<ModelProducto>> getProducto();
}

class ProductosDataSourceImp extends ProductosDataSource {
  final http.Client cliente;
  ProductosDataSourceImp(this.cliente);
  String urlBase = "http://localhost:8000/api/productos";

  @override
  Future<String> insertProducto() async {
    try {
      String url = "";
      final result = await cliente.post(Uri.parse(url));
      return "";
    } catch (ex) {
      return "";
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
