import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/productos/getproductos.dart';

import '../../../data/models/movimiento/modelMovimiento.dart';
import '../../entities/registro/entityRegistor.dart';
import '../../entities/registro/entityRegistroDetaller.dart';
import '../../services/fail.dart';
import '../../uses cases/movimientos/movimientosGeneral.dart';
import '../../uses cases/productos/productosGeneral.dart';
import '../../uses cases/registros/usesCaseRegistros.dart';

class IngresosProvider extends ChangeNotifier {
  //EgresoCabecera _listPRoduct = new EgresoCabecera();
  EntityRegistro _cab = new EntityRegistro();

  EntityRegistro get cab => _cab;

  set cab(EntityRegistro cab) {
    _cab = cab;
    ctrObservacion.text = cab.detalle;
    notifyListeners();
  }

  List<EntityRegistro> listTableRegistrosDev = [];
  List<EntityRegistroDetalle> detalles = [];
  TextEditingController _ctrObservacion = new TextEditingController();
  List<Productos> listado = [];
  double to = 0;
  final GetProductos getProductos;
  final UsesCaseRegistros usesCases;
  final MovimientosGeneral mov;
  final GeneralProducto prdGeneral;
  var isSelectProduct;
  IngresosProvider(
      this.getProductos, this.usesCases, this.mov, this.prdGeneral);

  TextEditingController get ctrObservacion => _ctrObservacion;

  set ctrObservacion(TextEditingController ctrObservacion) {
    _ctrObservacion = ctrObservacion;
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
      print("error cargar detalle ingreso${ex.toString()}");
    }
  }

  void agregar() {
    EntityRegistroDetalle det = new EntityRegistroDetalle();
    det.productos = new Productos();

    detalles.add(det);

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

  Future<void> getRegistrosDev() async {
    try {
      var tem = await usesCases.getAll(1);

      listTableRegistrosDev = tem.getOrElse(() => []);

      notifyListeners();
    } catch (ex) {
      listTableRegistrosDev = [];
    }
  }

  Future<void> guardarIngresos() async {
    try {
      EntityRegistro reg = new EntityRegistro();
      reg.idTipo = 1;
      reg.detalle = ctrObservacion.text;
      reg.estado = true;
      var result = await usesCases.insertRegistros(reg);
      var tem = result.fold((fail) => Extras.failure(fail), (prd) => prd);
      tem as EntityRegistro;
      for (var item in detalles) {
        item.idRegistro = tem.id;
        var detResultv = await usesCases.insertRegistrosDetalles(item);
// regista ingreso de producto;
        item.productos!.cantidad += item.cantidad;
        await prdGeneral.update(item.productos!);

// registra movimiento
        ModelMovimiento md = new ModelMovimiento();
        md.idProducto = item.idProducto;
        md.codigo = Random().nextInt(10000000).toString();
        await mov.insertMov(md);
      }

//--------------------------------------------
      // int sec = 0;
      // for (var item in listaProducto.detalle!) {
      //   var result =
      //       Estaticas.listProductos.firstWhere((e) => e.id == item.idProducto);
      //   if (result.id > 0) {
      //     //double totalStock = result.stock! - item.cantidad;
      //     Estaticas.listProductos.remove(result);
      //     //result.stock = totalStock;
      //     Estaticas.listProductos.add(result);
      //     item.idEgresoDetalle = item.secuencia = sec++;
      //     item.total = item.cantidad * item.precio!;
      //   }
      // }
      // listaProducto.observacion = ctrObservacion.text;
      // listaProducto.estado = "A";
      // listaProducto.detalle!.forEach((e) {
      //   listaProducto.total += e.total!;
      // });
      // listaProducto.idEgreso = Estaticas.listProductosEgreso.length + 1;
      // Estaticas.listProductosEgreso.add(listaProducto);
    } catch (e) {
      print("Error en guardar ${e.toString()}");
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
        item.productos!.cantidad -= item.cantidad;
        await prdGeneral.update(item.productos!);
      }
    } catch (ex) {
      print("Erro al Anular ingreso ${ex.toString()}");
    }

    notifyListeners();
  }

  Future actualizar() async {
    print(listado.toString());
    try {
      if (cab.id != 0) {
        cab.detalle = ctrObservacion.text;
        var tem = await usesCases.updateRegistros(cab);
        var result = tem.getOrElse(() => new EntityRegistro());
        //detalle

        for (var item in detalles) {
          var tem1 = await usesCases.updateRegistrosDetalles(item);
        }
      }
    } catch (ex) {}

    notifyListeners();
  }
}
