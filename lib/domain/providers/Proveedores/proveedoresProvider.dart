import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/domain/entities/Proveedores/Proveedores.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';

class ProveedoresProvider extends ChangeNotifier {
  Proveedores _proveedores = new Proveedores();

  Proveedores get proveedor => _proveedores;

  set proveedor(Proveedores proveedores) {
    _proveedores = proveedores;
    notifyListeners();
  }

  void guardar(BuildContext context) {
    try {
      proveedor.idProveedor = Estaticas.listProveedores.length + 1;
      Estaticas.listProveedores.add(proveedor);
      print("Nuevo Proveedor registrado");
    } catch (e) {}
  }
}
