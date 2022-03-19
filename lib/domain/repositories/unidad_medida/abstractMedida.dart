import 'package:dartz/dartz.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:genesis_vera_tesis/domain/entities/unidad_medida/unidadMedida.dart';

abstract class AbstractMedidaUnidad {
  Future<Either<Failure, List<UnidadMedidaEntity>>> getAllUnidades();
  Future<Either<Failure, UnidadMedidaEntity>> insetUnidades(
      UnidadMedidaEntity unid);
}
