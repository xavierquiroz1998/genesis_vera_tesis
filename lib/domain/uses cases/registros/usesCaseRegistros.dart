import 'package:dartz/dartz.dart';

import '../../../core/Errors/failure.dart';
import '../../entities/registro/entityRegistor.dart';
import '../../entities/registro/entityRegistroDetaller.dart';
import '../../repositories/registros/abstract_registros.dart';

class UsesCaseRegistros {
  final AbstractRegistros regi;

  UsesCaseRegistros(this.regi);

  Future<Either<Failure, List<EntityRegistro>>> getAll(int idTipo) async {
    return await regi.getAll(idTipo);
  }

  Future<Either<Failure, EntityRegistro>> insertRegistros(
      EntityRegistro registro) async {
    return await regi.insertRegistros(registro);
  }

  Future<Either<Failure, EntityRegistro>> updateRegistros(
      EntityRegistro registro) async {
    return await regi.updateRegistros(registro);
  }

  Future<Either<Failure, EntityRegistro>> deleteRegistros(
      EntityRegistro registro) async {
    return await regi.deleteRegistros(registro);
  }

  Future<Either<Failure, EntityRegistroDetalle>> insertRegistrosDetalles(
      EntityRegistroDetalle registro) async {
    return await regi.insertRegistrosDetalles(registro);
  }

  Future<Either<Failure, EntityRegistroDetalle>> updateRegistrosDetalles(
      EntityRegistroDetalle registro) async {
    return await regi.updateRegistrosDetalles(registro);
  }

  Future<Either<Failure, EntityRegistroDetalle>> deleteRegistrosDetalles(
      EntityRegistroDetalle registro) async {
    return await regi.deleteRegistrosDetalles(registro);
  }
}
