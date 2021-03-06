import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/usuarios/registroUsuarios.dart';

import '../../services/fail.dart';
import '../../uses cases/usuarios/delete_usuarios.dart';
import '../../uses cases/usuarios/get_usuarios.dart';
import '../../uses cases/usuarios/insert_usuario.dart';
import '../../uses cases/usuarios/update_usuarios.dart';

class UsuariosProvider extends ChangeNotifier {
  String isShowUpdate = "1";
  bool blockCedula = true;
  RegistUser _usuario = new RegistUser();

  RegistUser get usuario => _usuario;

  set usuario(RegistUser usuario) {
    _usuario = usuario;
    notifyListeners();
  }

  final GetUsuarios usuarios;
  final InsertUsuarios insertUser;
  final DeleteUsuarios deleteUser;
  final UpdatetUsuarios updateUser;
  List<RegistUser> listaUsuarios = [];
  final controlCedula = TextEditingController();
  final controlNombre = TextEditingController();
  final controlDireccion = TextEditingController();
  final controlEmail = TextEditingController();
  final controlCelular = TextEditingController();
  final controlpassword = TextEditingController();
  final controlpassword2 = TextEditingController();

  UsuariosProvider(
      this.usuarios, this.insertUser, this.deleteUser, this.updateUser);

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

  Future<RegistUser?> saveUser() async {
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
        var tem = result.fold((fail) => Extras.failure(fail), (prd) => prd);
        try {
          var obj = tem as RegistUser;
          clearText();
          return obj;
        } catch (ex) {
          return null;
        }
      } else {
        var user = RegistUser(
            //cedula: controlCedula.text,
            nombre: controlNombre.text,
            //direccion: controlDireccion.text,
            email: controlEmail.text,
            estado: true,
            //celular: controlCelular.text,
            clave: controlpassword.text);
        var result = await updateUser.update(user);
        var tem = result.fold((fail) => Extras.failure(fail), (prd) => prd);
        try {
          var obj = tem as RegistUser;
          clearText();
          return obj;
        } catch (ex) {
          return null;
        }
      }
      // notifyListeners();
    } catch (e) {
      print("Erro en guardar usuario ${e.toString()}");
      return null;
    }
  }

  void fillText(RegistUser usuario) {
    try {
      // controlCedula.text = usuario.cedula;
      controlNombre.text = usuario.nombre;
      // controlDireccion.text = usuario.direccion;
      controlEmail.text = usuario.email;
      //controlCelular.text = usuario.;
      controlpassword.text = usuario.clave;
      controlpassword2.text = usuario.clave;
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

  void anularUsuario(RegistUser e) async {
    try {
      var temp = await deleteUser.delete(e);
      var tem = temp.fold((fail) => Extras.failure(fail), (prd) => prd);
      try {
        var obj = tem as RegistUser;
        clearText();
      } catch (ex) {}
      notifyListeners();
    } catch (e) {
      print("Error usuario ${e.toString()}");
    }
  }
}
