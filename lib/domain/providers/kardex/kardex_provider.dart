import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/domain/entities/kardex/kardex.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';

import '../../services/fail.dart';
import '../../uses cases/Kardex/kardex_general.dart';
import '../../uses cases/productos/getproductos.dart';

class KardexProvider extends ChangeNotifier {
  final KardexGeneral kardex;
  List<Productos> listado = [];
  Productos _prdSelect = new Productos();

  Productos get prdSelect => _prdSelect;

  set prdSelect(Productos prdSelect) {
    _prdSelect = prdSelect;
    notifyListeners();
  }

  List<Kardex> kardexRegistro = [];
  final GetProductos getProductos;
  KardexProvider(this.kardex, this.getProductos);

  Future<void> cargarPrd() async {
    listado = [];
    var temporal = await getProductos.call();
    var result = temporal.fold((fail) => Extras.failure(fail), (prd) => prd);
    try {
      listado = result as List<Productos>;
      listado = listado.where((e) => e.estado).toList();
    } catch (ex) {
      print("error${result.toString()}");
    }
    notifyListeners();
  }

  Future getKardex() async {
    try {
      var result = await kardex.getAll();
      kardexRegistro = result.getOrElse(() => []);
      notifyListeners();
    } catch (ex) {
      print("Error en obtener kardex General ${ex.toString()}");
    }
  }

  Future getKardexProducto(int idProducto) async {
    try {
      kardexRegistro = [];
      var result = await kardex.getAllProducto(idProducto);
      kardexRegistro = result.getOrElse(() => []);
      //print(result.map((r) => r));
      for (var item in kardexRegistro) {
        print("------------${item.proCanE}");
      }
      //notifyListeners();
    } catch (ex) {
      print("Error en obtener kardex General ${ex.toString()}");
    }
  }

  Future<Kardex> getKardexProductoUltimo(String idProducto) async {
    var opt;
    try {
      var result = await kardex.getKardexUltimo(idProducto);
      opt = result.getOrElse(() => new Kardex());
    } catch (ex) {
      print("Error en obtener kardex General ${ex.toString()}");
    }
    return opt;
  }

  Future<void> entradas(
      Productos producto, bool isExiste, bool isTipo, DateTime date) async {
    try {
      print("Entre al kardex");
      var kardexUltimo;

      if (isExiste) {
        await getKardex();
        print(" punto lenth del kardex ${kardexRegistro.length}");
        kardexUltimo = kardexRegistro
            .where((element) => element.idProducto == producto.id)
            .toList()
            .reversed
            .first;
      }
      //print(kardexUltimo.proCanE + producto.cantidad);
      Kardex k = new Kardex();
      k.codMov = isTipo
          ? 'I-${kardexRegistro.length}'
          : "DEV-${kardexRegistro.length}";
      k.idProducto = producto.id;
      k.codPro = producto.referencia;
      //nomPro: producto.detalle,
      k.proCanI = producto.cantidad;
      k.proUntI = producto.precio;
      k.proTtlI = (producto.cantidad * producto.precio);
      k.proCanS = 0;
      k.proUntS = 0;
      k.proTtlS = 0;

      k.proCanE = isExiste
          ? isTipo
              ? kardexUltimo.proCanE + producto.cantidad
              : kardexUltimo.proCanE - producto.cantidad
          : producto.cantidad;
      k.proUntE = isExiste
          ? isTipo
              ? (((producto.cantidad * producto.precio) +
                      kardexUltimo.proTtlE) /
                  (kardexUltimo.proCanE + producto.cantidad))
              : ((((producto.cantidad * producto.precio) -
                          kardexUltimo.proTtlE) /
                      (kardexUltimo.proCanE - producto.cantidad)) *
                  -1)
          : ((producto.cantidad * producto.precio) / producto.cantidad);
      k.proTtlE = isExiste
          ? isTipo
              ? ((producto.cantidad * producto.precio) + kardexUltimo.proTtlE)
              : (((producto.cantidad * producto.precio) -
                      kardexUltimo.proTtlE) *
                  -1)
          : (producto.cantidad * producto.precio);
      k.createdAt = date;
      //k.createdAt = DateTime.now();
      k.stsPro = true; //pendiente

      print(k.toString());
      await kardex.inserteKardex(k);

      print("Guardado OK");
    } catch (ex) {
      print("Error en grabar entrad de kardex ${ex.toString()}");
    }
  }

/*  ojo dev compras s
    : ((producto.stock! * producto.precio!) -
                          kardexUltimo.proTtlE) /
                      (kardexUltimo.proCanE - producto.stock!)
 */
  Future salidas(double cantidad, Productos producto, DateTime date) async {
    try {
      await getKardex();
      final kardexUltimo = kardexRegistro
          .where((element) => element.idProducto == producto.id)
          .toList()
          .reversed
          .first;
/* VARIABLE ADICIONAL POR QUE ABAJO NO HACE BIEN EL
CALCULO VOTA 199.99299928 SE QUE SE PUEDE REDONDEAR  */
      var total = kardexUltimo.proTtlE - (cantidad * kardexUltimo.proUntE);

      Kardex k = new Kardex(
          codMov: 'S-00${kardexRegistro.length}',
          codPro: producto.referencia, //1
          idProducto: producto.id,
          //nomPro: producto.detalle, //martillo
          proCanI: 0,
          proUntI: 0,
          proTtlI: 0,
          proCanS: cantidad,
          proUntS: kardexUltimo.proUntE,
          proTtlS: cantidad * kardexUltimo.proUntE, //
          proCanE: kardexUltimo.proCanE - cantidad,
          //proCanE: producto.cantidad - cantidad,
          // proCanE: producto.cantidad ,
          // proUntE: total / producto.cantidad,
          proUntE: kardexUltimo.proUntE,
          proTtlE: total,
          // createdAt: DateTime.now(),
          createdAt: date,
          stsPro: true);

      await kardex.inserteKardex(k);
      print("Guardado salida OK");
    } catch (ex) {
      print("Errr en salida ${ex.toString()}");
    }
  }

  void devoluciones(Productos producto, bool isTipo) async {
    try {
      var kardexUltimo = kardexRegistro
          .where((element) => element.idProducto == producto.id)
          .toList()
          .reversed
          .first;

      Kardex k = new Kardex(
          codMov: isTipo
              ? 'DEV-C${kardexRegistro.length}'
              : "DEV-V${kardexRegistro.length}",
          //codPro: producto.codigo!,
          //nomPro: producto.descripcion!,
          proCanI: isTipo ? producto.cantidad : 0,
          proUntI: isTipo ? producto.precio : 0,
          proTtlI: isTipo ? (producto.cantidad * producto.precio) : 0,
          proCanS: isTipo ? 0 : producto.cantidad,
          proUntS: isTipo ? 0 : kardexUltimo.proUntE,
          proTtlS: isTipo ? 0 : producto.cantidad * kardexUltimo.proUntE,
          proCanE: kardexUltimo.proCanE - producto.cantidad,
          proUntE:
              (((producto.cantidad * producto.precio) - kardexUltimo.proTtlE) /
                      (kardexUltimo.proCanE - producto.cantidad)) *
                  -1,
          proTtlE:
              ((producto.cantidad * producto.precio) - kardexUltimo.proTtlE) *
                  -1,
          createdAt: DateTime.now(),
          stsPro: true); //pendiente
      print(k.toString());
      await kardex.inserteKardex(k);
    } catch (ex) {
      print("Erro en devolucion ${ex.toString()}");
    }
  }

  Future devolucionesCliente(Productos producto) async {
    try {
      var kardexUltimo = await getKardexProductoUltimo("${producto.id}");

      Kardex k = new Kardex(
          codMov: 'DEV-C${kardexRegistro.length}',
          idProducto: producto.id,
          codPro: producto.nombre,
          proCanI: 0,
          proUntI: 0,
          proTtlI: 0,
          proCanS: (producto.cantidad * -1),
          proUntS: producto.precio,
          proTtlS: (producto.cantidad * kardexUltimo.proUntE) * -1,
          proCanE: producto.cantidad + kardexUltimo.proCanE,
          proUntE:
              (((producto.cantidad * producto.precio) - kardexUltimo.proTtlE) /
                      (kardexUltimo.proCanE - producto.cantidad)) *
                  -1,
          proTtlE:
              (((producto.cantidad * producto.precio)) + kardexUltimo.proTtlE),
          createdAt: DateTime.now(),
          stsPro: true); //pendiente

      await kardex.inserteKardex(k);
    } catch (ex) {
      print("Erro en devolucion ${ex.toString()}");
    }
  }

  Future devolucionesProveedor(Productos producto) async {
    try {
      var kardexUltimo = await getKardexProductoUltimo("${producto.id}");

      Kardex k = new Kardex(
          codMov: 'DEV-P${kardexRegistro.length}',
          idProducto: producto.id,
          codPro: producto.nombre,
          proCanI: (producto.cantidad * -1),
          proUntI: producto.precio,
          proTtlI: (producto.cantidad * producto.precio) * -1,
          proCanS: 0,
          proUntS: 0,
          proTtlS: 0,
          proCanE: (producto.cantidad - kardexUltimo.proCanE) * -1,
          proUntE:
              (((producto.cantidad * producto.precio) - kardexUltimo.proTtlE) /
                      (kardexUltimo.proCanE - producto.cantidad)) *
                  -1,
          proTtlE:
              ((producto.cantidad * producto.precio) - kardexUltimo.proTtlE) *
                  -1,
          createdAt: DateTime.now(),
          stsPro: true); //pendiente
      print(k.toString());
      await kardex.inserteKardex(k);
    } catch (ex) {
      print("Erro en devolucion ${ex.toString()}");
    }
  }

/* 
  void salidas(double cantidad, Productos producto, bool x) {
    final kardexUltimo = kardexRegistro.reversed
        .where((element) =>
            element.codPro == producto.codigo && element.codMov.contains("E"))
        .toList()
        .first;

    kardexRegistro.add(
      Kardex(
          codMov: x
              ? 'S-00${kardexRegistro.length}'
              : 'DVV-00${kardexRegistro.length}', // S-0000
          codPro: producto.codigo!, //1
          nomPro: producto.descripcion!, //martillo
          proCan: cantidad, // 100
          proUnt:
              kardexUltimo.proUnt, // ultimo registro de compras del producto
          proTtl: (cantidad * kardexUltimo.proUnt), //
          fecPro: DateTime.now(),
          stsPro: 'P'),
    );
  }

  void existencias(Productos producto, bool condicion, bool nuevo) {
    var kardexUltimo;

    if (nuevo) {
      kardexUltimo = kardexRegistro.reversed
          .singleWhere((element) => element.codPro == producto.codigo);
    } else {
      var x = kardexRegistro.reversed
          .where((element) =>
              element.codPro == producto.codigo && element.codMov.contains("E"))
          .toList();
      kardexUltimo = x.first;
    }

    kardexRegistro.add(
      Kardex(
          codMov: 'E-00${kardexRegistro.length}', // E-000
          codPro: producto.codigo!, //1
          nomPro: producto.descripcion!, //martillos
          proCan: condicion
              ? nuevo
                  ? producto.stock!
                  : producto.stock! + kardexUltimo.proCan
              : kardexUltimo.proCan - producto.stock!, //190
          proUnt: nuevo
              ? ((producto.stock! * producto.precio!) / producto.stock!)
              : condicion
                  ? (kardexUltimo.proTtl +
                          (producto.stock! * producto.precio!)) /
                      (producto.stock! + kardexUltimo.proCan)
                  : ((kardexUltimo.proTtl -
                          (producto.stock! * kardexUltimo.proUnt)) /
                      (kardexUltimo.proCan - producto.stock!)), //  28500 / 90
          proTtl: condicion
              ? nuevo
                  ? producto.stock! * producto.precio!
                  : (producto.stock! * producto.precio!) + kardexUltimo.proTtl
              : kardexUltimo.proTtl -
                  (producto.stock! * kardexUltimo.proUnt), //38000
          fecPro: DateTime.now(), // 9/01/2022
          stsPro: 'P'), //pendiente
    );
  }

  void existenciasDev(Productos producto, bool condicion) {
    var kardexUltimo = kardexRegistro.reversed
        .where((element) =>
            element.codPro == producto.codigo && element.codMov.contains("E"))
        .toList()
        .first;

    kardexRegistro.add(
      Kardex(
          codMov: 'E-00${kardexRegistro.length}', //130 /
          codPro: producto.codigo!,
          nomPro: producto.descripcion!,
          proCan: kardexUltimo.proCan - producto.stock!,
          proUnt:
              ((kardexUltimo.proTtl - (producto.stock! * producto.precio!)) /
                  (kardexUltimo.proCan - producto.stock!)),
          proTtl: kardexUltimo.proTtl - (producto.stock! * producto.precio!),
          fecPro: DateTime.now(), // 9/01/2022
          stsPro: 'P'), //pendiente
    );
  }

  void existenciasComp(Productos producto, bool condicion) {
    var kardexUltimo = kardexRegistro.reversed
        .where((element) =>
            element.codPro == producto.codigo && element.codMov.contains("E"))
        .toList()
        .first;

    kardexRegistro.add(
      Kardex(
          codMov: 'E-00${kardexRegistro.length}', //130 /
          codPro: producto.codigo!,
          nomPro: producto.descripcion!,
          proCan: kardexUltimo.proCan + producto.stock!,
          proUnt:
              ((kardexUltimo.proTtl - (producto.stock! * kardexUltimo.proUnt)) /
                  (kardexUltimo.proCan - producto.stock!)),
          proTtl: kardexUltimo.proTtl + (producto.stock! * kardexUltimo.proUnt),
          fecPro: DateTime.now(), // 9/01/2022
          stsPro: 'P'), //pendiente
    );
  }
 */
  void impresion() {
    print(kardexRegistro);
  }
}
