import 'package:dartz/dartz.dart';

import '../../../core/Errors/failure.dart';
import '../../entities/usuarios/registroUsuarios.dart';
import '../../repositories/Usuarios/abstractUsuarios.dart';

class GetUsuarios {
  final AbstractUsuarios repository;

  GetUsuarios(this.repository);

  Future<Either<Failure, List<RegistUser>>> call() async {
    return repository.getAllUsuarios();
  }
}
