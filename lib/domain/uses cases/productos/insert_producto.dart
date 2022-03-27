import 'package:dartz/dartz.dart';
import 'package:genesis_vera_tesis/domain/repositories/abstractPRoducto.dart';

import '../../../core/Errors/failure.dart';
import '../../entities/productos.dart';

class InsertarProducto {
  final AbstractProducto productoRepository;
  InsertarProducto(this.productoRepository);

  Future<Either<Failure, Productos>> insert(Productos producto) async {
    return await productoRepository.insertProducto(producto);
  }
}
