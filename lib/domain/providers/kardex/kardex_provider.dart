import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/domain/entities/kardex/kardex.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';

class KardexProvider extends ChangeNotifier {
  List<Kardex> kardexRegistro = [];

  void entradas(Productos producto, bool isExiste, bool isTipo) {
    var kardexUltimo;

    if (isExiste) {
      kardexUltimo = kardexRegistro
          .where((element) => element.codPro == producto.codigo)
          .toList()
          .reversed
          .first;
    }

    kardexRegistro.add(
      Kardex(
          codMov: isTipo
              ? 'I-${kardexRegistro.length}'
              : "DEV-${kardexRegistro.length}",
          codPro: producto.codigo!,
          nomPro: producto.descripcion!,
          proCanI: producto.stock!,
          proUntI: producto.precio!,
          proTtlI: (producto.stock! * producto.precio!),
          proCanS: 0,
          proUntS: 0,
          proTtlS: 0,
          proCanE: isExiste
              ? isTipo
                  ? kardexUltimo.proCanE + producto.stock!
                  : kardexUltimo.proCanE - producto.stock!
              : producto.stock!,
          proUntE: isExiste
              ? isTipo
                  ? ((producto.stock! * producto.precio!) +
                          kardexUltimo.proTtlE) /
                      (kardexUltimo.proCanE + producto.stock!)
                  : (((producto.stock! * producto.precio!) -
                              kardexUltimo.proTtlE) /
                          (kardexUltimo.proCanE - producto.stock!)) *
                      -1
              : (producto.stock! * producto.precio!) / producto.stock!,
          proTtlE: isExiste
              ? isTipo
                  ? (producto.stock! * producto.precio!) + kardexUltimo.proTtlE
                  : ((producto.stock! * producto.precio!) -
                          kardexUltimo.proTtlE) *
                      -1
              : (producto.stock! * producto.precio!),
          fecPro: DateTime.now(),
          stsPro: 'I'), //pendiente
    );
  }

/*  ojo dev compras s
    : ((producto.stock! * producto.precio!) -
                          kardexUltimo.proTtlE) /
                      (kardexUltimo.proCanE - producto.stock!)
 */
  void salidas(double cantidad, Productos producto) {
    final kardexUltimo = kardexRegistro
        .where((element) => element.codPro == producto.codigo)
        .toList()
        .reversed
        .first;
/* VARIABLE ADICIONAL POR QUE ABAJO NO HACE BIEN EL 
CALCULO VOTA 199.99299928 SE QUE SE PUEDE REDONDEAR  */
    var total = kardexUltimo.proTtlE - (cantidad * kardexUltimo.proUntE);

    kardexRegistro.add(
      Kardex(
          codMov: 'S-00${kardexRegistro.length}',
          codPro: producto.codigo!, //1
          nomPro: producto.descripcion!, //martillo
          proCanI: 0,
          proUntI: 0,
          proTtlI: 0,
          proCanS: cantidad,
          proUntS: kardexUltimo.proUntE,
          proTtlS: (cantidad * kardexUltimo.proUntE), //
          proCanE: producto.stock!,
          proUntE: total / producto.stock!,
          proTtlE: total,
          fecPro: DateTime.now(),
          stsPro: 'P'),
    );
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
