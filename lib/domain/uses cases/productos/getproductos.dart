import 'package:dartz/dartz.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/repositories/abstractPRoducto.dart';

import '../../../core/Errors/failure.dart';

class GetProductos {
  final AbstractProducto productoRepository;
  GetProductos(this.productoRepository);
  Future<Either<Failure, List<Productos>>> call() async {
    return productoRepository.getAllProductos();
  }
}
