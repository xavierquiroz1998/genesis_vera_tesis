import 'package:genesis_vera_tesis/domain/repositories/proveedores/abtract_proveedores.dart';

class InsertProveedor {
  final AbstractProveedores repository;

  InsertProveedor(this.repository);
  Future<String> insert() async {
    return await repository.insertProveedores();
  }
}
