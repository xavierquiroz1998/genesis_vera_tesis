import 'package:genesis_vera_tesis/domain/entities/parametros/entityParameter.dart';

import 'package:genesis_vera_tesis/core/Errors/failure.dart';

import 'package:dartz/dartz.dart';

import '../../../core/Errors/exceptions.dart';
import '../../../domain/repositories/parametros/Abstrac_parametros.dart';
import '../../datasource/parametros/parametros_datasource.dart';

class ParametrosImps extends AbstractParametros {
  final ParametrosDTS datasource;
  ParametrosImps(this.datasource);

  @override
  Future<Either<Failure, List<EntityParametros>>> getAllParametros() async {
    try {
      return right(await datasource.getAllParametros());
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, EntityParametros>> insertParametro(
      EntityParametros grupo) async {
    try {
      return right(await datasource.insertParametros(grupo));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, EntityParametros>> updateParametro(
      EntityParametros grupo) async {
    try {
      return right(await datasource.updateParametros(grupo));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }
}
