import 'package:genesis_vera_tesis/data/models/movimiento/modelMovimiento.dart';

import 'package:genesis_vera_tesis/core/Errors/failure.dart';

import 'package:dartz/dartz.dart';

import '../../../core/Errors/exceptions.dart';
import '../../../domain/repositories/movimiento/abstractMovimiento.dart';
import '../../datasource/movimiento/movimientoDS.dart';

class MovimientoImp implements AbstractMovimiento {
  final MovimientoDTS datasource;

  MovimientoImp(this.datasource);
  @override
  Future<Either<Failure, List<ModelMovimiento>>> getAllMov() async {
    try {
      return right(await datasource.getAllMovimiento());
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, ModelMovimiento>> insertMov(
      ModelMovimiento grupo) async {
    try {
      return right(await datasource.insertMovimiento(grupo));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, ModelMovimiento>> updateMov(
      ModelMovimiento grupo) async {
    try {
      return right(await datasource.updateMovimiento(grupo));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, List<ModelMovimiento>>> getAllMovProducto(
      int idProducto) async {
    try {
      return right(await datasource.getAllMovimientoProducto(idProducto));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }
}
