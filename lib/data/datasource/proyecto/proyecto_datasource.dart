import 'package:genesis_vera_tesis/data/models/permiso/permiso.dart';
import 'package:genesis_vera_tesis/data/models/proyecto/proyecto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class ProyectoDTS {
  Future<List<ProyectoModelo>> getAll();
}

class ProyectoDTSImp extends ProyectoDTS {
  final http.Client cliente;
  ProyectoDTSImp(this.cliente);

  @override
  Future<List<ProyectoModelo>> getAll() async {
    try {
      String url2 = "http://localhost:8000/api/proyectos";
      List<ProyectoModelo> tem = [];
      final result = await cliente.get(Uri.parse(url2));
      if (result.statusCode == 200) {
        tem = decodePermisos(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }

  List<ProyectoModelo> decodePermisos(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<ProyectoModelo>((json) => ProyectoModelo.fromMap(json))
        .toList();
  }
}
