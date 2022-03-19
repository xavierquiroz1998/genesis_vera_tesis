import 'package:dartz/dartz.dart';

import '../../../core/Errors/failure.dart';
import '../../entities/unidad_medida/unidadMedida.dart';
import '../../repositories/unidad_medida/abstractMedida.dart';

class InsertMedidas {
  final AbstractMedidaUnidad repository;

  InsertMedidas(this.repository);

  Future<Either<Failure, UnidadMedidaEntity>> insert(
      UnidadMedidaEntity unid) async {
    return await repository.insetUnidades(unid);
  }
}
