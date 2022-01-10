import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/domain/entities/kardex/kardex.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';

class KardexProvider extends ChangeNotifier {
  List<Kardex> kardexRegistro = [];

/*Alimentar el inventario - compras  */
/* CANTIDAD: 190  COST.UNIT: 200 TOTAL: 38000 */
  void entradas(Productos producto) {
    kardexRegistro.add(
      Kardex(
          codMov: 'I-00${kardexRegistro.length}', // I-000
          codPro: producto.codigo!, //1
          nomPro: producto.descripcion!, //martilos de casa
          proCan: producto.stock!, //190
          proUnt: producto.precio!, //200.00
          proTtl: (producto.stock! * producto.precio!), //38000
          fecPro: DateTime.now(), // 9/01/2022
          stsPro: 'P'), //pendiente
    );
  }

  void salidas(double cantidad, Productos producto) {
    final kardexUltimo = kardexRegistro.reversed.singleWhere((element) =>
        element.codPro == producto.codigo && element.codMov.contains("E"));

    kardexRegistro.add(
      Kardex(
          codMov: 'S-00${kardexRegistro.length}', // S-0000
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
                  : ((producto.stock! * producto.precio!) /
                      producto.stock!), //  28500 / 90
          proTtl: condicion
              ? nuevo
                  ? producto.stock! * producto.precio!
                  : (producto.stock! * producto.precio!) + kardexUltimo.proTtl
              : kardexUltimo.proTtl -
                  (producto.stock! * producto.precio!), //38000
          fecPro: DateTime.now(), // 9/01/2022
          stsPro: 'P'), //pendiente
    );
  }

  void impresion() {
    print(kardexRegistro);
  }
}
