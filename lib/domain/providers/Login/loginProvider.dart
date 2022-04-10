import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/logeo/inicio_sesion.dart';
import 'package:genesis_vera_tesis/ui/Router/FluroRouter.dart';
import '../../../data/datasource/reference/local_storage.dart';
import '../../uses cases/usuarios/get_usuarios.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class LoginProvider extends ChangeNotifier {
  String _cedula = "";
  AuthStatus authStatus = AuthStatus.checking;
  final GetUsuarios usuarios;
  final InicioSesion logeoUsesCase;

  LoginProvider(this.logeoUsesCase, this.usuarios) {
    isAuthenticated();
  }
  String get cedula => _cedula;

  bool authenticated = false;

  set cedula(String cedula) {
    _cedula = cedula;
    notifyListeners();
  }

  String _contrasenia = "";

  String get contrasenia => _contrasenia;

  set contrasenia(String contrasenia) {
    _contrasenia = contrasenia;
    notifyListeners();
  }
  //no guardas el tyoken? no
  //necesitas el sharedpreference si pero quiero hacer la inseercion de datos
  //cual inserncion de datos? todos
  //Los datos que tienes que usar para el logeo son estos
  /// http://localhost:8080/api/auth/login?correo=jesusvera19_24@hotmail.com&password=123456
  /// esa es la ruta que necesitas con em metodo de tipo POST
  /// de ahi para validar el token necesitas esta ruta
  /// pero lo tienes en mongo db
  /// y quien va  asaber que estas consumiendo los usuarios de mongo db
  /// si pero debo abrir el mongo db y no se usar bien eso
  /// explicame
  /// https://flutter-web-admin-odontograma.herokuapp.com/api

  Future<void> logeo() async {
    try {
      var temp = await usuarios.call();
      var listaUsuarios = temp.getOrElse(() => []);
      for (var item in listaUsuarios.where((e) => e.estado).toList()) {
        if (item.email == cedula && item.clave == contrasenia) {
          authStatus = AuthStatus.authenticated;
          LocalStorage.prefs.setString('token', "asdddsswwee");
          LocalStorage.prefs.setString('usuario', json.encode(item.toMap()));
          authenticated = true;
          notifyListeners();
          NavigationService.replaceTo(Flurorouter.inicio);
        }
      }
      //final result = await logeoUsesCase.call(cedula, contrasenia);
      //print("valor de result $result");
    } catch (e) {}
  }

  Future<void> lagout() async {
    try {
      authenticated = false;
      authStatus = AuthStatus.notAuthenticated;
      LocalStorage.prefs.remove('token');
      LocalStorage.prefs.remove('usuario');
      notifyListeners();
    } catch (ex) {}
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');
    LocalStorage.prefs.getString('usuario');

    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    } else {
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    }

    // try {

    // } catch (e) {
    //   authStatus = AuthStatus.notAuthenticated;
    //   notifyListeners();
    //   return false;
    // }
  }
}
