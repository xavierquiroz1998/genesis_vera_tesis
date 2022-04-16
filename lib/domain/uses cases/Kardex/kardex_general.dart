import 'package:dartz/dartz.dart';

import '../../../core/Errors/failure.dart';
import '../../entities/kardex/kardex.dart';
import '../../repositories/kardex/abstract_kardex.dart';

class KardexGeneral {
  final AbstractKardex kardex;

  KardexGeneral(this.kardex);

  Future<Either<Failure, List<Kardex>>> getAll() async {
    return kardex.getAllKardex();
  }

  Future<Either<Failure, List<Kardex>>> getAllProducto(int idProducto) async {
    return kardex.getKardex(idProducto);
  }

  Future<Either<Failure, Kardex>> inserteKardex(Kardex k) async {
    return kardex.insertKardex(k);
  }

  Future<Either<Failure, Kardex>> updateKardex(Kardex k) async {
    return kardex.updateKardex(k);
  }

  Future<Either<Failure, Kardex>> deleteKardex(Kardex k) async {
    return kardex.deleteKardex(k);
  }

  Future<Either<Failure, Kardex>> getKardexUltimo(String k) async {
    return kardex.getKardexUltimo(k);
  }
}
