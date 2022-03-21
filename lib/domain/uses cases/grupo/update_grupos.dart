import 'package:dartz/dartz.dart';

import '../../../core/Errors/failure.dart';
import '../../entities/tipo/grupo.dart';
import '../../repositories/grupo/abstract_grupo.dart';

class UpdateGrupos {
  final AbstractGrupo repository;

  UpdateGrupos(this.repository);

  Future<Either<Failure, GrupoEntity>> update(GrupoEntity grupo) async {
    return repository.updateGrupos(grupo);
  }
}
