import 'dart:convert';

import '../../../domain/entities/usuarios/registroUsuarios.dart';
import '../../models/Usuarios/model_usuarios.dart';
import 'package:http/http.dart' as http;

abstract class UsuarioDatasource {
  Future<List<ModelUsuarios>> getUsuarios();
  Future<ModelUsuarios> insertUsuarios(RegistUser usuario);
  Future<ModelUsuarios> updateUsuarios(RegistUser usuario);
  Future<ModelUsuarios> deleteUsuarios(RegistUser usuario);
}

class UsuarioDatasourceImp extends UsuarioDatasource {
  final http.Client cliente;
  UsuarioDatasourceImp(this.cliente);
  String urlBase = "http://localhost:8000/api/usuarios";

  @override
  Future<List<ModelUsuarios>> getUsuarios() async {
    try {
      List<ModelUsuarios> tem = [];
      final result = await cliente.get(Uri.parse(urlBase));
      if (result.statusCode == 200) {
        tem = decodeProducts(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }

  List<ModelUsuarios> decodeProducts(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<ModelUsuarios>((json) => ModelUsuarios.fromMap(json))
        .toList();
  }

  @override
  Future<ModelUsuarios> insertUsuarios(RegistUser usuario) async {
    try {
      var uss = json.encode(usuario.toMap());
      final result = await cliente.post(Uri.parse(urlBase),
          body: uss, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ModelUsuarios.fromMap(json.decode(result.body));
      } else {
        return new ModelUsuarios();
      }
    } catch (e) {
      return new ModelUsuarios();
    }
  }

  @override
  Future<ModelUsuarios> deleteUsuarios(RegistUser usuario) async {
    try {
      var uss = json.encode(usuario.toMap());
      final result = await cliente.delete(Uri.parse(urlBase),
          body: uss, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ModelUsuarios.fromMap(json.decode(result.body));
      } else {
        return new ModelUsuarios();
      }
    } catch (e) {
      return new ModelUsuarios();
    }
  }

  @override
  Future<ModelUsuarios> updateUsuarios(RegistUser usuario) async {
    try {
      var uss = json.encode(usuario.toMap());
      final result = await cliente.put(Uri.parse(urlBase),
          body: uss, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ModelUsuarios.fromMap(json.decode(result.body));
      } else {
        return new ModelUsuarios();
      }
    } catch (e) {
      return new ModelUsuarios();
    }
  }
}
