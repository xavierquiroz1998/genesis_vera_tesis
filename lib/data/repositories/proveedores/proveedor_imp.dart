import 'package:genesis_vera_tesis/core/Errors/exceptions.dart';
import 'package:genesis_vera_tesis/domain/entities/Proveedores/Proveedores.dart';

import 'package:genesis_vera_tesis/core/Errors/failure.dart';

import 'package:dartz/dartz.dart';

import '../../../domain/repositories/proveedores/abtract_proveedores.dart';
import '../../datasource/proveedores/proveedores_datasource.dart';

class ProveedoresImp implements AbstractProveedores {
  final ProveedoresDatasourceADS dataSource;
  ProveedoresImp(this.dataSource);
  @override
  Future<Either<Failure, List<ProveedoresEntity>>> getAllProveedores() async {
    try {
      return right(await dataSource.getAllProveedores());
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener datos"));
    }
  }

  @override
  Future<Either<Failure, ProveedoresEntity>> insertProveedores(
      ProveedoresEntity prod) async {
    try {
      return right(await dataSource.insertProveedores(prod));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener datos"));
    }
  }

  @override
  Future<Either<Failure, ProveedoresEntity>> deleteProveedores(
      ProveedoresEntity prod) async {
    try {
      return right(await dataSource.deleteProveedores(prod));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener datos"));
    }
  }

  @override
  Future<Either<Failure, ProveedoresEntity>> updateProveedores(
      ProveedoresEntity prod) async {
    try {
      return right(await dataSource.updateProveedores(prod));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener datos"));
    }
  }
}
