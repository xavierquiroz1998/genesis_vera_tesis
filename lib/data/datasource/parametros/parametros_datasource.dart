import 'package:genesis_vera_tesis/data/models/grupo/grupo_modelo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../domain/entities/parametros/entityParameter.dart';
import '../../../domain/entities/tipo/grupo.dart';
import '../../models/parametros/Modelparameter.dart';

abstract class ParametrosDTS {
  Future<List<ModelParametros>> getAllParametros();
  Future<ModelParametros> insertParametros(EntityParametros grupo);
  Future<ModelParametros> updateParametros(EntityParametros grupo);
  // Future<GruposModelo> deleteGrupos(GrupoEntity grupo);
}

class ParametrosDTSImp extends ParametrosDTS {
  final http.Client cliente;
  ParametrosDTSImp(this.cliente);
  String urlBase = "http://localhost:8000/api/parametro";

  @override
  Future<List<ModelParametros>> getAllParametros() async {
    try {
      List<ModelParametros> tem = [];
      final result = await cliente.get(Uri.parse(urlBase));
      if (result.statusCode == 200) {
        tem = decodeProducts(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }

  List<ModelParametros> decodeProducts(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<ModelParametros>((json) => ModelParametros.fromMap(json))
        .toList();
  }

  @override
  Future<ModelParametros> insertParametros(EntityParametros grupo) async {
    try {
      var grp = json.encode(grupo.toMap());

      final result = await cliente.post(Uri.parse(urlBase),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ModelParametros.fromMap(json.decode(result.body));
      }

      return new ModelParametros();
    } catch (e) {
      return new ModelParametros();
    }
  }

  @override
  Future<ModelParametros> updateParametros(EntityParametros grupo) async {
    try {
      var grp = json.encode(grupo.toMap());

      final result = await cliente.post(Uri.parse(urlBase),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ModelParametros.fromMap(json.decode(result.body));
      }

      return new ModelParametros();
    } catch (e) {
      return new ModelParametros();
    }
  }
}
