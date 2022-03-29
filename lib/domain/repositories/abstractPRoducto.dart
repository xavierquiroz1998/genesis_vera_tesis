import 'package:dartz/dartz.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';

import '../../core/Errors/failure.dart';

abstract class AbstractProducto {
  Future<Either<Failure, List<Productos>>> getAllProductos();

  Future<Either<Failure, Productos>> insertProducto(Productos model);
  Future<Either<Failure, Productos>> updateProducto(Productos model);
  Future<Either<Failure, Productos>> deleteProducto(Productos model);
}
