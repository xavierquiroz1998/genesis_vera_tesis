import 'package:genesis_vera_tesis/domain/repositories/abstractPRoducto.dart';

class InsertarProducto {
  final AbstractProducto productoRepository;
  InsertarProducto(this.productoRepository);

  Future<String> call() async {
    return await productoRepository.insertProducto();
  }
}
