import 'package:genesis_vera_tesis/data/models/proyecto/proyecto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../domain/entities/proyecto/proyecto_entity.dart';

abstract class ProyectoDTS {
  Future<List<ProyectoModelo>> getAll();
  Future<bool> insertProyect(ProyectoEntity project);
}

class ProyectoDTSImp extends ProyectoDTS {
  final http.Client cliente;
  ProyectoDTSImp(this.cliente);

  String urlBase = "http://localhost:8000/api/proyectos";

  @override
  Future<List<ProyectoModelo>> getAll() async {
    try {
      List<ProyectoModelo> tem = [];
      final result = await cliente.get(Uri.parse(urlBase));
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

  @override
  Future<bool> insertProyect(ProyectoEntity project) async {
    try {
      var p = json.encode(project.toMap());

      final result = await cliente.post(Uri.parse(urlBase),
          body: p, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
