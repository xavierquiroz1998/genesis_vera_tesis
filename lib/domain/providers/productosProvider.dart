import 'package:darq/darq.dart';
import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';

import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/movimientos/movimientosGeneral.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/parametros/parametros_general.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/productos/getproductos.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/productos/insert_producto.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/proveedores/getproveedores.dart';

import '../../data/models/movimiento/modelMovimiento.dart';
import '../entities/Proveedores/Proveedores.dart';
import '../entities/registro/entityRegistroDetaller.dart';
import '../entities/tipo/grupo.dart';
import '../entities/unidad_medida/unidadMedida.dart';
import '../uses cases/grupo/get_grupos.dart';
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
  List<Aprovisionar> mostrarItems = [];

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

  ProductosProvider(
      this.insertarProducto,
      this.getProductos,
      this.unidadesMedidas,
      this.grupos,
      this.useCaseProveedores,
      this.registro,
      this.productoGeneral,
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
    notifyListeners();
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

  Future<void> cargarUnidades() async {
    var temporal = await unidadesMedidas.call();
    var result = temporal.fold((fail) => failure(fail), (prd) => prd);
    try {
      listUnidades = result as List<UnidadMedidaEntity>;
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
      // obtengo las ventas de ese producto los ultimos 3 meses y lo sumo el total
      var tem = await registro.getAllDetalle(1);
      var cab = await registro.getAll(2);
      var lisDet = tem.getOrElse(() => []);
      var lisCab = cab.getOrElse(() => []);
      var fechaActual = DateTime.now();
      var fechaAnterior = DateTime(fechaActual.year, fechaActual.month, 1 - 1);
      //var fechaFinal = DateTime.now().add(Duration(days: -90));
      for (var item in lisCab) {
        var dife = DateTime.parse(item.createdAt).difference(fechaAnterior);
        if (dife.inDays <= 30) {
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
          obj.promedio += item.cantidad * item.total;
        }
        lisCla.add(obj);
      }

      for (var forma in lisCla) {
        forma.promedio = forma.promedio / 3;
        forma.promedio = forma.promedio.roundToDouble();
      }
      lisCla = lisCla.orderByDescending((et) => et.promedio).toList();
      var totalGlobal = lisCla.sum(
        (p) => p.promedio,
      );

      await cargarPrd();
// ahora si a categorizar
      totalGlobal = formatting(totalGlobal);
      double inici = 0;
      for (var cat in lisCla) {
        try {
          var prd =
              listado.firstWhere((element) => element.id == cat.idProducto);
          cat.detalle = prd.nombre;
          cat.stock = prd.cantidad;
          cat.pedido = prd.pedido;
          if (prd.pedido != 0) {
            cat.cobertura = (prd.cantidad / prd.pedido) * 30;
          } else {
            cat.cobertura = 0;
          }
        } catch (ex) {
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
// stock seguridad
      aprovisionamientos = [];
      for (var item in lisCla) {
        Aprovisionar ap = new Aprovisionar();
        ap.idProducto = item.idProducto;
        ap.detalle = item.detalle;
        ap.cobertura = item.cobertura.round();
        ap.promedio = formatting(item.promedio / 3);
        ap.clasificacion = item.clasificacion;
        ap.stock = item.stock;

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
        if (item.pedido == item.stock) {
          ap.aprovisionar = ap.stockSeguridad;
        } else if (item.stock > item.pedido) {
          if (item.stock >= ap.stockSeguridad) {
            ap.aprovisionar = 0;
          } else {
            double st = item.stock - item.pedido;
            ap.aprovisionar = ap.stockSeguridad - st;
          }
        } else {
          ap.aprovisionar = (item.pedido - item.stock) + ap.stockSeguridad;
        }

        aprovisionamientos.add(ap);
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
        } catch (e) {}
      }
      for (var item in mostrarItems) {}
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
      product.referencia = controllerCodigo.text;
      p.nombre = controllerDescripcion.text;
      p.detalle = controllerDescripcion.text;

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

      return product;
    } catch (e) {
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
      product.estado = false;
      var tem = await productoGeneral.update(p);
      product = tem.getOrElse(() => new Productos());
    } catch (ex) {}
    notifyListeners();
  }

  Future actualizar(Productos p) async {
    try {
      product.referencia = controllerCodigo.text;
      p.nombre = controllerDescripcion.text;
      p.detalle = controllerDescripcion.text;

      p.cantidad = double.tryParse(controllerStock.text) ?? 0;
      product.precio = double.tryParse(controllerPrecio.text) ?? 0;
      product.estado = true;
      var tem = await productoGeneral.update(p);
      product = tem.getOrElse(() => new Productos());
    } catch (ex) {}
    notifyListeners();
  }
}

class Clasificacion {
  int idProducto = 0;
  double promedio = 0;
  int pedido = 0;
  double cobertura = 0;
  double stock = 0;
  String detalle = "";
  String clasificacion = "";
}

class Aprovisionar {
  int idProducto = 0;
  double promedio = 0;
  int pedido = 0;
  double stock = 0;
  double stockSeguridad = 0;
  double aprovisionar = 0;
  int cobertura = 0;
  String detalle = "";
  String clasificacion = "";
}
