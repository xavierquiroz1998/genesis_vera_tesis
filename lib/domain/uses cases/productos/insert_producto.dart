import 'package:genesis_vera_tesis/domain/repositories/abstractPRoducto.dart';

import '../../entities/productos.dart';

class InsertarProducto {
  final AbstractProducto productoRepository;
  InsertarProducto(this.productoRepository);

  Future<String> insert(Productos producto) async {
    return await productoRepository.insertProducto(producto);
  }
}
