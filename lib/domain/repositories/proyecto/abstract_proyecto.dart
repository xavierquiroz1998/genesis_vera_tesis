import 'package:dartz/dartz.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:genesis_vera_tesis/domain/entities/proyecto/proyecto_entity.dart';

abstract class AbstractProyecto {
  Future<Either<Failure, List<ProyectoEntity>>> getAllProyectos();
}
