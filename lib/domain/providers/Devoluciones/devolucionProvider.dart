import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:intl/intl.dart';

import '../../entities/Proveedores/Proveedores.dart';
import '../../entities/registro/entityRegistor.dart';
import '../../entities/registro/entityRegistroDetaller.dart';
import '../../services/fail.dart';
import '../../uses cases/movimientos/movimientosGeneral.dart';
import '../../uses cases/productos/getproductos.dart';
import '../../uses cases/proveedores/getproveedores.dart';
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
  List<ProveedoresEntity> listaProveedores = [];
  EntityRegistro pedidoSelec = new EntityRegistro();
  List<EntityRegistroDetalle> detalles = [];
  TextEditingController _ctrObservacion = new TextEditingController();
  String _msgError = "";
  List<Productos> listado = [];
  final GetProductos getProductos;
  final UsesCaseRegistros usesCases;
  final MovimientosGeneral movimientos;
  final GetProveedores useCaseProveedores;

  DevolucionProvider(this.getProductos, this.usesCases, this.movimientos,
      this.useCaseProveedores);

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
  Future<void> getRegistrosDevPRes(int idTipo) async {
    try {
      var tem = await usesCases.getAll(idTipo);

      listTableRegistrosDev = tem.getOrElse(() => []);
    } catch (ex) {
      listTableRegistrosDev = [];
      print("erro en obtener lista ${ex.toString()}");
    }
    notifyListeners();
  }

  Future<void> getRegistrosDev(int idTipo) async {
    try {
      if (idTipo == 2) {
        var tem = await usesCases.getAll(idTipo);

        listTableRegistrosDev = tem.getOrElse(() => []);
      } else {
        listTableRegistrosDev = [];
        var tempMovi = await movimientos.getMovientos();
        var resultMovi = tempMovi.getOrElse(() => []);

        for (var item in resultMovi) {
          EntityRegistro r = new EntityRegistro();
          r.id = item.idProducto;
          r.detalle = item.codigo;
          r.cliente = item.total.toString();
          r.estado = true;
          listTableRegistrosDev.add(r);
        }
      }
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
    try {
      print("erroe n detalles ${detalles.length}");
      for (var item in detalles) {
        print("valores ${item.cantidad}------${item.total}" +
            item.productos!.proveedor!.nombre);
        item.to = item.cantidad * item.total;
      }
    } catch (ex) {
      print("error en calcular ${ex.toString()}");
    }

    //notifyListeners();
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
      reg.cliente = cab.cliente;

      reg.referencia = int.parse(await generarT(cab.cliente));
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

  Future<void> cargarProveedores() async {
    var temporal = await useCaseProveedores.call();
    var result = temporal.fold((fail) => Extras.failure(fail), (prd) => prd);
    try {
      listaProveedores = result as List<ProveedoresEntity>;
    } catch (ex) {
      print("error${result.toString()}");
    }
    notifyListeners();
  }

  Future cargarDetalle(int idRegistro, [bool lote = false]) async {
    try {
      if (lote) {
        detalles = [];
        await cargarProveedores();
        EntityRegistroDetalle det = new EntityRegistroDetalle();
        det.productos = listado.where((e) => e.id == pedidoSelec.id).first;
        det.productos!.proveedor = listaProveedores
            .where((e) => e.id == det.productos!.idProveedor)
            .first;
        print("ssssssssssssssssssssssssss");

        det.idProducto = pedidoSelec.id;
        det.cantidad = int.parse(pedidoSelec.cliente);
        detalles.add(det);
      } else {
        var transaction = await usesCases.getADetalle(idRegistro);
        detalles = transaction.getOrElse(() => []);
        print("value de detalles ${detalles.length}");
        for (var item in detalles) {
          item.productos = listado.where((e) => e.id == item.idProducto).first;
          item.productos!.proveedor =
              ProveedoresEntity(nombre: "SIN ASIGNACION");
        }
      }
      print("............ ${cab.idSecundario}---------${cab.id}");
      if (cab.id != 0 && cab.idSecundario != 0) {
        print("ingreso= valor de listado ${listTableRegistrosDev.length}");
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
        codRef += await generarT(cab.cliente, cab.referencia);
      }
      calcularTotal();
      //notifyListeners();
    } catch (ex) {
      print("Error en cargar detalle devolucion ${ex.toString()}");
      //throw ("This is an Error");
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

  Future<String> generarT(String tipo, [int exis = 0]) async {
    final formato = new NumberFormat("0000.##");
    List<EntityRegistro> listDev = [];
    try {
      try {
        var tem = await usesCases.getAll(3);

        listDev = tem.getOrElse(() => []);
      } catch (ex) {
        listDev = [];
        print("erro en obtener lista ${ex.toString()}");
      }

      var tem = listDev.where((e) => e.cliente == tipo).toList();
      int total = exis == 0 ? tem.length + 1 : exis;
      return formato.format(total);
    } catch (ex) {
      print("Error en generar codRef ${ex.toString()}");
      return "0001";
    }
  }
}
