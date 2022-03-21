import 'package:genesis_vera_tesis/core/Errors/exceptions.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:genesis_vera_tesis/data/datasource/unidad_medida/unidad_datasource.dart';
import 'package:genesis_vera_tesis/domain/entities/unidad_medida/unidadMedida.dart';
import 'package:genesis_vera_tesis/domain/repositories/unidad_medida/abstractMedida.dart';

class UnidadImp implements AbstractMedidaUnidad {
  final UnidadMediaDTS datasource;
  UnidadImp(this.datasource);

  @override
  Future<Either<Failure, List<UnidadMedidaEntity>>> getAllUnidades() async {
    try {
      return right(await datasource.getAllUnidades());
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de unidades"));
    }
  }

  @override
  Future<Either<Failure, UnidadMedidaEntity>> insetUnidades(
      UnidadMedidaEntity unid) async {
    try {
      return right(await datasource.insertUnidades(unid));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de unidades"));
    }
  }

  @override
  Future<Either<Failure, UnidadMedidaEntity>> deleteUnidades(
      UnidadMedidaEntity unid) async {
    try {
      return right(await datasource.deleteUnidades(unid));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de unidades"));
    }
  }

  @override
  Future<Either<Failure, UnidadMedidaEntity>> updateUnidades(
      UnidadMedidaEntity unid) async {
    try {
      return right(await datasource.updateUnidades(unid));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de unidades"));
    }
  }
}
