import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/usuarios/registroUsuarios.dart';

class UsuariosProvider extends ChangeNotifier {
  RegistUser _usuarioModel = new RegistUser();
  String _repiteContrasenia = "";

  String get repiteContrasenia => _repiteContrasenia;

  set repiteContrasenia(String repiteContrasenia) {
    _repiteContrasenia = repiteContrasenia;
    notifyListeners();
  }

  RegistUser get usuarioModel => _usuarioModel;

  set usuarioModel(RegistUser usuarioModel) {
    _usuarioModel = usuarioModel;
    notifyListeners();
  }

  void guardar() {
    try {
      if (usuarioModel.contrasenia == repiteContrasenia) {
        Estaticas.listUsuarios.add(usuarioModel);
      }
    } catch (e) {
      print("Erro en guardar usuario ${e.toString()}");
    }
  }
}
