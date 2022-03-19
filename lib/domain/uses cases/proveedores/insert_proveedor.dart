import 'package:dartz/dartz.dart';
import 'package:genesis_vera_tesis/domain/repositories/proveedores/abtract_proveedores.dart';

import '../../../core/Errors/failure.dart';
import '../../entities/Proveedores/Proveedores.dart';

class InsertProveedor {
  final AbstractProveedores repository;

  InsertProveedor(this.repository);
  Future<Either<Failure, ProveedoresEntity>> insert(
      ProveedoresEntity prod) async {
    return await repository.insertProveedores(prod);
  }
}
