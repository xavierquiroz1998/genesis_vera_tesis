import 'package:genesis_vera_tesis/core/Errors/exceptions.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:genesis_vera_tesis/data/datasource/permiso/permiso_datasource.dart';
import 'package:genesis_vera_tesis/domain/entities/permiso/permiso_entity.dart';
import 'package:genesis_vera_tesis/domain/repositories/permiso/abstract_permiso.dart';

class PermisoImp implements AbstractPermiso {
  final PermisoDTS datasource;
  PermisoImp(this.datasource);

  @override
  Future<Either<Failure, List<PermisosEntity>>> getAllPermisosUser(
      String uid) async {
    try {
      return right(await datasource.getAllPermisosUser(uid));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de unidades"));
    }
  }

  @override
  Future<Either<Failure, PermisosEntity>> insertPermisosUser(
      PermisosEntity usuario) async {
    try {
      return right(await datasource.insertPermisosUser(usuario));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de unidades"));
    }
  }
}
