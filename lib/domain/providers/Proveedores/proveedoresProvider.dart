import 'package:flutter/cupertino.dart';
import 'package:genesis_vera_tesis/domain/entities/Proveedores/Proveedores.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';

class ProveedoresProvider extends ChangeNotifier {
  Proveedores _proveedores = new Proveedores();
  final _keyProveedor = GlobalKey<FormState>();

  Proveedores get proveedor => _proveedores;

  set proveedor(Proveedores proveedores) {
    _proveedores = proveedores;
    notifyListeners();
  }

  GlobalKey<FormState> get keyProvider => _keyProveedor;

  void guardar(BuildContext context) {
    try {
      if (keyProvider.currentState!.validate()) {
        proveedor.idProveedor = Estaticas.listProveedores.length + 1;
        Estaticas.listProveedores.add(proveedor);
        print("Nuevo Proveedor registrado");
        Navigator.pop(context);
      }
    } catch (e) {}
  }
}
