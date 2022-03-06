import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:genesis_vera_tesis/domain/entities/tipo/grupo.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/grupo/get_grupos.dart';

class GrupoProvider extends ChangeNotifier {
  final GetGrupos getGrupos;
  String isShowUpdate = "1";
  List<GrupoEntity> listGrupo = [];

  GrupoProvider(this.getGrupos);

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

  String failure(Failure fail) {
    switch (fail.runtimeType) {
      case ServerFailure:
        return "Ocurrio un Error";

      default:
        return "Error";
    }
  }
}
