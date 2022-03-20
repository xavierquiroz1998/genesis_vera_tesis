import 'package:dartz/dartz.dart';

import '../../../core/Errors/failure.dart';
import '../../entities/permiso/permiso_entity.dart';
import '../../repositories/permiso/abstract_permiso.dart';

class InsertPermiso {
  final AbstractPermiso repository;

  InsertPermiso(this.repository);

  Future<Either<Failure, PermisosEntity>> inserPermis(
      PermisosEntity usuario) async {
    return repository.insertPermisosUser(usuario);
  }
}
