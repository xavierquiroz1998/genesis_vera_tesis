import 'package:dartz/dartz.dart';

import '../../../core/Errors/failure.dart';
import '../../../data/models/registros/modelRegistroDetalle.dart';
import '../../entities/registro/entityRegistor.dart';
import '../../entities/registro/entityRegistroDetaller.dart';

abstract class AbstractRegistros {
  Future<Either<Failure, List<EntityRegistro>>> getAll();
  Future<Either<Failure, EntityRegistro>> insertRegistros(
      EntityRegistro registro);
  Future<Either<Failure, EntityRegistro>> updateRegistros(
      EntityRegistro registro);
  Future<Either<Failure, EntityRegistro>> deleteRegistros(
      EntityRegistro registro);

////////////////////////
  ///
  ///
  Future<Either<Failure, List<EntityRegistroDetalle>>> getAll_x_id(int id);
  Future<Either<Failure, EntityRegistroDetalle>> insertRegistrosDetalles(
      EntityRegistroDetalle registro);
  Future<Either<Failure, EntityRegistroDetalle>> updateRegistrosDetalles(
      EntityRegistroDetalle registro);
  Future<Either<Failure, EntityRegistroDetalle>> deleteRegistrosDetalles(
      EntityRegistroDetalle registro);
}
