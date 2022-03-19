import 'package:genesis_vera_tesis/data/models/permiso/permiso.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../domain/entities/permiso/permiso_entity.dart';

abstract class PermisoDTS {
  Future<List<PermisoModelo>> getAllPermisosUser(String id);
  Future<PermisoModelo> insertPermisosUser(PermisosEntity permisos);
}

class PermisoDTSImp extends PermisoDTS {
  final http.Client cliente;
  PermisoDTSImp(this.cliente);

  @override
  Future<List<PermisoModelo>> getAllPermisosUser(String id) async {
    try {
      String url2 = "http://localhost:8000/api/permisos/get/$id";
      List<PermisoModelo> tem = [];
      final result = await cliente.get(Uri.parse(url2));
      if (result.statusCode == 200) {
        tem = decodePermisos(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }

  List<PermisoModelo> decodePermisos(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<PermisoModelo>((json) => PermisoModelo.fromMap(json))
        .toList();
  }

  @override
  Future<PermisoModelo> insertPermisosUser(PermisosEntity permisos) async {
    try {
      String url2 = "http://localhost:8000/api/permisos";

      final result = await cliente.get(Uri.parse(url2));
      if (result.statusCode == 200) {
        return PermisoModelo.fromMap(json.decode(result.body));
      }

      return new PermisoModelo();
    } catch (e) {
      return new PermisoModelo();
    }
  }
}
