import 'dart:convert';

import '../../models/movimiento/modelMovimiento.dart';
import 'package:http/http.dart' as http;

abstract class MovimientoDTS {
  Future<List<ModelMovimiento>> getAllMovimiento();
  Future<List<ModelMovimiento>> getAllMovimientoProducto(int idProducto);
  Future<ModelMovimiento> insertMovimiento(ModelMovimiento grupo);
  Future<ModelMovimiento> updateMovimiento(ModelMovimiento grupo);
  // Future<GruposModelo> deleteGrupos(GrupoEntity grupo);
}

class MovimientoDTSImp extends MovimientoDTS {
  final http.Client cliente;
  MovimientoDTSImp(this.cliente);
  String urlBase = "http://localhost:8000/api/movimiento";

  @override
  Future<List<ModelMovimiento>> getAllMovimiento() async {
    try {
      List<ModelMovimiento> tem = [];
      final result = await cliente.get(Uri.parse(urlBase));
      if (result.statusCode == 200) {
        tem = decodeProducts(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }

  List<ModelMovimiento> decodeProducts(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<ModelMovimiento>((json) => ModelMovimiento.fromMap(json))
        .toList();
  }

  @override
  Future<ModelMovimiento> insertMovimiento(ModelMovimiento grupo) async {
    try {
      var grp = json.encode(grupo.toMap());

      final result = await cliente.post(Uri.parse(urlBase),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ModelMovimiento.fromMap(json.decode(result.body));
      }

      return new ModelMovimiento();
    } catch (e) {
      return new ModelMovimiento();
    }
  }

  @override
  Future<ModelMovimiento> updateMovimiento(ModelMovimiento grupo) async {
    try {
      var grp = json.encode(grupo.toMap());

      final result = await cliente.put(Uri.parse(urlBase + "/${grupo.id}"),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ModelMovimiento.fromMap(json.decode(result.body));
      }

      return new ModelMovimiento();
    } catch (e) {
      return new ModelMovimiento();
    }
  }

  @override
  Future<List<ModelMovimiento>> getAllMovimientoProducto(int idProducto) async {
    try {
      List<ModelMovimiento> tem = [];
      final result = await cliente
          .get(Uri.parse(urlBase + "/getMovimientosIdPro/$idProducto"));
      if (result.statusCode == 200) {
        tem = decodeProducts(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }
}
