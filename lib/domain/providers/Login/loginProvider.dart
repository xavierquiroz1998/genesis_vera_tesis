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

  Future<void> logeo(BuildContext context) async {
    try {
      var result = Estaticas.listUsuarios
          .firstWhere((e) => e.email == cedula && e.clave == contrasenia);
      if (result.email != "") {
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
