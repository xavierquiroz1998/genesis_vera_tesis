import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/domain/entities/usuarios/registroUsuarios.dart';

class UsuariosProvider extends ChangeNotifier {
  RegistUser _usuarioModel = new RegistUser();

  RegistUser get usuarioModel => _usuarioModel;

  set usuarioModel(RegistUser usuarioModel) {
    _usuarioModel = usuarioModel;
    notifyListeners();
  }
}
