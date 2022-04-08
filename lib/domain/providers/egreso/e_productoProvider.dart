import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/egreso/egresoProducto.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/productos/getproductos.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/productos/productosGeneral.dart';
import 'package:intl/intl.dart';

import '../../../data/models/movimiento/modelMovimiento.dart';
import '../../entities/registro/entityRegistor.dart';
import '../../entities/registro/entityRegistroDetaller.dart';
import '../../services/fail.dart';
import '../../uses cases/movimientos/movimientosGeneral.dart';
import '../../uses cases/registros/usesCaseRegistros.dart';

class EProductoProvider extends ChangeNotifier {
  //EgresoCabecera _listPRoduct = new EgresoCabecera();
  EntityRegistro _cab = new EntityRegistro();

  EntityRegistro get cab => _cab;
  String codRef = "";
  set cab(EntityRegistro cab) {
    _cab = cab;
    ctrObservacion.text = cab.detalle;
    ctrCliente.text = cab.cliente;
    notifyListeners();
  }

  List<EntityRegistro> listTableRegistrosDev = [];
  List<EntityRegistroDetalle> detalles = [];
  TextEditingController _ctrObservacion = new TextEditingController();
  TextEditingController _ctrCliente = new TextEditingController();

  TextEditingController get ctrCliente => _ctrCliente;

  set ctrCliente(TextEditingController ctrCliente) {
    _ctrCliente = ctrCliente;
    notifyListeners();
  }

  List<Productos> listado = [];
  List<ModelMovimiento> listaMovimientos = [];
  double to = 0;
  final GetProductos getProductos;
  final UsesCaseRegistros usesCases;
  final GeneralProducto generalProducto;
  final MovimientosGeneral movimientosGeneral;

  EProductoProvider(this.getProductos, this.usesCases, this.generalProducto,
      this.movimientosGeneral);

  TextEditingController get ctrObservacion => _ctrObservacion;

  set ctrObservacion(TextEditingController ctrObservacion) {
    _ctrObservacion = ctrObservacion;
    notifyListeners();
  }

  Productos _prd = new Productos();

  Productos get prd => _prd;

  set prd(Productos prd) {
    _prd = prd;
    notifyListeners();
  }

  void calcular() {
    for (var item in detalles) {
      item.to = item.cantidad * item.total;
    }
    notifyListeners();
  }

  // EgresoCabecera get listaProducto => _listPRoduct;

  // set listaProducto(EgresoCabecera cab) {
  //   cab.detalle = [];
  //   _listPRoduct = cab;
  //   notifyListeners();
  // }

  void agregar() {
    detalles.add(new EntityRegistroDetalle());

    notifyListeners();
  }

  void remover(EntityRegistroDetalle e) {
    detalles.remove(e);
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

  Future cargarMovimientos() async {
    try {
      var temp = await movimientosGeneral.getMovientos();
      listaMovimientos = temp.getOrElse(() => []);

      notifyListeners();
    } catch (ex) {
      print("Erro en obtener movimientos ${ex.toString()}");
    }
  }

  Future<void> getRegistrosDev() async {
    try {
      var tem = await usesCases.getAll(2);

      listTableRegistrosDev = tem.getOrElse(() => []);

      notifyListeners();
    } catch (ex) {
      listTableRegistrosDev = [];
    }
  }

  Future<void> guardarEgreso() async {
    try {
      EntityRegistro reg = new EntityRegistro();
      reg.idTipo = 2;
      reg.detalle = ctrObservacion.text;
      reg.estado = true;
      reg.cliente = ctrCliente.text;
      reg.referencia = int.parse(codRef);
      reg.fecha = cab.fecha;
      var result = await usesCases.insertRegistros(reg);
      var tem = result.fold((fail) => Extras.failure(fail), (prd) => prd);
      tem as EntityRegistro;
      for (var item in detalles) {
        item.idRegistro = tem.id;
        var detResultv = await usesCases.insertRegistrosDetalles(item);
      }
    } catch (e) {
      print("Error en guardar ${e.toString()}");
      throw ("Error ${e.toString()}");
    }
  }

  Future anular(EntityRegistro cab) async {
    try {
      cab.estado = false;
      var tem = await usesCases.updateRegistros(cab);
      var result = tem.getOrElse(() => new EntityRegistro());

      await cargarPrd();
      await cargarDetalle(cab.id);
      for (var item in detalles) {
        item.productos!.cantidad += item.cantidad;
        await generalProducto.update(item.productos!);
      }
    } catch (ex) {}

    notifyListeners();
  }

  Future actualizar() async {
    try {
      if (cab.id != 0) {
        cab.detalle = ctrObservacion.text;
        cab.cliente = ctrCliente.text;
        var tem = await usesCases.updateRegistros(cab);
        var result = tem.getOrElse(() => new EntityRegistro());
        //detalle

        for (var item in detalles) {
          var tem1 = await usesCases.updateRegistrosDetalles(item);
        }
      }
    } catch (ex) {
      print("Error en actualizar egreso ${ex.toString()}");
    }

    notifyListeners();
  }

  Future cargarDetalle(int idRegistro) async {
    try {
      var transaction = await usesCases.getADetalle(idRegistro);
      detalles = transaction.getOrElse(() => []);
      for (var item in detalles) {
        item.productos = listado.where((e) => e.id == item.idProducto).first;
      }
      calcular();
      notifyListeners();
    } catch (ex) {
      print("Error en cargar detalle egreso ${ex.toString()}");
    }
  }

  void generar([int exis = 0]) {
    final formato = new NumberFormat("0000.##");
    try {
      int total = exis == 0 ? listTableRegistrosDev.length + 1 : exis;
      codRef = formato.format(total);
    } catch (ex) {
      print("Error en generar codRef ${ex.toString()}");
      codRef = "0000";
    }
    //notifyListeners();
  }
}
