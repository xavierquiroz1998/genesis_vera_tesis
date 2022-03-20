import 'package:dartz/dartz_unsafe.dart';
import 'package:genesis_vera_tesis/core/Errors/exceptions.dart';
import 'package:genesis_vera_tesis/data/datasource/proyecto/proyecto_datasource.dart';
import 'package:genesis_vera_tesis/domain/entities/proyecto/proyecto_entity.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:genesis_vera_tesis/domain/repositories/proyecto/abstract_proyecto.dart';

class ProyectoImpl implements AbstractProyecto {
  final ProyectoDTS datasource;

  ProyectoImpl(this.datasource);

  @override
  Future<Either<Failure, List<ProyectoEntity>>> getAllProyectos() async {
    try {
      return right(await datasource.getAll());
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de unidades"));
    }
  }

  @override
  Future<bool> insertProyectos(List<ProyectoEntity> listProject) async {
    try {
      for (var item in listProject) {
        await datasource.insertProyect(item);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
