import 'package:genesis_vera_tesis/core/Errors/exceptions.dart';
import 'package:genesis_vera_tesis/data/models/registros/modelRegistroDetalle.dart';
import 'package:genesis_vera_tesis/domain/entities/registro/entityRegistor.dart';

import 'package:genesis_vera_tesis/core/Errors/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:genesis_vera_tesis/domain/entities/registro/entityRegistroDetaller.dart';

import '../../../domain/repositories/registros/abstract_registros.dart';
import '../../datasource/registros/registroDataSource.dart';

class RegistrosImp extends AbstractRegistros {
  final RegistroDTS dataSource;

  RegistrosImp(this.dataSource);

  @override
  Future<Either<Failure, EntityRegistro>> deleteRegistros(
      EntityRegistro registro) async {
    try {
      return right(await dataSource.deleteRegistro(registro));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener datos"));
    }
  }

  @override
  Future<Either<Failure, List<EntityRegistro>>> getAll() async {
    try {
      return right(await dataSource.getAll());
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de unidades"));
    }
  }

  @override
  Future<Either<Failure, EntityRegistro>> insertRegistros(
      EntityRegistro registro) async {
    try {
      return right(await dataSource.insertRegistro(registro));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener datos"));
    }
  }

  @override
  Future<Either<Failure, EntityRegistro>> updateRegistros(
      EntityRegistro registro) async {
    try {
      return right(await dataSource.updateRegistro(registro));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener datos"));
    }
  }

  @override
  Future<Either<Failure, EntityRegistroDetalle>> deleteRegistrosDetalles(
      EntityRegistroDetalle registro) async {
    try {
      return right(await dataSource.deleteRegistroDetalle(registro));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener datos"));
    }
  }

  @override
  Future<Either<Failure, EntityRegistroDetalle>> insertRegistrosDetalles(
      EntityRegistroDetalle registro) async {
    try {
      return right(await dataSource.insertRegistroDetalle(registro));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener datos"));
    }
  }

  @override
  Future<Either<Failure, EntityRegistroDetalle>> updateRegistrosDetalles(
      EntityRegistroDetalle registro) async {
    try {
      return right(await dataSource.updateRegistroDetalle(registro));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener datos"));
    }
  }

  @override
  Future<Either<Failure, List<EntityRegistroDetalle>>> getAll_x_id(
      int id) async {
    try {
      return right(await dataSource.getDetalleXregistro(id));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de unidades"));
    }
  }
}
