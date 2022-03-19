import 'package:genesis_vera_tesis/data/models/unidad_medida/unidad_medida.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../domain/entities/unidad_medida/unidadMedida.dart';

abstract class UnidadMediaDTS {
  Future<List<UnidadMedidaModelo>> getAllUnidades();

  Future<UnidadMedidaEntity> insertUnidades(UnidadMedidaEntity unid);
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
  Future<UnidadMedidaModelo> insertUnidades(UnidadMedidaEntity unidad) async {
    try {
      String url2 = "http://localhost:8000/api/unidades";

      final result = await cliente.post(Uri.parse(url2));
      if (result.statusCode == 200) {
        return UnidadMedidaModelo.fromMap(json.decode(result.body));
      } else {
        return new UnidadMedidaModelo(
            id: 0, codigo: "", detalle: "", estado: false);
      }
    } catch (e) {
      return new UnidadMedidaModelo(
          id: 0, codigo: "", detalle: "", estado: false);
    }
  }
}
