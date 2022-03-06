import 'package:dartz/dartz.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:genesis_vera_tesis/domain/entities/unidad_medida/unidadMedida.dart';
import 'package:genesis_vera_tesis/domain/repositories/unidad_medida/abstractMedida.dart';

class GetMedidas {
  final AbstractMedidaUnidad repository;

  GetMedidas(this.repository);

  Future<Either<Failure, List<UnidadMedidaEntity>>> call() async {
    return repository.getAllUnidades();
  }
}
