import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/tipo/tipo_producto.dart';

class ProductoProvider extends ChangeNotifier {
  String isShowUpdate = "1";

  void saveTyped(String codigo, String nombre, String descp) {
    final tipoModel = TipoProducto(
        codPro: "${Estaticas.listTipoProduct.length}",
        codRef: codigo,
        nomPro: nombre,
        desPro: descp,
        stsPro: 'A');
    Estaticas.listTipoProduct.add(tipoModel);
    notifyListeners();
  }

  void updateTyped(
      String codigo, String refrencia, String nombre, String descp) {
    Estaticas.listTipoProduct = Estaticas.listTipoProduct.map((e) {
      if (e.codPro != codigo) return e;
      e.nomPro = nombre;
      e.desPro = descp;
      e.codRef = refrencia;

      return e;
    }).toList();
    notifyListeners();
  }

  void deleteTipo(TipoProducto e) {
    try {
      Estaticas.listTipoProduct.remove(e);
      notifyListeners();
    } catch (e) {
      print("Error usuario ${e.toString()}");
    }
  }
}
