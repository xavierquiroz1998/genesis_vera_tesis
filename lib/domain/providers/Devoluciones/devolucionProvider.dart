import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:intl/intl.dart';

import '../../entities/registro/entityRegistor.dart';
import '../../entities/registro/entityRegistroDetaller.dart';
import '../../services/fail.dart';
import '../../uses cases/productos/getproductos.dart';
import '../../uses cases/registros/usesCaseRegistros.dart';

class DevolucionProvider extends ChangeNotifier {
  // DevolucionCab _cab = new DevolucionCab();
  // List<DevolucionDet> _detalleDevolucion = [];
  EntityRegistro _cab = new EntityRegistro();
  String codRef = "";
  EntityRegistro get cab => _cab;

  set cab(EntityRegistro cab) {
    _cab = cab;
    ctrObservacion.text = cab.detalle;

    print("-------------${cab.idSecundario}");
    notifyListeners();
  }

  List<EntityRegistro> listTableRegistrosDev = [];
  EntityRegistro pedidoSelec = new EntityRegistro();
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

  Future<void> getRegistrosDev(int idTipo) async {
    try {
      var tem = await usesCases.getAll(idTipo);

      listTableRegistrosDev = tem.getOrElse(() => []);
    } catch (ex) {
      listTableRegistrosDev = [];
      print("erro en obtener lista ${ex.toString()}");
    }
    notifyListeners();
  }

  Future<void> anular(EntityRegistro reg) async {
    try {
      reg.estado = false;
      var result = await usesCases.updateRegistros(reg);
      var tem = result.fold((fail) => Extras.failure(fail), (prd) => prd);
      tem as EntityRegistro;
    } catch (ex) {
      print("Erro en anular registro de devolucion ${ex.toString()}");
    }
    notifyListeners();
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
      reg.idTipo = 3;
      reg.detalle = ctrObservacion.text;
      reg.estado = true;
      reg.idSecundario = cab.idSecundario;
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

  Future cargarDetalle(int idRegistro) async {
    try {
      var transaction = await usesCases.getADetalle(idRegistro);
      detalles = transaction.getOrElse(() => []);
      for (var item in detalles) {
        item.productos = listado.where((e) => e.id == item.idProducto).first;
      }

      if (cab.id != 0 && cab.idSecundario != 0) {
        await getRegistrosDev(2);
        try {
          var temp = listTableRegistrosDev
              .where((e) => e.id == cab.idSecundario)
              .first;
          if (temp != null) {
            codRef = "Dev / cl-";
          }
        } catch (ex) {
          codRef = "Dev / pr-";
        }
        codRef += await generarT(cab.referencia);
      }
      calcularTotal();
      notifyListeners();
    } catch (ex) {
      print("Error en cargar detalle devolucion ${ex.toString()}");
      throw ("This is an Error");
    }
  }

  String generar(int value) {
    final formato = new NumberFormat("0000.##");
    try {
      return formato.format(value);
    } catch (ex) {
      print("Error en generar codRef ${ex.toString()}");
      return "0000";
    }
  }

  Future<String> generarT([int exis = 0]) async {
    final formato = new NumberFormat("0000.##");
    try {
      if (listTableRegistrosDev.length == 0) {
        await getRegistrosDev(3);
      }
      int total = exis == 0 ? listTableRegistrosDev.length + 1 : exis;
      return formato.format(total);
    } catch (ex) {
      print("Error en generar codRef ${ex.toString()}");
      return "0001";
    }
  }
}
