import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:genesis_vera_tesis/domain/entities/proyecto/proyecto_entity.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/proyecto/get_proyectos.dart';

import '../../../data/datasource/reference/local_storage.dart';
import '../../entities/permiso/permiso_entity.dart';
import '../../services/fail.dart';
import '../../uses cases/permiso/get_permiso.dart';
import '../../uses cases/permiso/insert_permiso.dart';
import '../../uses cases/permiso/update_permiso.dart';

class ProyectoProvider extends ChangeNotifier {
  final GetProyectos getProyect;
  final InsertPermiso insertPermisos;
  final GetPermiso getGrupos;
  //final UpdatePermiso updatePermiso;
  List<ProyectoEntity> listProyectos = [];
  List<PermisosEntity> listGrupo = [];

  ProyectoProvider(this.getProyect, this.insertPermisos, this.getGrupos);

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

  Future cargarPermisso(int idUsuario) async {
    try {
      var temp = await getGrupos.call(idUsuario.toString());

      listGrupo = temp.getOrElse(() => []);

      for (var item in listProyectos) {
        var temporal = listGrupo.where((e) => e.idProyecto == item.id).first;
        if (temporal != null) {
          item.idReg = temporal.id;
          item.crear = temporal.creacion == 1 ? true : false;
          item.modificar = temporal.actualizar == 1 ? true : false;
          item.anular = temporal.anular == 1 ? true : false;
          item.consultar = temporal.consulta == 1 ? true : false;
        }
      }
    } catch (e) {
      print("erro en cargar detalle ${e.toString()}");
    }
    notifyListeners();
  }

  Future guardar(int idUsuario, bool update) async {
    try {
      for (var item in listProyectos) {
        if (item.crear || item.modificar || item.consultar || item.anular) {
          PermisosEntity permiss = new PermisosEntity();
          permiss.idProyecto = item.id;
          permiss.idUsuario = idUsuario;
          permiss.creacion = item.crear ? 1 : 0;
          permiss.actualizar = item.modificar ? 1 : 0;
          permiss.anular = item.anular ? 1 : 0;
          permiss.consulta = item.consultar ? 1 : 0;
          permiss.estado = true;

          if (update) {
            var result = await insertPermisos.inserPermis(permiss);
            var tem = result.fold((fail) => Extras.failure(fail), (prd) => prd);
            var obj = tem as PermisosEntity;
          } else {
            // permiss.id = item.idReg;
            // var result = await updatePermiso.update(permiss);
            // var tem = result.fold((fail) => Extras.failure(fail), (prd) => prd);
            // var obj = tem as PermisosEntity;
          }
        }
      }
      clear();
    } catch (ex) {
      print("erro en guardar ${ex.toString()}");
    }
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
