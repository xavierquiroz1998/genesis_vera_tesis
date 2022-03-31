import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/domain/entities/kardex/kardex.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';

import '../../uses cases/Kardex/kardex_general.dart';

class KardexProvider extends ChangeNotifier {
  final KardexGeneral kardex;

  List<Kardex> kardexRegistro = [];

  KardexProvider(this.kardex);

  Future getKardex() async {
    try {
      var result = await kardex.getAll();
      kardexRegistro = result.getOrElse(() => []);
      notifyListeners();
    } catch (ex) {}
  }

  Future<void> entradas(Productos producto, bool isExiste, bool isTipo) async {
    var kardexUltimo;
    await getKardex();
    if (isExiste) {
      kardexUltimo = kardexRegistro
          .where((element) => element.codPro == producto.referencia)
          .toList()
          .reversed
          .first;
    }

    Kardex k = new Kardex(
        codMov: isTipo
            ? 'I-${kardexRegistro.length}'
            : "DEV-${kardexRegistro.length}",
        idProducto: producto.id,
        codPro: producto.referencia,
        //nomPro: producto.detalle,
        //proCanI: producto.stock,
        proUntI: producto.precio.toString(),
        //proTtlI: (producto.stock * producto.precio),
        proCanS: 0,
        proUntS: "0",
        proTtlS: "0",
        proCanE: isExiste
            ? isTipo
                ? kardexUltimo.proCanE + producto.cantidad
                : kardexUltimo.proCanE - producto.cantidad
            : producto.cantidad,
        proUntE: isExiste
            ? isTipo
                ? (((producto.cantidad * producto.precio) +
                            kardexUltimo.proTtlE) /
                        (kardexUltimo.proCanE + producto.cantidad))
                    .toString()
                : ((((producto.cantidad * producto.precio) -
                                kardexUltimo.proTtlE) /
                            (kardexUltimo.proCanE - producto.cantidad)) *
                        -1)
                    .toString()
            : ((producto.cantidad * producto.precio) / producto.cantidad)
                .toString(),
        proTtlE: isExiste
            ? isTipo
                ? ((producto.cantidad * producto.precio) + kardexUltimo.proTtlE)
                    .toString()
                : (((producto.cantidad * producto.precio) -
                            kardexUltimo.proTtlE) *
                        -1)
                    .toString()
            : (producto.cantidad * producto.precio).toString(),
        fecPro: DateTime.now(),
        stsPro: true); //pendiente

    await kardex.inserteKardex(k);
  }

/*  ojo dev compras s
    : ((producto.stock! * producto.precio!) -
                          kardexUltimo.proTtlE) /
                      (kardexUltimo.proCanE - producto.stock!)
 */
  Future salidas(double cantidad, Productos producto) async {
    try {
      await getKardex();
      final kardexUltimo = kardexRegistro
          .where((element) => element.idProducto == producto.id)
          .toList()
          .reversed
          .first;
/* VARIABLE ADICIONAL POR QUE ABAJO NO HACE BIEN EL
CALCULO VOTA 199.99299928 SE QUE SE PUEDE REDONDEAR  */
      var total = double.parse(kardexUltimo.proTtlE) -
          (cantidad * double.parse(kardexUltimo.proUntE));

      Kardex k = new Kardex(
          codMov: 'S-00${kardexRegistro.length}',
          codPro: producto.referencia, //1
          //nomPro: producto.detalle, //martillo
          proCanI: 0,
          proUntI: "0",
          proTtlI: "0",
          proCanS: cantidad.toInt(),
          proUntS: kardexUltimo.proUntE,
          proTtlS:
              (cantidad * double.parse(kardexUltimo.proUntE)).toString(), //
          proCanE: producto.cantidad.toInt(),
          proUntE: (total / producto.cantidad).toString(),
          proTtlE: total.toString(),
          fecPro: DateTime.now(),
          stsPro: true);

      await kardex.inserteKardex(k);
    } catch (ex) {
      print("Errr en salida ${ex.toString()}");
    }
  }

  void devoluciones(Productos producto, bool isTipo) {
    // var kardexUltimo = kardexRegistro
    //     .where((element) => element.codPro == producto.codigo)
    //     .toList()
    //     .reversed
    //     .first;

    // kardexRegistro.add(
    //   Kardex(
    //       codMov: isTipo
    //           ? 'DEV-C${kardexRegistro.length}'
    //           : "DEV-V${kardexRegistro.length}",
    //       codPro: producto.codigo!,
    //       nomPro: producto.descripcion!,
    //       proCanI: isTipo ? producto.stock! : 0,
    //       proUntI: isTipo ? producto.precio! : 0,
    //       proTtlI: isTipo ? (producto.stock! * producto.precio!) : 0,
    //       proCanS: isTipo ? 0 : producto.stock!,
    //       proUntS: isTipo ? 0 : kardexUltimo.proUntE,
    //       proTtlS: isTipo ? 0 : producto.stock! * kardexUltimo.proUntE,
    //       proCanE: kardexUltimo.proCanE - producto.stock!,
    //       proUntE:
    //           (((producto.stock! * producto.precio!) - kardexUltimo.proTtlE) /
    //                   (kardexUltimo.proCanE - producto.stock!)) *
    //               -1,
    //       proTtlE:
    //           ((producto.stock! * producto.precio!) - kardexUltimo.proTtlE) *
    //               -1,
    //       fecPro: DateTime.now(),
    //       stsPro: 'I'), //pendiente
    // );
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
