import 'dart:math';

import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:genesis_vera_tesis/domain/entities/tipo/grupo.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/grupo/get_grupos.dart';

import '../../uses cases/grupo/delete_grupo.dart';
import '../../uses cases/grupo/insert_grupos.dart';
import '../../uses cases/grupo/update_grupos.dart';

class GrupoProvider extends ChangeNotifier {
  final GetGrupos getGrupos;
  final InsertGrupo insertGrupo;
  final DeleteGrupo deleteGrupo;
  final UpdateGrupos updateGrupo;
  String isShowUpdate = "1";
  List<GrupoEntity> listGrupo = [];

  GrupoProvider(
      this.getGrupos, this.insertGrupo, this.deleteGrupo, this.updateGrupo);

  Future<void> callgetGrupos() async {
    var temp = await getGrupos.call();
    try {
      listGrupo = temp.getOrElse(() => []);
    } catch (e) {
      print(e);
    }
    notifyListeners();
    //  var result = temp.fold((fail) => failure(fail), (unidades) => unidades);
  }

  Future guardarGrupo(GrupoEntity grupo) async {
    try {
      var result = await insertGrupo.insert(grupo);
    } catch (ex) {}
  }

  Future modifica(GrupoEntity grupo) async {
    try {
      var result = await updateGrupo.update(grupo);
    } catch (ex) {}
  }

  Future anular(GrupoEntity grupo) async {
    try {
      grupo.estado = false;
      var result = await updateGrupo.update(grupo);
      print("Guardado ${result}");
    } catch (ex) {
      print("Erro en anular tipo ${ex.toString()}");
    }
    notifyListeners();
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
