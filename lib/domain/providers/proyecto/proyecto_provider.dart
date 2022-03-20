import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:genesis_vera_tesis/domain/entities/proyecto/proyecto_entity.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/proyecto/get_proyectos.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/proyecto/insert_proyectos.dart';

import '../../entities/permiso/permiso_entity.dart';
import '../../services/fail.dart';
import '../../uses cases/permiso/insert_permiso.dart';

class ProyectoProvider extends ChangeNotifier {
  final GetProyectos getProyect;
  final InsertPermiso insertPermisos;
  List<ProyectoEntity> listProyectos = [];

  ProyectoProvider(this.getProyect, this.insertPermisos);

  Future<void> callgetProyecto() async {
    var temp = await getProyect.call();
    try {
      listProyectos = temp.getOrElse(() => []);
    } catch (e) {
      print(e);
    }
    notifyListeners();
    //  var result = temp.fold((fail) => failure(fail), (unidades) => unidades);
  }

  Future guardar(int idUsuario) async {
    try {
      for (var item in listProyectos) {
        if (item.crear || item.modificar || item.consultar || item.anular) {
          PermisosEntity permiss = new PermisosEntity(
            idProyecto: item.id,
            idUsuario: idUsuario,
            creacion: item.crear ? 1 : 0,
            actualizar: item.modificar ? 1 : 0,
            anular: item.anular ? 1 : 0,
            consulta: item.consultar ? 1 : 0,
            estado: true,
          );
          var result = await insertPermisos.inserPermis(permiss);
          var tem = result.fold((fail) => Extras.failure(fail), (prd) => prd);
          var obj = tem as PermisosEntity;
        }
      }
      clear();
    } catch (ex) {}
  }

  String failure(Failure fail) {
    switch (fail.runtimeType) {
      case ServerFailure:
        return "Ocurrio un Error";

      default:
        return "Error";
    }
  }

  void clear() {
    listProyectos = [];
  }
}
