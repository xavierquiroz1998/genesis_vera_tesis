import 'package:dartz/dartz.dart';

import '../../../core/Errors/failure.dart';
import '../../entities/unidad_medida/unidadMedida.dart';
import '../../repositories/unidad_medida/abstractMedida.dart';

class UpdateMedidas {
  final AbstractMedidaUnidad repository;

  UpdateMedidas(this.repository);

  Future<Either<Failure, UnidadMedidaEntity>> update(
      UnidadMedidaEntity unid) async {
    return await repository.updateUnidades(unid);
  }
}
