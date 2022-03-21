import 'package:genesis_vera_tesis/data/models/grupo/grupo_modelo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../domain/entities/tipo/grupo.dart';

abstract class GrupoDTS {
  Future<List<GruposModelo>> getAllGrupos();
  Future<GruposModelo> insertGrupos(GrupoEntity grupo);
  Future<GruposModelo> updateGrupos(GrupoEntity grupo);
  Future<GruposModelo> deleteGrupos(GrupoEntity grupo);
}

class GrupoDTSImp extends GrupoDTS {
  final http.Client cliente;
  GrupoDTSImp(this.cliente);
  String urlBase = "http://localhost:8000/api/grupos";
  @override
  Future<List<GruposModelo>> getAllGrupos() async {
    try {
      List<GruposModelo> tem = [];
      final result = await cliente.get(Uri.parse(urlBase));
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
  Future<GruposModelo> insertGrupos(GrupoEntity grupo) async {
    try {
      var grp = json.encode(grupo.toMap());

      final result = await cliente.post(Uri.parse(urlBase),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return GruposModelo.fromMap(json.decode(result.body));
      }

      return new GruposModelo();
    } catch (e) {
      return new GruposModelo();
    }
  }

  @override
  Future<GruposModelo> deleteGrupos(GrupoEntity grupo) async {
    try {
      var grp = json.encode(grupo.toMap());

      final result = await cliente.delete(Uri.parse(urlBase),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return GruposModelo.fromMap(json.decode(result.body));
      }

      return new GruposModelo();
    } catch (e) {
      return new GruposModelo();
    }
  }

  @override
  Future<GruposModelo> updateGrupos(GrupoEntity grupo) async {
    try {
      var grp = json.encode(grupo.toMap());

      final result = await cliente.put(Uri.parse(urlBase),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return GruposModelo.fromMap(json.decode(result.body));
      }

      return new GruposModelo();
    } catch (e) {
      return new GruposModelo();
    }
  }
}
