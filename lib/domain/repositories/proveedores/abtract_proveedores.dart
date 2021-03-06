import 'package:dartz/dartz.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:genesis_vera_tesis/domain/entities/Proveedores/Proveedores.dart';

abstract class AbstractProveedores {
  Future<Either<Failure, List<ProveedoresEntity>>> getAllProveedores();
  Future<Either<Failure, ProveedoresEntity>> insertProveedores(
      ProveedoresEntity prod);
  Future<Either<Failure, ProveedoresEntity>> updateProveedores(
      ProveedoresEntity prod);
  Future<Either<Failure, ProveedoresEntity>> deleteProveedores(
      ProveedoresEntity prod);
}
