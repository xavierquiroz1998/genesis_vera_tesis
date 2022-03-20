import '../../entities/proyecto/proyecto_entity.dart';
import '../../repositories/proyecto/abstract_proyecto.dart';

class InsertProject {
  final AbstractProyecto repository;

  InsertProject(this.repository);

  Future<bool> insert(List<ProyectoEntity> lisProject) async {
    return repository.insertProyectos(lisProject);
  }
}
