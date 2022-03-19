import '../../entities/tipo/grupo.dart';
import '../../repositories/grupo/abstract_grupo.dart';

class InsertProducto {
  final AbstractGrupo repository;

  InsertProducto(this.repository);

  Future<String> insert(GrupoEntity grupo) async {
    return await repository.insertGrupos(grupo);
  }
}
