import 'package:dartz/dartz.dart';

import '../../../core/Errors/failure.dart';
import '../../entities/productos.dart';
import '../../repositories/abstractPRoducto.dart';

class GeneralProducto {
  final AbstractProducto productoRepository;
  GeneralProducto(this.productoRepository);

  Future<Either<Failure, Productos>> update(Productos producto) async {
    return await productoRepository.updateProducto(producto);
  }

  Future<Either<Failure, Productos>> delete(Productos producto) async {
    return await productoRepository.deleteProducto(producto);
  }
}
