import 'package:genesis_vera_tesis/data/datasource/producto_datasource.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/repositories/abstractPRoducto.dart';

class ProductoImp extends AbstractProducto {
  final ProductosDataSource dataSource;
  ProductoImp(this.dataSource);

  @override
  List<Productos> getAllProductos() {
    throw UnimplementedError();
  }

  @override
  Future<String> insertProducto() async {
    return await dataSource.insertProducto();
  }
}
