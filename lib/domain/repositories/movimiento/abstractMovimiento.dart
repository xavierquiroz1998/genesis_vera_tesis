import 'package:dartz/dartz.dart';

import '../../../core/Errors/failure.dart';
import '../../../data/models/movimiento/modelMovimiento.dart';

abstract class AbstractMovimiento {
  Future<Either<Failure, List<ModelMovimiento>>> getAllMov();
  Future<Either<Failure, List<ModelMovimiento>>> getAllMovProducto(
      int idProducto);
  Future<Either<Failure, ModelMovimiento>> insertMov(ModelMovimiento grupo);
  Future<Either<Failure, ModelMovimiento>> updateMov(ModelMovimiento grupo);
}
