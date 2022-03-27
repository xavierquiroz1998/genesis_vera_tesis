import 'package:dartz/dartz.dart';
import 'package:genesis_vera_tesis/domain/entities/kardex/kardex.dart';

import '../../../core/Errors/failure.dart';

abstract class AbstractKardex {
  Future<Either<Failure, List<Kardex>>> getAllKardex();
  Future<Either<Failure, List<Kardex>>> getKardex(int idProducto);
  Future<Either<Failure, Kardex>> insertKardex(Kardex prod);
  Future<Either<Failure, Kardex>> updateKardex(Kardex prod);
  Future<Either<Failure, Kardex>> deleteKardex(Kardex prod);
}
