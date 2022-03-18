import 'package:genesis_vera_tesis/data/models/unidad_medida/unidad_medida.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class UnidadMediaDTS {
  Future<List<UnidadMedidaModelo>> getAllUnidades();

  Future<String> insertUnidades();
}

class UnidadMedidaDTSImp extends UnidadMediaDTS {
  final http.Client cliente;
  UnidadMedidaDTSImp(this.cliente);

  @override
  Future<List<UnidadMedidaModelo>> getAllUnidades() async {
    try {
      String url2 = "http://localhost:8000/api/unidades";
      List<UnidadMedidaModelo> tem = [];
      final result = await cliente.get(Uri.parse(url2));
      if (result.statusCode == 200) {
        tem = decodeProducts(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }

  List<UnidadMedidaModelo> decodeProducts(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<UnidadMedidaModelo>((json) => UnidadMedidaModelo.fromMap(json))
        .toList();
  }

  @override
  Future<String> insertUnidades() async {
    try {
      String url2 = "http://localhost:8000/api/unidades";
      List<UnidadMedidaModelo> tem = [];
      final result = await cliente.post(Uri.parse(url2));
      if (result.statusCode == 200) {
        return result.body;
      } else {
        return result.statusCode.toString();
      }
    } catch (e) {
      return e.toString();
    }
  }
}
