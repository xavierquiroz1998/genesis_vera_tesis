import 'package:dartz/dartz.dart';

import '../../../core/Errors/failure.dart';
import '../../entities/tipo/grupo.dart';
import '../../repositories/grupo/abstract_grupo.dart';

class InsertGrupo {
  final AbstractGrupo repository;

  InsertGrupo(this.repository);

  Future<Either<Failure, GrupoEntity>> insert(GrupoEntity grupo) async {
    return await repository.insertGrupos(grupo);
  }
}
