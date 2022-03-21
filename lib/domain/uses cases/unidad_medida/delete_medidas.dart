import 'package:dartz/dartz.dart';

import '../../../core/Errors/failure.dart';
import '../../entities/unidad_medida/unidadMedida.dart';
import '../../repositories/unidad_medida/abstractMedida.dart';

class DeleteMedidas {
  final AbstractMedidaUnidad repository;

  DeleteMedidas(this.repository);

  Future<Either<Failure, UnidadMedidaEntity>> delete(
      UnidadMedidaEntity unid) async {
    return await repository.deleteUnidades(unid);
  }
}
