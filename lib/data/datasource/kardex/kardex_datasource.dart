import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../domain/entities/kardex/kardex.dart';
import '../../models/kardex/kardex.dart';

abstract class KardexDTS {
  Future<List<ModelKardex>> getAllKardex();
  Future<List<ModelKardex>> getKardex(int idProducto);
  Future<ModelKardex> insertKardex(Kardex k);
  Future<ModelKardex> updateKardex(Kardex k);
  Future<ModelKardex> deleteKardex(Kardex k);
}

class KardexDTSImp extends KardexDTS {
  final http.Client cliente;
  KardexDTSImp(this.cliente); // cambiar entity kardex
  String urlBase = "http://localhost:8000/api/kardex";

  @override
  Future<ModelKardex> deleteKardex(Kardex k) async {
    try {
      var grp = json.encode(k.toMap());

      final result = await cliente.delete(Uri.parse(urlBase),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ModelKardex.fromMap(json.decode(result.body));
      }

      return new ModelKardex();
    } catch (e) {
      return new ModelKardex();
    }
  }

  @override
  Future<List<ModelKardex>> getAllKardex() async {
    try {
      List<ModelKardex> tem = [];
      final result = await cliente.get(Uri.parse(urlBase));
      if (result.statusCode == 200) {
        tem = _decodeProducts(utf8.decode(result.bodyBytes));
      }
      return tem;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<ModelKardex>> getKardex(int idProducto) async {
    try {
      List<ModelKardex> tem = [];
      final result = await cliente.get(Uri.parse(urlBase));
      if (result.statusCode == 200) {
        tem = _decodeProducts(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }

  List<ModelKardex> _decodeProducts(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<ModelKardex>((json) => ModelKardex.fromMap(json))
        .toList();
  }

  @override
  Future<ModelKardex> insertKardex(Kardex k) async {
    try {
      var grp = json.encode(k.toMap());

      final result = await cliente.post(Uri.parse(urlBase),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ModelKardex.fromMap(json.decode(result.body));
      }

      return new ModelKardex();
    } catch (e) {
      return new ModelKardex();
    }
  }

  @override
  Future<ModelKardex> updateKardex(Kardex k) async {
    try {
      var grp = json.encode(k.toMap());
      final result = await cliente.put(Uri.parse(urlBase),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ModelKardex.fromMap(json.decode(result.body));
      }
      return new ModelKardex();
    } catch (e) {
      return new ModelKardex();
    }
  }
}
