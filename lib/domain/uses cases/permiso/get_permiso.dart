import 'package:dartz/dartz.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:genesis_vera_tesis/domain/entities/permiso/permiso_entity.dart';
import 'package:genesis_vera_tesis/domain/repositories/permiso/abstract_permiso.dart';

class GetPermiso {
  final AbstractPermiso repository;

  GetPermiso(this.repository);

  Future<Either<Failure, List<PermisosEntity>>> call(String uid) async {
    return repository.getAllPermisosUser(uid);
  }
}
