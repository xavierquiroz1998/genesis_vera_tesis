import 'package:dartz/dartz.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:genesis_vera_tesis/domain/entities/permiso/permiso_entity.dart';

abstract class AbstractPermiso {
  Future<Either<Failure, List<PermisosEntity>>> getAllPermisosUser(String uid);
  Future<Either<Failure, PermisosEntity>> insertPermisosUser(
      PermisosEntity usuario);
  Future<Either<Failure, PermisosEntity>> updatePermisosUser(
      PermisosEntity usuario);
  Future<Either<Failure, PermisosEntity>> deletePermisosUser(
      PermisosEntity usuario);
}
