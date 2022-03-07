import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/logeo/inicio_sesion.dart';
import 'package:genesis_vera_tesis/ui/Router/FluroRouter.dart';

class LoginProvider extends ChangeNotifier {
  String _cedula = "";

  LoginProvider(this.logeoUsesCase);
  String get cedula => _cedula;

  bool authenticated = false;

  set cedula(String cedula) {
    _cedula = cedula;
    notifyListeners();
  }

  final InicioSesion logeoUsesCase;

  String _contrasenia = "";

  String get contrasenia => _contrasenia;

  set contrasenia(String contrasenia) {
    _contrasenia = contrasenia;
    notifyListeners();
  }

  Future<void> logeo(BuildContext context) async {
    try {
      var result = Estaticas.listUsuarios.firstWhere(
          (e) => e.cedula == cedula && e.contrasenia == contrasenia);
      if (result.cedula != "") {
        final result = await logeoUsesCase.call(cedula, contrasenia);
        print("valor de result $result");
        authenticated = true;
        notifyListeners();
        NavigationService.replaceTo(Flurorouter.inicio);
      }
    } catch (e) {}
  }

  Future<void> lagout() async {
    try {
      authenticated = false;
      notifyListeners();
    } catch (ex) {}
  }
}
