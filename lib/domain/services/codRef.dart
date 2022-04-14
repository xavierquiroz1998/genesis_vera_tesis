import 'package:intl/intl.dart';

class Helper {
  static String soloNumeros = r'^(?:\+|-)?\d+$';
  static String decimales = r'^\d+\.?\d{0,2}';
  static String sololetras = r'(^[a-zA-Z ]*$)';
  static String alfanumerico = r'(^[a-zA-Z 0-9.-]*$)';
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
