import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:genesis_vera_tesis/domain/entities/proyecto/proyecto_entity.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/proyecto/get_proyectos.dart';

class ProyectoProvider extends ChangeNotifier {
  final GetProyectos getGrupos;
  List<ProyectoEntity> listGrupo = [];

  ProyectoProvider(this.getGrupos);

  Future<void> callgetProyecto() async {
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
