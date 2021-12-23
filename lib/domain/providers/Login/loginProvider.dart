import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/main.dart';
import 'package:genesis_vera_tesis/ui/Router/FluroRouter.dart';

class LoginProvider extends ChangeNotifier {
  String _cedula = "";
  String get cedula => _cedula;
  final _keyLogin = GlobalKey<FormState>();

  set cedula(String cedula) {
    _cedula = cedula;
    notifyListeners();
  }

  String _contrasenia = "";

  GlobalKey<FormState> get keyLogin => _keyLogin;

  String get contrasenia => _contrasenia;

  set contrasenia(String contrasenia) {
    _contrasenia = contrasenia;
    notifyListeners();
  }

  void logeo(BuildContext context) {
    try {
      if (keyLogin.currentState!.validate()) {
        var result = Estaticas.listUsuarios.firstWhere(
            (e) => e.cedula == cedula && e.contrasenia == contrasenia);
        if (result.cedula != "") {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (_) => HomePage(),
          //   ),
          // );
          NavigationService.replaceTo(Flurorouter.incio);
        }
      }
    } catch (e) {}
  }
}
