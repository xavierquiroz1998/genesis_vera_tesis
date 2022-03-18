import '../../repositories/grupo/abstract_grupo.dart';

class InsertProducto {
  final AbstractGrupo repository;

  InsertProducto(this.repository);

  Future<String> insert() async {
    return await repository.insertGrupos();
  }
}
