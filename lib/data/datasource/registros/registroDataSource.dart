import 'dart:convert';

import '../../../domain/entities/registro/entityRegistor.dart';
import '../../../domain/entities/registro/entityRegistroDetaller.dart';
import '../../models/registros/modelRegistro.dart';
import 'package:http/http.dart' as http;

import '../../models/registros/modelRegistroDetalle.dart';

abstract class RegistroDTS {
  Future<List<ModelRegistro>> getAll(int idTipo);
  Future<ModelRegistro> insertRegistro(EntityRegistro registro);
  Future<ModelRegistro> updateRegistro(EntityRegistro registro);
  Future<ModelRegistro> deleteRegistro(EntityRegistro registro);

  Future<List<ModelRegistroDetalle>> getDetalleXregistro(int idRegistro);
  Future<ModelRegistroDetalle> insertRegistroDetalle(
      EntityRegistroDetalle registro);
  Future<ModelRegistroDetalle> updateRegistroDetalle(
      EntityRegistroDetalle registro);
  Future<ModelRegistroDetalle> deleteRegistroDetalle(
      EntityRegistroDetalle registro);
}

class RegistroDTSImp extends RegistroDTS {
  final http.Client cliente;
  RegistroDTSImp(this.cliente);

  String urlBase = "http://localhost:8000/api/registros";
  String urlBaseDetalle = "http://localhost:8000/api/detalleRegistros";

  @override
  Future<ModelRegistro> deleteRegistro(EntityRegistro registro) async {
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
  Future<List<ModelRegistro>> getAll(int idTipo) async {
    try {
      List<ModelRegistro> tem = [];
      final result = await cliente.get(Uri.parse(urlBase + "/gettipo/$idTipo"));
      if (result.statusCode == 200) {
        tem = decodePermisos(result.body);
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
  Future<ModelRegistro> insertRegistro(EntityRegistro registro) async {
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
  Future<ModelRegistro> updateRegistro(EntityRegistro registro) async {
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

  @override
  Future<ModelRegistroDetalle> deleteRegistroDetalle(
      EntityRegistroDetalle registro) async {
    try {
      var p = json.encode(registro.toMap());

      final result = await cliente.delete(Uri.parse(urlBase),
          body: p, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ModelRegistroDetalle.fromMap(json.decode(result.body));
      }
      return new ModelRegistroDetalle();
    } catch (e) {
      return new ModelRegistroDetalle();
    }
  }

  @override
  Future<List<ModelRegistroDetalle>> getDetalleXregistro(int idRegistro) async {
    try {
      List<ModelRegistroDetalle> tem = [];
      final result = await cliente.get(Uri.parse(urlBaseDetalle));
      if (result.statusCode == 200) {
        tem = decodeRegistroDetalle(result.body);
      }

      return tem;
    } catch (e) {
      return [];
    }
  }

  List<ModelRegistroDetalle> decodeRegistroDetalle(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<ModelRegistroDetalle>((json) => ModelRegistroDetalle.fromMap(json))
        .toList();
  }

  @override
  Future<ModelRegistroDetalle> insertRegistroDetalle(
      EntityRegistroDetalle registro) async {
    try {
      var p = json.encode(registro.toMap());

      final result = await cliente.post(Uri.parse(urlBaseDetalle),
          body: p, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ModelRegistroDetalle.fromMap(json.decode(result.body));
      }
      return new ModelRegistroDetalle();
    } catch (e) {
      return new ModelRegistroDetalle();
    }
  }

  @override
  Future<ModelRegistroDetalle> updateRegistroDetalle(
      EntityRegistroDetalle registro) async {
    try {
      var p = json.encode(registro.toMap());

      final result = await cliente.put(
          Uri.parse(urlBaseDetalle + "/${registro.id}"),
          body: p,
          headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ModelRegistroDetalle.fromMap(json.decode(result.body));
      }
      return new ModelRegistroDetalle();
    } catch (e) {
      return new ModelRegistroDetalle();
    }
  }
}
