import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/usuarios/registroUsuarios.dart';

import '../../uses cases/usuarios/get_usuarios.dart';
import '../../uses cases/usuarios/insert_usuario.dart';

class UsuariosProvider extends ChangeNotifier {
  String isShowUpdate = "1";
  bool blockCedula = true;

  final GetUsuarios usuarios;
  final InsertUsuarios insertUser;
  List<RegistUser> listaUsuarios = [];
  final controlCedula = TextEditingController();
  final controlNombre = TextEditingController();
  final controlDireccion = TextEditingController();
  final controlEmail = TextEditingController();
  final controlCelular = TextEditingController();
  final controlpassword = TextEditingController();
  final controlpassword2 = TextEditingController();

  UsuariosProvider(this.usuarios, this.insertUser);

  String get getIsShow => isShowUpdate;

  set setIsShow(String repiteContrasenia) {
    isShowUpdate = repiteContrasenia;
    notifyListeners();
  }

  Future cargaProveedores() async {
    var temp = await usuarios.call();
    try {
      listaUsuarios = temp.getOrElse(() => []);
    } catch (ex) {}
    notifyListeners();
  }

  Future saveUser() async {
    try {
      if (isShowUpdate == "1") {
        var user = RegistUser(
            //cedula: controlCedula.text,
            nombre: controlNombre.text,
            //direccion: controlDireccion.text,
            email: controlEmail.text,
            estado: true,
            //celular: controlCelular.text,
            clave: controlpassword.text);
        var result = await insertUser.insertUsuario(user);
      } else {
        // Estaticas.listUsuarios = Estaticas.listUsuarios.map((e) {
        //   if (e.cedula != controlCedula.text) return e;
        //   e.nombres = controlNombre.text;
        //   e.direccion = controlDireccion.text;
        //   e.correo = controlEmail.text;
        //   e.celular = controlCelular.text;
        //   e.contrasenia = controlpassword.text;

        //   return e;
        // }).toList();
        print(Estaticas.listUsuarios);
      }
      notifyListeners();
    } catch (e) {
      print("Erro en guardar usuario ${e.toString()}");
    }
  }

  void fillText(RegistUser usuario) {
    try {
      // controlCedula.text = usuario.cedula;
      // controlNombre.text = usuario.nombres;
      // controlDireccion.text = usuario.direccion;
      // controlEmail.text = usuario.correo;
      // controlCelular.text = usuario.celular;
      controlpassword.text = "";
      controlpassword2.text = "";
      blockCedula = false;
      isShowUpdate = "0";
      notifyListeners();
    } catch (e) {
      print("Error usuario ${e.toString()}");
    }
  }

  void clearText() {
    controlCedula.clear();
    controlNombre.clear();
    controlDireccion.clear();
    controlEmail.clear();
    controlCelular.clear();
    controlpassword.clear();
    controlpassword2.clear();
    blockCedula = true;
    isShowUpdate = '1';
  }

  void deleteUser(RegistUser e) {
    try {
      Estaticas.listUsuarios.remove(e);
      notifyListeners();
    } catch (e) {
      print("Error usuario ${e.toString()}");
    }
  }
}
