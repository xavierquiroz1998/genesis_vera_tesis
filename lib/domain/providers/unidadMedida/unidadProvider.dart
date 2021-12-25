import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/unidad_medida/unidadMedida.dart';

class UnidadMedidaProvider extends ChangeNotifier {
  UnidadMedida _unidad = new UnidadMedida();

  TextEditingController _controllCodigo = TextEditingController();
  TextEditingController _controlldescripcion = TextEditingController();

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

  UnidadMedida get unidad => _unidad;

  set unidad(UnidadMedida unidad) {
    _unidad = unidad;
    controllCodigo.text = unidad.codigo ?? "";
    controlldescripcion.text = unidad.descripcion ?? "";
    notifyListeners();
  }

  List<UnidadMedida> get unidades => Estaticas.unidades;

  set unidades(List<UnidadMedida> unid) {
    Estaticas.unidades = unid;
    notifyListeners();
  }

  void getValor() {
    try {
      unidad.codigo = controllCodigo.text;
      unidad.descripcion = controlldescripcion.text;
    } catch (e) {}
  }

  Future<bool> guardar() async {
    try {
      getValor();

      if (unidad.id != null) {
        // modifica
        Estaticas.unidades.remove(unidad);
        Estaticas.unidades.add(unidad);
      } else {
        // agrega
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
      }
      unidades = Estaticas.unidades;

      return true;
    } catch (e) {
      print("erro en guardar ${e.toString()}");
      return false;
    }
  }
}
