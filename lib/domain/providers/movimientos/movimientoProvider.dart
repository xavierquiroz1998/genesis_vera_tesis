import 'package:flutter/cupertino.dart';

import '../../../data/models/movimiento/modelMovimiento.dart';
import '../../uses cases/movimientos/movimientosGeneral.dart';

class MovimientoProvider extends ChangeNotifier {
  final MovimientosGeneral mov;

  MovimientoProvider(this.mov);

  Future inserMov() async {
    try {
      ModelMovimiento mod = new ModelMovimiento();

      var temp = await mov.insertMov(mod);

      var resul = temp.getOrElse(() => new ModelMovimiento());
    } catch (ex) {
      print("Error en guardar movimiento");
    }
  }
}
