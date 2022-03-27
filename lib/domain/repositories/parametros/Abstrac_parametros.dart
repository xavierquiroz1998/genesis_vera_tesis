import 'package:dartz/dartz.dart';

import '../../../core/Errors/failure.dart';
import '../../entities/parametros/entityParameter.dart';

abstract class AbstractParametros {
  Future<Either<Failure, List<EntityParametros>>> getAllParametros();
  Future<Either<Failure, EntityParametros>> insertParametro(
      EntityParametros grupo);
  Future<Either<Failure, EntityParametros>> updateParametro(
      EntityParametros grupo);
  // Future<Either<Failure, GrupoEntity>> deleteGrupos(GrupoEntity grupo);
}
