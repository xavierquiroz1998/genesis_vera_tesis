import 'package:genesis_vera_tesis/core/Errors/exceptions.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:genesis_vera_tesis/data/datasource/grupo/grupo_datasource.dart';
import 'package:genesis_vera_tesis/domain/entities/tipo/grupo.dart';
import 'package:genesis_vera_tesis/domain/repositories/grupo/abstract_grupo.dart';

class GrupoImp implements AbstractGrupo {
  final GrupoDTS datasource;

  GrupoImp(this.datasource);

  @override
  Future<Either<Failure, List<GrupoEntity>>> getAllGrupos() async {
    try {
      return right(await datasource.getAllGrupos());
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, GrupoEntity>> insertGrupos(GrupoEntity grupo) async {
    try {
      return right(await datasource.insertGrupos(grupo));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }
}
