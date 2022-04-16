import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/domain/providers/productosProvider.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/grupo/get_grupos.dart';

import '../../entities/productos.dart';
import '../../entities/tipo/grupo.dart';
import '../../services/fail.dart';
import '../../uses cases/productos/getproductos.dart';

class DashboardProvider extends ChangeNotifier {
  List<Productos> _listProductos = [];
  List<GrupoEntity> listGrupos = [];

  final GetProductos getProductos;
  final GetGrupos grupos;

  DashboardProvider(this.getProductos, this.grupos);

  List<Productos> get listProductos => _listProductos;

  set listProductos(List<Productos> listProductos) {
    _listProductos = listProductos;
    notifyListeners();
  }

  Future<void> cargarGrupo() async {
    var temporal = await grupos.call();
    var result = temporal.fold((fail) => Extras.failure(fail), (prd) => prd);
    try {
      listGrupos = result as List<GrupoEntity>;
      listGrupos = listGrupos.where((e) => e.estado).toList();
    } catch (ex) {
      print("error${result.toString()}");
    }
    notifyListeners();
  }

  Future<void> cargarPrd() async {
    var temporal = await getProductos.call();
    var result = temporal.fold((fail) => Extras.failure(fail), (prd) => prd);
    try {
      listProductos = result as List<Productos>;
    } catch (ex) {
      print("error${result.toString()}");
    }
    notifyListeners();
  }

  Future cargarLista(int idTipo, List<Aprovisionar> ap) async {
    try {
      await cargarPrd();
      listProductos = listProductos.where((x) => x.idGrupo == idTipo).toList();

      for (var item in listProductos) {
        item.dias = ap.where((e) => e.idProducto == item.id).first.cobertura;
      }
    } catch (ex) {
      print("Erro en cargarLista ${ex.toString()}");
    }
    notifyListeners();
  }
}
