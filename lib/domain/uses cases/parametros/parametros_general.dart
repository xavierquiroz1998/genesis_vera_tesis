import 'package:dartz/dartz.dart';

import '../../../core/Errors/failure.dart';
import '../../entities/parametros/entityParameter.dart';
import '../../repositories/parametros/Abstrac_parametros.dart';

class ParametrosGeneral {
  final AbstractParametros repository;

  ParametrosGeneral(this.repository);

  Future<Either<Failure, List<EntityParametros>>> getAllParametros() async {
    return await repository.getAllParametros();
  }

  Future<Either<Failure, EntityParametros>> insertParametro(
      EntityParametros grupo) async {
    return await repository.insertParametro(grupo);
  }

  Future<Either<Failure, EntityParametros>> updateParametro(
      EntityParametros grupo) async {
    return await repository.updateParametro(grupo);
  }
}
