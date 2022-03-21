import 'package:dartz/dartz.dart';

import '../../../core/Errors/failure.dart';
import '../../entities/usuarios/registroUsuarios.dart';
import '../../repositories/Usuarios/abstractUsuarios.dart';

class DeleteUsuarios {
  final AbstractUsuarios repository;

  DeleteUsuarios(this.repository);

  Future<Either<Failure, RegistUser>> delete(RegistUser user) async {
    return repository.deleteUsuarios(user);
  }
}
