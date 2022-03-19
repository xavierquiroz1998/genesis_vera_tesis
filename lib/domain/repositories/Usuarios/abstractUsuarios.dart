import 'package:dartz/dartz.dart';

import '../../../core/Errors/failure.dart';
import '../../entities/usuarios/registroUsuarios.dart';

abstract class AbstractUsuarios {
  Future<Either<Failure, List<RegistUser>>> getAllUsuarios();
  Future<Either<Failure, RegistUser>> insertUsuarios(RegistUser usuario);
}
