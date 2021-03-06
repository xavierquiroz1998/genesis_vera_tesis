import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:genesis_vera_tesis/domain/entities/permiso/permiso_entity.dart';
import 'package:genesis_vera_tesis/domain/entities/usuarios/registroUsuarios.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/permiso/get_permiso.dart';

import '../../../data/datasource/reference/local_storage.dart';

class PermisoProvider extends ChangeNotifier {
  final GetPermiso getGrupos;
  List<PermisosEntity> listGrupo = [];

  PermisoProvider(this.getGrupos);

  Future<void> callgetPermisos() async {
    var usuario = LocalStorage.prefs.getString('usuario');
    var mapUsuario = json.decode(usuario!);
    var temp =
        await getGrupos.call(RegistUser.fromMap(mapUsuario).id.toString());
    try {
      listGrupo = temp.getOrElse(() => []);
    } catch (e) {
      print(e);
    }
    notifyListeners();
    //  var result = temp.fold((fail) => failure(fail), (unidades) => unidades);
  }

  String failure(Failure fail) {
    switch (fail.runtimeType) {
      case ServerFailure:
        return "Ocurrio un Error";

      default:
        return "Error";
    }
  }
}
