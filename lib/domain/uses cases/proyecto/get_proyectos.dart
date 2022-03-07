import 'package:dartz/dartz.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:genesis_vera_tesis/domain/entities/proyecto/proyecto_entity.dart';
import 'package:genesis_vera_tesis/domain/repositories/proyecto/abstract_proyecto.dart';

class GetProyectos {
  final AbstractProyecto repository;

  GetProyectos(this.repository);

  Future<Either<Failure, List<ProyectoEntity>>> call() async {
    return repository.getAllProyectos();
  }
}
