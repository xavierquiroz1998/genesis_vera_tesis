import 'package:http/http.dart' as http;

abstract class ProductosDataSource {
  Future<String> insertProducto();
}

class ProductosDataSourceImp extends ProductosDataSource {
  final http.Client cliente;
  ProductosDataSourceImp(this.cliente);

  @override
  Future<String> insertProducto() async {
    try {
      String url = "";
      final result = await cliente.post(Uri.parse(url));
      return "";
    } catch (ex) {
      return "";
    }
  }
}
