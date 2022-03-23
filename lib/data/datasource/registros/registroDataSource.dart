import 'dart:convert';

import '../../../domain/entities/registro/entityRegistor.dart';
import '../../models/registros/modelRegistro.dart';
import 'package:http/http.dart' as http;

abstract class RegistroDTS {
  Future<List<ModelRegistro>> getAll();
  Future<ModelRegistro> insertProyect(EntityRegistro registro);
  Future<ModelRegistro> updateProyect(EntityRegistro registro);
  Future<ModelRegistro> deleteProyect(EntityRegistro registro);
}

class RegistroDTSImp extends RegistroDTS {
  final http.Client cliente;
  RegistroDTSImp(this.cliente);

  String urlBase = "http://localhost:8000/api/registros";

  @override
  Future<ModelRegistro> deleteProyect(EntityRegistro registro) async {
    try {
      var p = json.encode(registro.toMap());

      final result = await cliente.delete(
          Uri.parse(urlBase + "/${registro.id}"),
          body: p,
          headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ModelRegistro.fromMap(json.decode(result.body));
      }
      return new ModelRegistro();
    } catch (e) {
      return new ModelRegistro();
    }
  }

  @override
  Future<List<ModelRegistro>> getAll() async {
    try {
      List<ModelRegistro> tem = [];
      final result = await cliente.get(Uri.parse(urlBase));
      if (result.statusCode == 200) {
        tem = decodePermisos(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }

  List<ModelRegistro> decodePermisos(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<ModelRegistro>((json) => ModelRegistro.fromMap(json))
        .toList();
  }

  @override
  Future<ModelRegistro> insertProyect(EntityRegistro registro) async {
    try {
      var p = json.encode(registro.toMap());

      final result = await cliente.post(Uri.parse(urlBase),
          body: p, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ModelRegistro.fromMap(json.decode(result.body));
      }
      return new ModelRegistro();
    } catch (e) {
      return new ModelRegistro();
    }
  }

  @override
  Future<ModelRegistro> updateProyect(EntityRegistro registro) async {
    try {
      var p = json.encode(registro.toMap());

      final result = await cliente.put(Uri.parse(urlBase + "/${registro.id}"),
          body: p, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ModelRegistro.fromMap(json.decode(result.body));
      }
      return new ModelRegistro();
    } catch (e) {
      return new ModelRegistro();
    }
  }
}
