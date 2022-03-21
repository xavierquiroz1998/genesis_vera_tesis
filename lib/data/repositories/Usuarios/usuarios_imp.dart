import 'package:genesis_vera_tesis/domain/entities/usuarios/registroUsuarios.dart';

import 'package:genesis_vera_tesis/core/Errors/failure.dart';

import 'package:dartz/dartz.dart';

import '../../../core/Errors/exceptions.dart';
import '../../../domain/repositories/Usuarios/abstractUsuarios.dart';
import '../../datasource/usuarios/usuarios_datasource.dart';

class UsuariosImp implements AbstractUsuarios {
  final UsuarioDatasource dataSource;

  UsuariosImp(this.dataSource);

  @override
  Future<Either<Failure, List<RegistUser>>> getAllUsuarios() async {
    try {
      return right(await dataSource.getUsuarios());
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de unidades"));
    }
  }

  @override
  Future<Either<Failure, RegistUser>> insertUsuarios(RegistUser usuario) async {
    try {
      return right(await dataSource.insertUsuarios(usuario));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de unidades"));
    }
  }

  @override
  Future<Either<Failure, RegistUser>> deleteUsuarios(RegistUser usuario) async {
    try {
      return right(await dataSource.deleteUsuarios(usuario));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de unidades"));
    }
  }

  @override
  Future<Either<Failure, RegistUser>> updateUsuarios(RegistUser usuario) async {
    try {
      return right(await dataSource.updateUsuarios(usuario));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de unidades"));
    }
  }
}
