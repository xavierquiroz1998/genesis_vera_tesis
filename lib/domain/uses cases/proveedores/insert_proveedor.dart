import 'package:genesis_vera_tesis/domain/repositories/proveedores/abtract_proveedores.dart';

import '../../entities/Proveedores/Proveedores.dart';

class InsertProveedor {
  final AbstractProveedores repository;

  InsertProveedor(this.repository);
  Future<String> insert(ProveedoresEntity prod) async {
    return await repository.insertProveedores(prod);
  }
}
