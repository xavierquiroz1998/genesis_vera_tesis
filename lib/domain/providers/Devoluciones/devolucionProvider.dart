import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/domain/entities/Devoluciones/devolucion_cab.dart';
import 'package:genesis_vera_tesis/domain/entities/Devoluciones/devolucion_det.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';

import '../../services/fail.dart';
import '../../uses cases/productos/getproductos.dart';

class DevolucionProvider extends ChangeNotifier {
  DevolucionCab _cab = new DevolucionCab();
  List<DevolucionDet> _detalleDevolucion = [];
  TextEditingController _ctrObservacion = new TextEditingController();
  String _msgError = "";
  List<Productos> listado = [];
  final GetProductos getProductos;

  DevolucionProvider(this.getProductos);

  // prueba devoluciones

  DevolucionCab get cab => _cab;

  set cab(DevolucionCab cab) {
    _cab = cab;
    ctrObservacion.text = cab.observacion == null ? "" : cab.observacion!;
    detalleDevolucion =
        cab.detalleDevolucion == null ? [] : cab.detalleDevolucion!;
  }

  List<DevolucionDet> get detalleDevolucion => _detalleDevolucion;

  set detalleDevolucion(List<DevolucionDet> detalleDevolucion) {
    _detalleDevolucion = detalleDevolucion;
  }

  TextEditingController get ctrObservacion => _ctrObservacion;

  set ctrObservacion(TextEditingController ctrObservacion) {
    _ctrObservacion = ctrObservacion;
  }

  String get msgError => _msgError;

  set msgError(String msgError) {
    _msgError = msgError;
  }

  void agregarDevolucion() {
    detalleDevolucion.add(new DevolucionDet());
    notifyListeners();
  }

  void removerDevolucion(DevolucionDet entity) {
    detalleDevolucion.remove(entity);
    notifyListeners();
  }

  void calcularTotal() {
    for (var item in detalleDevolucion) {
      if (item.cantidad != null && item.precio != null) {
        item.total = item.cantidad! * item.precio!;
      }
    }
    notifyListeners();
  }

  Future<void> cargarPrd() async {
    var temporal = await getProductos.call();
    var result = temporal.fold((fail) => Extras.failure(fail), (prd) => prd);
    try {
      listado = result as List<Productos>;
    } catch (ex) {
      print("error${result.toString()}");
    }
    notifyListeners();
  }

  Future<void> guardarDevolucion() async {
    try {
      cab.estado = "A";
      cab.detalleDevolucion = detalleDevolucion;
      cab.idDevolucion = Estaticas.listDevoluciones.length + 1;
      cab.observacion = ctrObservacion.text;
      Estaticas.listDevoluciones.add(cab);

      msgError = "";
    } catch (e) {
      msgError = "Error ${e.toString()}";
    }
  }
}
