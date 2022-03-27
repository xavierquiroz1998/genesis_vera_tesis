import 'package:genesis_vera_tesis/core/Errors/exceptions.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:genesis_vera_tesis/domain/entities/kardex/kardex.dart';
import 'package:genesis_vera_tesis/domain/repositories/kardex/abstract_kardex.dart';

import '../../datasource/kardex/kardex_datasource.dart';

class KardexImp extends AbstractKardex {
  final KardexDTS datasource;

  KardexImp(this.datasource);

  @override
  Future<Either<Failure, Kardex>> deleteKardex(prod) async {
    try {
      return right(await datasource.deleteKardex(prod));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, List<Kardex>>> getAllKardex() async {
    try {
      return right(await datasource.getAllKardex());
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, List<Kardex>>> getKardex(int idProducto) async {
    try {
      return right(await datasource.getKardex(idProducto));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, Kardex>> insertKardex(Kardex prod) async {
    try {
      return right(await datasource.insertKardex(prod));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, Kardex>> updateKardex(Kardex prod) async {
    try {
      return right(await datasource.updateKardex(prod));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }
}
