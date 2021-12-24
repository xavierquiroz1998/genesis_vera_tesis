import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/unidad_medida/unidadMedida.dart';

class UnidadMedidaProvider extends ChangeNotifier {
  UnidadMedida _unidad = new UnidadMedida();

  UnidadMedida get unidad => _unidad;

  set unidad(UnidadMedida unidad) {
    _unidad = unidad;
    notifyListeners();
  }

  List<UnidadMedida> get unidades => Estaticas.unidades;

  set unidades(List<UnidadMedida> unid) {
    Estaticas.unidades = unid;
    notifyListeners();
  }

  Future<bool> guardar() async {
    try {
      var existe =
          unidades.firstWhere((e) => e.codigo == unidad.codigo, orElse: () {
        return new UnidadMedida();
      });
      if (existe.codigo != null) {
        return false;
      }
      unidad.id = unidades.length + 1;
      unidad.estado = "A";
      Estaticas.unidades.add(unidad);
      unidades = Estaticas.unidades;
      return true;
    } catch (e) {
      print("erro en guardar ${e.toString()}");
      return false;
    }
  }
}
