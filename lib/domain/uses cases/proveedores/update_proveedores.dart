import 'package:dartz/dartz.dart';

import '../../../core/Errors/failure.dart';
import '../../entities/Proveedores/Proveedores.dart';
import '../../repositories/proveedores/abtract_proveedores.dart';

class UpdateProveedor {
  final AbstractProveedores repository;

  UpdateProveedor(this.repository);
  Future<Either<Failure, ProveedoresEntity>> update(
      ProveedoresEntity prod) async {
    return await repository.updateProveedores(prod);
  }
}
