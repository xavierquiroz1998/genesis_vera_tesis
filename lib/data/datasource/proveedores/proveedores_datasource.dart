import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../domain/entities/Proveedores/Proveedores.dart';
import '../../models/productos/modelProductos.dart';

abstract class ProveedoresDatasourceADS {
  Future<List<Proveedor>> getAllProveedores();
  Future<String> insertProveedores(ProveedoresEntity prod);
}

class ProveedoresDataSourceImp implements ProveedoresDatasourceADS {
  final http.Client cliente;
  ProveedoresDataSourceImp(this.cliente);
  String urlBase = "http://localhost:8000/api/proveedores";

  @override
  Future<List<Proveedor>> getAllProveedores() async {
    try {
      String url = urlBase;
      List<Proveedor> tem = [];
      final result = await cliente.get(Uri.parse(url));
      if (result.statusCode == 200) {
        tem = decodeProveedores(utf8.decode(result.bodyBytes));
      }
      return tem;
    } catch (e) {
      return [];
    }
  }

  List<Proveedor> decodeProveedores(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo.map<Proveedor>((json) => Proveedor.fromMap(json)).toList();
  }

  @override
  Future<String> insertProveedores(ProveedoresEntity prod) async {
    try {
      String url = urlBase;
      List<Proveedor> tem = [];
      final result = await cliente.post(Uri.parse(url));
      if (result.statusCode == 200) {
        return result.body;
      }
      return result.statusCode.toString();
    } catch (e) {
      return e.toString();
    }
  }
}
