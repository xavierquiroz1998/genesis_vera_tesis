import 'package:genesis_vera_tesis/data/models/grupo/grupo_modelo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../domain/entities/tipo/grupo.dart';

abstract class GrupoDTS {
  Future<List<GruposModelo>> getAllGrupos();
  Future<String> insertGrupos(GrupoEntity grupo);
}

class GrupoDTSImp extends GrupoDTS {
  final http.Client cliente;
  GrupoDTSImp(this.cliente);

  @override
  Future<List<GruposModelo>> getAllGrupos() async {
    try {
      String url2 = "http://localhost:8000/api/grupos";
      List<GruposModelo> tem = [];
      final result = await cliente.get(Uri.parse(url2));
      if (result.statusCode == 200) {
        tem = decodeProducts(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }

  List<GruposModelo> decodeProducts(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<GruposModelo>((json) => GruposModelo.fromMap(json))
        .toList();
  }

  @override
  Future<String> insertGrupos(GrupoEntity grupo) async {
    try {
      String url2 = "http://localhost:8000/api/grupos";
      List<GruposModelo> tem = [];
      final result = await cliente.post(Uri.parse(url2));
      if (result.statusCode == 200) {
        return result.body;
      }

      return result.statusCode.toString();
    } catch (e) {
      return e.toString();
    }
  }
}
