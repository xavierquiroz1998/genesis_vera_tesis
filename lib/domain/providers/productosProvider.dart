import 'dart:math';

import 'package:darq/darq.dart';
import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:genesis_vera_tesis/data/models/movimiento/modelMovimiento.dart';

import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/parametros/parametros_general.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/productos/getproductos.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/productos/insert_producto.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/proveedores/getproveedores.dart';
import 'package:intl/intl.dart';
import '../entities/Proveedores/Proveedores.dart';
import '../entities/registro/entityRegistor.dart';
import '../entities/registro/entityRegistroDetaller.dart';
import '../entities/tipo/grupo.dart';
import '../entities/unidad_medida/unidadMedida.dart';
import '../uses cases/grupo/get_grupos.dart';
import '../uses cases/movimientos/movimientosGeneral.dart';
import '../uses cases/productos/productosGeneral.dart';
import '../uses cases/registros/usesCaseRegistros.dart';
import '../uses cases/unidad_medida/get_medidas.dart';
import 'package:collection/collection.dart';

class ProductosProvider extends ChangeNotifier {
  Productos _productos = new Productos();
  TextEditingController _controllerDescripcion = new TextEditingController();
  TextEditingController _controllerCodigo = new TextEditingController();
  TextEditingController _controllerStock = new TextEditingController();
  TextEditingController _controllerPrecio = new TextEditingController();
  TextEditingController _controllerHolgura = new TextEditingController();
  int pedid = 0;
  List<Clasificacion> lisCla = [];
  List<Aprovisionar> aprovisionamientos = [];
  List<Aprovisionar> clasificaciones = [];
  List<Aprovisionar> mostrarItems = [];
  String codRef = "";

  TextEditingController get controllerHolgura => _controllerHolgura;

  set controllerHolgura(TextEditingController controllerHolgura) {
    _controllerHolgura = controllerHolgura;
    notifyListeners();
  }

  List<Productos> listado = [];
  List<UnidadMedidaEntity> listUnidades = [];
  List<GrupoEntity> listGrupos = [];
  List<ProveedoresEntity> listaProveedores = [];

  final InsertarProducto insertarProducto;
  final GetProductos getProductos;
  final GetMedidas unidadesMedidas;
  final GetGrupos grupos;
  final GetProveedores useCaseProveedores;
  final UsesCaseRegistros registro;
  final ParametrosGeneral parametros;
  final GeneralProducto productoGeneral;
  final MovimientosGeneral mov;
  final UsesCaseRegistros usesCases;

  ProductosProvider(
      this.insertarProducto,
      this.getProductos,
      this.unidadesMedidas,
      this.grupos,
      this.useCaseProveedores,
      this.registro,
      this.productoGeneral,
      this.mov,
      this.usesCases,
      this.parametros);

  //GlobalKey<FormState> get keyProducto => _keyProducto;

  TextEditingController get controllerPrecio => _controllerPrecio;

  set controllerPrecio(TextEditingController controllerPrecio) {
    _controllerPrecio = controllerPrecio;
    notifyListeners();
  }

  TextEditingController get controllerStock => _controllerStock;

  set controllerStock(TextEditingController controllerStock) {
    _controllerStock = controllerStock;
    notifyListeners();
  }

  TextEditingController get controllerCodigo => _controllerCodigo;

  set controllerCodigo(TextEditingController controllerCodigo) {
    _controllerCodigo = controllerCodigo;
    notifyListeners();
  }

  TextEditingController get controllerDescripcion => _controllerDescripcion;

  set controllerDescripcion(TextEditingController controllerDescripcion) {
    _controllerDescripcion = controllerDescripcion;
    notifyListeners();
  }

  Productos get product => _productos;

  set product(Productos p) {
    _productos = p;
    controllerDescripcion.text = p.detalle;
    controllerCodigo.text = p.referencia;
    controllerStock.text = p.cantidad.toString();
    controllerPrecio.text = p.precio.toString();
    p.lote = p.id == 0 ? Random().nextInt(10000000).toString() : p.lote;
    notifyListeners();
  }

  void notificar() {
    notifyListeners();
  }

  Future cargarDetalle() async {
    try {
      product.grupo = listGrupos.where((e) => e.id == product.idGrupo).first;

      product.proveedor =
          listaProveedores.where((e) => e.id == product.idProveedor).first;

      product.unidad =
          listUnidades.where((e) => e.id == product.idUnidad).first;
    } catch (ex) {
      print("Error en cargar detalle de grupo");
    }
    // notifyListeners();
  }

  Future<void> cargarPrd() async {
    var temporal = await getProductos.call();
    var result = temporal.fold((fail) => failure(fail), (prd) => prd);
    try {
      listado = result as List<Productos>;
    } catch (ex) {
      print("error${result.toString()}");
    }
    notifyListeners();
  }

  Future<List<EntityRegistro>> getRegistrosDev() async {
    try {
      var tem = await usesCases.getAll(2);

      var asd = tem.getOrElse(() => []);

      return asd;
    } catch (ex) {
      return [];
    }
  }

  Future<void> cargarUnidades() async {
    var temporal = await unidadesMedidas.call();
    var result = temporal.fold((fail) => failure(fail), (prd) => prd);
    try {
      listUnidades = result as List<UnidadMedidaEntity>;
      listUnidades = listUnidades.where((element) => element.estado).toList();
    } catch (ex) {
      print("error${result.toString()}");
    }
    notifyListeners();
  }

  Future<void> cargarGrupo() async {
    var temporal = await grupos.call();
    var result = temporal.fold((fail) => failure(fail), (prd) => prd);
    try {
      listGrupos = result as List<GrupoEntity>;
      listGrupos = listGrupos.where((e) => e.estado).toList();
    } catch (ex) {
      print("error${result.toString()}");
    }
    notifyListeners();
  }

  Future<void> cargarProveedores() async {
    var temporal = await useCaseProveedores.call();
    var result = temporal.fold((fail) => failure(fail), (prd) => prd);
    try {
      listaProveedores = result as List<ProveedoresEntity>;
      listaProveedores = listaProveedores.where((e) => e.estado).toList();
    } catch (ex) {
      print("error${result.toString()}");
    }
    notifyListeners();
  }

  String failure(Failure fail) {
    switch (fail.runtimeType) {
      case ServerFailure:
        return "Ocurrio un Error";

      default:
        return "Error";
    }
  }

  Future<void> calculos() async {
    try {
      var param = await parametros.getAllParametros();
      var listadoParam = param.getOrElse(() => []);
      // categorizacion  de todos los productos
      List<EntityRegistroDetalle> temporal = [];
      List<EntityRegistroDetalle> stockMensual = [];
      // obtengo las ventas de ese producto los ultimos 3 meses y lo sumo el total
      var tem = await registro.getAllDetalle(1);
      var cab = await registro.getAll(2);
      var lisDet = tem.getOrElse(() => []);
      var lisCab = cab.getOrElse(() => []);
      var fechaActual = DateTime.now();
      var fechaMesActual = DateTime(fechaActual.year, fechaActual.month, 1);
      var fechaAnterior = DateTime(fechaActual.year, fechaActual.month - 1, 1);
      //var fechaFinal = DateTime.now().add(Duration(days: -90));
      for (var item in lisCab) {
        //print("total items ${item.fecha.toString()}******** ${item.detalle}");

        var difee = DateTime.parse(item.fecha).difference(fechaMesActual);
        if (difee.inDays >= 0 && difee.inDays < 30) {
          // falta revisar mes actual
          var total =
              lisDet.where((element) => element.idRegistro == item.id).toList();

          if (total.length != 0) {
            for (var deta in total) {
              //print("registros ${deta.idProducto}");
              stockMensual.add(deta);
            }
          }
        }

        //var dife = DateTime.parse(item.createdAt).difference(fechaAnterior);
        var dife = DateTime.parse(item.fecha).difference(fechaAnterior);

        if (dife.inDays >= -90 && dife.inDays < 30) {
          var total =
              lisDet.where((element) => element.idRegistro == item.id).toList();
          if (total.length != 0) {
            for (var deta in total) {
              temporal.add(deta);
            }
          }
        }
      }

      lisCla = [];
      var grupos = temporal.groupListsBy((e) => e.idProducto);
      for (var idPrd in grupos.entries) {
        Clasificacion obj = Clasificacion();
        obj.idProducto = idPrd.key;
        for (var item in idPrd.value) {
          obj.unidades += item.cantidad;
          obj.promedio += item.cantidad * item.total;
        }
        lisCla.add(obj);
      }

      for (var forma in lisCla) {
        forma.promedio = forma.promedio / 3;
        forma.promedio = forma.promedio.roundToDouble();
      }
      // ordenar lista
      lisCla = lisCla.orderByDescending((et) => et.promedio).toList();

      // total Global por promedio
      var totalGlobal = lisCla.sum(
        (p) => p.promedio,
      );
      //print("*****${totalGlobal}");
      await cargarPrd();
      // ahora si a categorizar
      totalGlobal = formatting(totalGlobal);
      double inici = 0;

      for (var cat in lisCla) {
        try {
          var prd = listado.firstWhere((e) => e.id == cat.idProducto);
          cat.detalle = prd.nombre;
          print("prd${cat.idProducto}");
          try {
            var stockVenta = stockMensual
                .where((e) => e.idProducto == cat.idProducto)
                .sum((p) => p.cantidad);

            cat.stock = prd.cantidad;
            var stockMes = stockVenta + prd.cantidad;
            cat.stockInicioMes = stockMes;
          } catch (ex) {
            cat.stock = prd.cantidad;
          }

          //cat.stock = prd.cantidad;

          cat.pedido = prd.pedido;
          if (prd.pedido != 0) {
            cat.cobertura = (prd.cantidad / prd.pedido) * 30;
          } else {
            cat.cobertura = 0;
          }
        } catch (ex) {
          print("-----${ex.toString()}");
          cat.detalle = "####";
        }

        var valu = cat.promedio / totalGlobal;

        valu = formatting(valu);
        inici += valu * 100;
        if (inici <= 80) {
          cat.clasificacion = "A";
        } else if (inici > 80 && inici < 95) {
          cat.clasificacion = "B";
        } else if (inici >= 95) {
          cat.clasificacion = "C";
        }
      }

//
      var existeA = lisCla.where((e) => e.clasificacion == 'A').toList().length;
      if (existeA == 0) {
        if (lisCla.length > 0) {
          lisCla[0].clasificacion = "A";
        }
      }

// stock seguridad
      aprovisionamientos = [];
      for (var item in lisCla) {
        Aprovisionar ap = new Aprovisionar();
        ap.idProducto = item.idProducto;
        ap.detalle = item.detalle;
        ap.cobertura = item.cobertura.round();
        ap.promedio = formatting(item.unidades / 3);
        ap.clasificacion = item.clasificacion;
        ap.stock = item.stock;
        ap.stockMesActual = item.stockInicioMes;
        // calculos
        double ventaXdia = ap.promedio / 30;
        if (ap.clasificacion == "A") {
          var paramTemp = listadoParam.where((e) => e.detalle == "A").first;
          if (paramTemp != null) {
            ap.stockSeguridad = formatting(ventaXdia * paramTemp.holgura);
          } else {
            ap.stockSeguridad = formatting(ventaXdia * 7);
          }
        } else if (ap.clasificacion == "B") {
          var paramTemp = listadoParam.where((e) => e.detalle == "B").first;
          if (paramTemp != null) {
            ap.stockSeguridad = formatting(ventaXdia * paramTemp.holgura);
          } else {
            ap.stockSeguridad = formatting(ventaXdia * 7);
          }
        } else if (ap.clasificacion == "C") {
          var paramTemp = listadoParam.where((e) => e.detalle == "C").first;
          if (paramTemp != null) {
            ap.stockSeguridad = formatting(ventaXdia * paramTemp.holgura);
          } else {
            ap.stockSeguridad = formatting(ventaXdia * 7);
          }
        }
        ap.stockSeguridad = double.parse(ap.stockSeguridad.round().toString());
        print("Incio de mes ${item.stockInicioMes}");
        if (item.pedido == item.stockInicioMes) {
          ap.aprovisionar = ap.stockSeguridad;
        } else if (item.stockInicioMes > item.pedido) {
          if (item.stockInicioMes >= ap.stockSeguridad) {
            //**************************/

            ap.aprovisionar = ap.stockSeguridad - item.stockInicioMes;
            if (ap.aprovisionar < 0) {
              ap.aprovisionar = ap.aprovisionar * -1;
            }
            // ap.aprovisionar =  0;
          } else {
            double st = item.stockInicioMes - item.pedido;
            ap.aprovisionar = ap.stockSeguridad - st;
          }
        } else {
          var asd = item.pedido - item.stockInicioMes;
          ap.aprovisionar =
              (item.pedido - item.stockInicioMes) + ap.stockSeguridad;
        }
        aprovisionamientos.add(ap);
      }
      clasificaciones = [];
      var asss = aprovisionamientos.groupListsBy((e) => e.clasificacion);
      for (var item in asss.entries) {
        Aprovisionar a = new Aprovisionar();
        a.clasificacion = item.key;
        if (a.clasificacion == "A") {
          a.total = 1;
        } else if (a.clasificacion == "B") {
          a.total = 2;
        } else if (a.clasificacion == "C") {
          a.total = 3;
        }
        clasificaciones.add(a);
      }

      notifyListeners();
    } catch (ex) {
      print("Proeducto Provider Error $ex");
    }
  }

  Future listAprovisionar() async {
    try {
      mostrarItems = [];
      await cargarProveedores();
      var pedidos = aprovisionamientos.where((e) => e.cobertura != 0);
      for (var item in pedidos) {
        try {
          var prdTemporales =
              listado.where((e) => e.id == item.idProducto).first;

          var proveedoresTemp = listaProveedores
              .where((e) => e.id == prdTemporales.idProveedor)
              .first;

          if (item.cobertura <= proveedoresTemp.holgura) {
            mostrarItems.add(item);
          }
        } catch (e) {
          print("----${e.toString()}");
        }
      }

      notifyListeners();
    } catch (ex) {
      print("Error en list aprovicionar ${ex.toString()}");
    }
  }

  double formatting(double valor) {
    try {
      var valueSt = valor.toStringAsFixed(2);
      return double.parse(valueSt);
    } catch (ex) {
      return 0;
    }
  }

  Future<Productos?> guardar(Productos p) async {
    var opt = false;

    try {
      product.referencia = int.parse(codRef).toString();
      p.nombre = controllerDescripcion.text;
      p.detalle = controllerDescripcion.text;
      print("-------");
      p.cantidad = double.tryParse(controllerStock.text) ?? 0;
      product.precio = double.tryParse(controllerPrecio.text) ?? 0;
      product.estado = true;

      var tem = await insertarProducto.insert(p);
      product = tem.getOrElse(() => new Productos());
      // if (keyProducto.currentState!.validate()) {
      //   product.id = Estaticas.listProductos.length + 1;
      //   product.detalle = controllerDescripcion.text;
      //   product.referencia = controllerCodigo.text;
      //   product.cantidad = double.tryParse(controllerStock.text) ?? 0;
      //   product.precio = double.parse(controllerPrecio.text);
      //   product.estado = true;
      //   Estaticas.listProductos.forEach((element) {
      //     if (element.referencia == controllerCodigo.text) {
      //       element.detalle = controllerDescripcion.text;
      //       // element.stock =
      //       //     element.stock! + double.tryParse(controllerStock.text)!;
      //       element.precio = double.parse(controllerPrecio.text);
      //       opt = true;
      //     }
      //   });
      //   if (!opt) {
      //     Estaticas.listProductos.add(product);
      //   }
      /* product = new Productos(precio: 0); */

      ModelMovimiento md = new ModelMovimiento();
      md.idProducto = product.id;
      md.codigo = p.lote;
      md.precio = p.precio;
      md.total = md.actual = p.cantidad.toInt();
      await mov.insertMov(md);

      return product;
    } catch (e) {
      print("Erro al ingresar producto ${e.toString()}");
      return null;
    }
  }

  Future<bool> pedidosMes() async {
    try {
      for (var item in listado) {
        Productos p = new Productos();
        p.id = item.id;
        p.cantidad = item.cantidad;
        p.detalle = item.detalle;
        p.estado = item.estado;
        p.idGrupo = item.idGrupo;
        p.idProveedor = item.idProveedor;
        p.idUnidad = item.idUnidad;
        p.nombre = item.nombre;
        p.pedido = item.pedido;
        p.precio = item.precio;
        p.referencia = item.referencia;
        if (p.pedido != 0) {
          await productoGeneral.update(p);
        }
      }
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future anular(Productos p) async {
    try {
      p.estado = false;
      var tem = await productoGeneral.update(p);
      product = tem.getOrElse(() => new Productos());
    } catch (ex) {
      print("Erro al anular prd ${ex.toString()}");
    }
    notifyListeners();
  }

  Future<Productos?> actualizar(Productos p) async {
    try {
      p.referencia = controllerCodigo.text;
      p.nombre = controllerDescripcion.text;
      p.detalle = controllerDescripcion.text;

      p.cantidad = double.tryParse(controllerStock.text) ?? 0;
      p.precio = double.tryParse(controllerPrecio.text) ?? 0;
      p.estado = true;
      print("valor enviado  ${p.toString()}");
      var tem = await productoGeneral.update(p);
      product = tem.getOrElse(() => new Productos());
      return product;
    } catch (ex) {
      print("No se modifica ${ex.toString()}");
      return null;
    }
  }

  void generar([int exis = 0]) async {
    final formato = new NumberFormat("0000.##");
    try {
      if (listado.length == 0) {
        await cargarPrd();
      }
      int total = exis == 0 ? listado.length + 1 : exis;
      codRef = formato.format(total);
    } catch (ex) {
      print("Error en generar codRef ${ex.toString()}");
      codRef = "0000";
    }
    //notifyListeners();
  }
}

class Clasificacion {
  int idProducto = 0;
  double promedio = 0;
  int pedido = 0;
  int unidades = 0;
  double cobertura = 0;
  double stock = 0;
  double stockInicioMes = 0;
  String detalle = "";
  String clasificacion = "";
}

class Aprovisionar {
  int idProducto = 0;
  double promedio = 0;
  int pedido = 0;
  double stock = 0;
  double stockMesActual = 0;
  double stockSeguridad = 0;
  double aprovisionar = 0;
  int cobertura = 0;
  double total = 0;
  String detalle = "";
  String clasificacion = "";
}
