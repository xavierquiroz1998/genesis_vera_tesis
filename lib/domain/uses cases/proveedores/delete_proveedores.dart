import 'package:dartz/dartz.dart';

import '../../../core/Errors/failure.dart';
import '../../entities/Proveedores/Proveedores.dart';
import '../../repositories/proveedores/abtract_proveedores.dart';

class DeleteProveedor {
  final AbstractProveedores repository;

  DeleteProveedor(this.repository);
  Future<Either<Failure, ProveedoresEntity>> delete(
      ProveedoresEntity prod) async {
    return await repository.deleteProveedores(prod);
  }
}
