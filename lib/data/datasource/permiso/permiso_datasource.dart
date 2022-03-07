import 'package:genesis_vera_tesis/data/models/permiso/permiso.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class PermisoDTS {
  Future<List<PermisoModelo>> getAllPermisosUser(String id);
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
}
