import 'package:darq/darq.dart';
import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';

import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/productos/getproductos.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/productos/insert_producto.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/proveedores/getproveedores.dart';

import '../entities/Proveedores/Proveedores.dart';
import '../entities/registro/entityRegistroDetaller.dart';
import '../entities/tipo/grupo.dart';
import '../entities/unidad_medida/unidadMedida.dart';
import '../uses cases/grupo/get_grupos.dart';
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
  ProductosProvider(
      this.insertarProducto,
      this.getProductos,
      this.unidadesMedidas,
      this.grupos,
      this.useCaseProveedores,
      this.registro);

  final _keyProducto = GlobalKey<FormState>();

  GlobalKey<FormState> get keyProducto => _keyProducto;

  TextEditingController get controllerPrecio => _controllerPrecio;

  set controllerPrecio(TextEditingController controllerPrecio) {
    _controllerPrecio = controllerPrecio;
  }

  TextEditingController get controllerStock => _controllerStock;

  set controllerStock(TextEditingController controllerStock) {
    _controllerStock = controllerStock;
  }

  TextEditingController get controllerCodigo => _controllerCodigo;

  set controllerCodigo(TextEditingController controllerCodigo) {
    _controllerCodigo = controllerCodigo;
  }

  TextEditingController get controllerDescripcion => _controllerDescripcion;

  set controllerDescripcion(TextEditingController controllerDescripcion) {
    _controllerDescripcion = controllerDescripcion;
  }

  Productos get product => _productos;

  set product(Productos p) {
    _productos = p;
    controllerDescripcion.text = p.detalle;
    controllerCodigo.text = p.referencia;
    controllerStock.text = p.cantidad.toString();
    controllerPrecio.text = p.precio == null ? "" : p.precio.toString();
    notifyListeners();
  }

  void notificar() {
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
//       double converturaDias = (p.cantidad * pedid) / 30; // 7,5
// // cosulto el proveedor por producto y veo el tiempo de holgura que sea mayor
// // como envaluar los los dias trasncurridos
//       double mesaActual = p.cantidad + pedid;

      // categorizacion  de todos los productos
      List<EntityRegistroDetalle> temporal = [];
      double stockSeguridad = 0;
      // obtengo las ventas de ese producto los ultimos 3 meses y lo sumo el total
      var tem = await registro.getAllDetalle(1);
      var cab = await registro.getAll(2);
      var lisDet = tem.getOrElse(() => []);
      var lisCab = cab.getOrElse(() => []);
      var fechaActual = DateTime.now();
      var fechaFinal = DateTime.now().add(Duration(days: -90));
      for (var item in lisCab) {
        var dife = DateTime.parse(item.createdAt).difference(fechaActual);
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

      for (var item in lisCla) {
        Aprovisionar ap = new Aprovisionar();
        ap.idProducto = item.idProducto;
        ap.detalle = item.detalle;
        ap.promedio = formatting(item.promedio / 3);
        ap.clasificacion = item.clasificacion;

// calculos
        double ventaXdia = ap.promedio / 30;
        if (ap.clasificacion == "A") {
          ap.stockSeguridad = formatting(ventaXdia * 7);
        } else if (ap.clasificacion == "B") {
          ap.stockSeguridad = formatting(ventaXdia * 30);
        } else if (ap.clasificacion == "C") {
          ap.stockSeguridad = formatting(ventaXdia * 45);
        }

        aprovisionamientos.add(ap);
      }

      notifyListeners();
    } catch (ex) {}
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
}

class Clasificacion {
  int idProducto = 0;
  double promedio = 0;
  String detalle = "";
  String clasificacion = "";
}

class Aprovisionar {
  int idProducto = 0;
  double promedio = 0;
  double stockSeguridad = 0;
  String detalle = "";
  String clasificacion = "";
}
