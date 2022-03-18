import 'package:dartz/dartz.dart';
import 'package:genesis_vera_tesis/core/Errors/exceptions.dart';
import 'package:genesis_vera_tesis/core/Errors/failure.dart';
import 'package:genesis_vera_tesis/data/datasource/producto_datasource.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/repositories/abstractPRoducto.dart';

import '../models/productos/modelProductos.dart';

class ProductoImp implements AbstractProducto {
  final ProductosDataSource dataSource;
  ProductoImp(this.dataSource);

  @override
  Future<Either<Failure, List<Productos>>> getAllProductos() async {
    try {
      return right(await dataSource.getProducto());
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener datos"));
    }
  }

  @override
  Future<String> insertProducto(Productos model) async {
    return await dataSource.insertProducto(model);
  }
}
