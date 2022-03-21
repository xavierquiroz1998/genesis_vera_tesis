import 'package:genesis_vera_tesis/data/models/unidad_medida/unidad_medida.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../domain/entities/unidad_medida/unidadMedida.dart';

abstract class UnidadMediaDTS {
  Future<List<UnidadMedidaModelo>> getAllUnidades();

  Future<UnidadMedidaEntity> insertUnidades(UnidadMedidaEntity unid);
  Future<UnidadMedidaEntity> updateUnidades(UnidadMedidaEntity unid);
  Future<UnidadMedidaEntity> deleteUnidades(UnidadMedidaEntity unid);
}

class UnidadMedidaDTSImp extends UnidadMediaDTS {
  final http.Client cliente;
  UnidadMedidaDTSImp(this.cliente);
  String urlBase = "http://localhost:8000/api/unidades";
  @override
  Future<List<UnidadMedidaModelo>> getAllUnidades() async {
    try {
      List<UnidadMedidaModelo> tem = [];
      final result = await cliente.get(Uri.parse(urlBase));
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
      var uni = json.encode(unidad.toMap());
      final result = await cliente.post(Uri.parse(urlBase),
          body: uni, headers: {"Content-type": "application/json"});
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

  @override
  Future<UnidadMedidaEntity> deleteUnidades(UnidadMedidaEntity unid) async {
    try {
      var uni = json.encode(unid.toMap());
      final result = await cliente.delete(Uri.parse(urlBase + "/${unid.id}"),
          body: uni, headers: {"Content-type": "application/json"});
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

  @override
  Future<UnidadMedidaEntity> updateUnidades(UnidadMedidaEntity unid) async {
    try {
      var uni = json.encode(unid.toMap());
      final result = await cliente.put(Uri.parse(urlBase + "/${unid.id}"),
          body: uni, headers: {"Content-type": "application/json"});
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
