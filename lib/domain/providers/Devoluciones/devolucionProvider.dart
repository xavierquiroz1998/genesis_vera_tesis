import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/domain/entities/Devoluciones/devolucion_cab.dart';
import 'package:genesis_vera_tesis/domain/entities/Devoluciones/devolucion_det.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';

import '../../entities/registro/entityRegistor.dart';
import '../../entities/registro/entityRegistroDetaller.dart';
import '../../services/fail.dart';
import '../../uses cases/productos/getproductos.dart';
import '../../uses cases/registros/usesCaseRegistros.dart';

class DevolucionProvider extends ChangeNotifier {
  // DevolucionCab _cab = new DevolucionCab();
  // List<DevolucionDet> _detalleDevolucion = [];
  EntityRegistro cab = new EntityRegistro();
  List<EntityRegistro> listTableRegistrosDev = [];
  List<EntityRegistroDetalle> detalles = [];
  TextEditingController _ctrObservacion = new TextEditingController();
  String _msgError = "";
  List<Productos> listado = [];
  final GetProductos getProductos;
  final UsesCaseRegistros usesCases;

  DevolucionProvider(this.getProductos, this.usesCases);

  // prueba devoluciones

  // DevolucionCab get cab => _cab;

  // set cab(DevolucionCab cab) {
  //   _cab = cab;
  //   ctrObservacion.text = cab.observacion == null ? "" : cab.observacion!;
  //   detalleDevolucion =
  //       cab.detalleDevolucion == null ? [] : cab.detalleDevolucion!;
  // }

  // List<DevolucionDet> get detalleDevolucion => _detalleDevolucion;

  // set detalleDevolucion(List<DevolucionDet> detalleDevolucion) {
  //   _detalleDevolucion = detalleDevolucion;
  // }

  Future<void> getRegistrosDev() async {
    try {
      var tem = await usesCases.getAll();

      listTableRegistrosDev = tem.getOrElse(() => []);

      notifyListeners();
    } catch (ex) {
      listTableRegistrosDev = [];
    }
  }

  Future<void> anular(EntityRegistro reg) async {
    try {
      var result = await usesCases.deleteRegistros(reg);
      var tem = result.fold((fail) => Extras.failure(fail), (prd) => prd);
      tem as EntityRegistro;
    } catch (ex) {}
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
    detalles.add(new EntityRegistroDetalle());
    notifyListeners();
  }

  void removerDevolucion(EntityRegistroDetalle entity) {
    detalles.remove(entity);
    notifyListeners();
  }

  void calcularTotal() {
    for (var item in detalles) {
      item.to = item.cantidad * item.total;
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
      // cab.estado = "A";
      // cab.detalleDevolucion = detalleDevolucion;
      // cab.idDevolucion = Estaticas.listDevoluciones.length + 1;
      // cab.observacion = ctrObservacion.text;
      // Estaticas.listDevoluciones.add(cab);

      EntityRegistro reg = new EntityRegistro();
      reg.idTipo = "1";
      reg.detalle = ctrObservacion.text;
      reg.estado = true;
      var result = await usesCases.insertRegistros(reg);
      var tem = result.fold((fail) => Extras.failure(fail), (prd) => prd);
      tem as EntityRegistro;
      for (var item in detalles) {
        item.idRegistro = tem.id;
        var detResultv = await usesCases.insertRegistrosDetalles(item);
      }

      msgError = "";
    } catch (e) {
      msgError = "Error ${e.toString()}";
    }
  }
}
