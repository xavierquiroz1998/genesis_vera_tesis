import 'dart:convert';

import 'package:genesis_vera_tesis/data/models/permiso/permiso.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences prefs;
  static Future<void> configurePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future createCache(PermisoModelo permiso) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString('permiso', json.encode(permiso.toMap()));
    // print("1");
  }

  Future readCache(String permiso) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var cache = _preferences.getString(permiso);
    // print("2");
    return cache;
  }

  Future removeCache(String permiso) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove(permiso);
  }

  Future createCacheSingle(String value, String referencia) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString(referencia, value);
    // print("1.5");
  }
}
