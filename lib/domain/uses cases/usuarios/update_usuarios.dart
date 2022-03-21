import 'package:dartz/dartz.dart';

import '../../../core/Errors/failure.dart';
import '../../entities/usuarios/registroUsuarios.dart';
import '../../repositories/Usuarios/abstractUsuarios.dart';

class UpdatetUsuarios {
  final AbstractUsuarios repository;

  UpdatetUsuarios(this.repository);

  Future<Either<Failure, RegistUser>> update(RegistUser user) async {
    return repository.updateUsuarios(user);
  }
}
