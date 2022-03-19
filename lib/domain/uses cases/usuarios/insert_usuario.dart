import 'package:dartz/dartz.dart';

import '../../../core/Errors/failure.dart';
import '../../entities/usuarios/registroUsuarios.dart';
import '../../repositories/Usuarios/abstractUsuarios.dart';

class InsertUsuarios {
  final AbstractUsuarios repository;

  InsertUsuarios(this.repository);

  Future<Either<Failure, List<RegistUser>>> call() async {
    return repository.getAllUsuarios();
  }
}
