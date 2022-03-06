import 'package:dartz/dartz.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:genesis_vera_tesis/domain/entities/tipo/grupo.dart';
import 'package:genesis_vera_tesis/domain/repositories/grupo/abstract_grupo.dart';

class GetGrupos {
  final AbstractGrupo repository;

  GetGrupos(this.repository);

  Future<Either<Failure, List<GrupoEntity>>> call() async {
    return repository.getAllGrupos();
  }
}
