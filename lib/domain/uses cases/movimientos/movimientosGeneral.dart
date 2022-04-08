import 'package:dartz/dartz.dart';

import '../../../core/Errors/failure.dart';
import '../../../data/models/movimiento/modelMovimiento.dart';
import '../../repositories/movimiento/abstractMovimiento.dart';

class MovimientosGeneral {
  final AbstractMovimiento repository;

  MovimientosGeneral(this.repository);

  Future<Either<Failure, List<ModelMovimiento>>> getMovientos() async {
    return repository.getAllMov();
  }

  Future<Either<Failure, List<ModelMovimiento>>> getMovientosPrd(
      int idProducto) async {
    return repository.getAllMovProducto(idProducto);
  }

  Future<Either<Failure, ModelMovimiento>> insertMov(
      ModelMovimiento mod) async {
    return repository.insertMov(mod);
  }

  Future<Either<Failure, ModelMovimiento>> updateMov(
      ModelMovimiento mod) async {
    return repository.updateMov(mod);
  }
}
