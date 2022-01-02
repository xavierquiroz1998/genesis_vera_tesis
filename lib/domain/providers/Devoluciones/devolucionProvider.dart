import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/domain/entities/Devoluciones/devoluciones_entity.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';

class DevolucionProvider extends ChangeNotifier {
  DevolucionesEntity _devolucion = new DevolucionesEntity();
  List<DevolucionesEntity> _listaDevolucion = [];
  String _msgError = "";

  String get msgError => _msgError;

  set msgError(String msgError) {
    _msgError = msgError;
  }

  List<DevolucionesEntity> get listaDevolucion => _listaDevolucion;

  set listaDevolucion(List<DevolucionesEntity> listaDevolucion) {
    _listaDevolucion = listaDevolucion;
  }

  DevolucionesEntity get devolucion => _devolucion;

  set devolucion(DevolucionesEntity devolucion) {
    _devolucion = devolucion;
  }

  void agregarDevolucion() {
    listaDevolucion.add(new DevolucionesEntity());
    notifyListeners();
  }

  void removerDevolucion(DevolucionesEntity entity) {
    listaDevolucion.remove(entity);
    notifyListeners();
  }

  void calcularTotal() {
    for (var item in listaDevolucion) {
      if (item.cantidad != null && item.precio != null) {
        item.total = item.cantidad! * item.precio!;
      }
    }
    notifyListeners();
  }

  Future<void> guardarDevolucion() async {
    try {
      for (var item in listaDevolucion) {
        Estaticas.listDevoluciones.add(item);
      }

      msgError = "Ocurrio un error";
    } catch (e) {
      msgError = "Error ${e.toString()}";
    }
  }
}
