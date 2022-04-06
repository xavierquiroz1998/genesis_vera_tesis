import 'package:intl/intl.dart';

class Helper {
  static String generarTitulo(int exis) {
    final formato = new NumberFormat("0000.##");
    try {
      return formato.format(exis);
    } catch (ex) {
      print("Error en generar codRef ${ex.toString()}");
      return "0000";
    }
  }
}
