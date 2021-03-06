import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/unidad_medida/unidadMedida.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/unidad_medida/get_medidas.dart';

import '../../uses cases/unidad_medida/delete_medidas.dart';
import '../../uses cases/unidad_medida/insert_medidas.dart';
import '../../uses cases/unidad_medida/update_medidas.dart';
import '../../uses cases/usuarios/update_usuarios.dart';

class UnidadMedidaProvider extends ChangeNotifier {
  UnidadMedidaEntity _unidad = new UnidadMedidaEntity();
  final GetMedidas getMedidas;
  final InsertMedidas insertUnidad;
  final DeleteMedidas deleteUnidad;
  final UpdateMedidas updateUnidad;
  List<UnidadMedidaEntity> listUnidad = [];

  UnidadMedidaProvider(
      this.getMedidas, this.insertUnidad, this.deleteUnidad, this.updateUnidad);

  TextEditingController _controllCodigo = TextEditingController();
  TextEditingController _controlldescripcion = TextEditingController();

  Future<void> callgetMedidas() async {
    var temp = await getMedidas.call();
    try {
      listUnidad = temp.getOrElse(() => []);
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

  TextEditingController get controlldescripcion => _controlldescripcion;

  set controlldescripcion(TextEditingController controlldescripcion) {
    _controlldescripcion = controlldescripcion;
    notifyListeners();
  }

  TextEditingController get controllCodigo => _controllCodigo;

  set controllCodigo(TextEditingController controllCodigo) {
    _controllCodigo = controllCodigo;
    notifyListeners();
  }

  UnidadMedidaEntity get unidad => _unidad;

  set unidad(UnidadMedidaEntity unidad) {
    _unidad = unidad;
    controllCodigo.text = unidad.codigo;
    controlldescripcion.text = unidad.detalle;
    notifyListeners();
  }

  List<UnidadMedidaEntity> get unidades => this.listUnidad;

  set unidades(List<UnidadMedidaEntity> unid) {
    Estaticas.unidades = unid;
    notifyListeners();
  }

  void getValor() {
    try {
      unidad.codigo = controllCodigo.text;
      unidad.detalle = controlldescripcion.text;
      unidad.estado = true;
    } catch (e) {}
  }

  Future<bool> guardar() async {
    try {
      getValor();

      if (unidad.id > 0) {
        // modifica
        var result = await updateUnidad.update(unidad);
      } else {
        // agrega

        var result = await insertUnidad.insert(unidad);
      }
      //  unidades = Estaticas.unidades;
      refresh();
      return true;
    } catch (e) {
      print("erro en guardar ${e.toString()}");
      return false;
    }
  }

  Future<void> anular() async {
    try {
      getValor();
      unidad.estado = false;
      var result = await deleteUnidad.delete(unidad);
      refresh();
    } catch (e) {}
  }

  void refresh() {
    NavigationService.replaceTo("/unidadMedida");
  }
}
