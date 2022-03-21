import 'package:dartz/dartz.dart';

import '../../../core/Errors/failure.dart';
import '../../entities/tipo/grupo.dart';
import '../../repositories/grupo/abstract_grupo.dart';

class DeleteGrupo {
  final AbstractGrupo repository;

  DeleteGrupo(this.repository);

  Future<Either<Failure, GrupoEntity>> delete(GrupoEntity grupo) async {
    return await repository.deleteGrupos(grupo);
  }
}
