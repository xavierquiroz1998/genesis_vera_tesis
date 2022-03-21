import 'package:dartz/dartz.dart';

import '../../../core/Errors/failure.dart';
import '../../entities/permiso/permiso_entity.dart';
import '../../repositories/permiso/abstract_permiso.dart';

class UpdatePermiso {
  final AbstractPermiso repository;

  UpdatePermiso(this.repository);

  Future<Either<Failure, PermisosEntity>> update(PermisosEntity usuario) async {
    return repository.updatePermisosUser(usuario);
  }
}
