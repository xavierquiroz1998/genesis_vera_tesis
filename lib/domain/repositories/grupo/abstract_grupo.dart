import 'package:dartz/dartz.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:genesis_vera_tesis/domain/entities/tipo/grupo.dart';

abstract class AbstractGrupo {
  Future<Either<Failure, List<GrupoEntity>>> getAllGrupos();
  Future<Either<Failure, GrupoEntity>> insertGrupos(GrupoEntity grupo);
  Future<Either<Failure, GrupoEntity>> updateGrupos(GrupoEntity grupo);
  Future<Either<Failure, GrupoEntity>> deleteGrupos(GrupoEntity grupo);
}
