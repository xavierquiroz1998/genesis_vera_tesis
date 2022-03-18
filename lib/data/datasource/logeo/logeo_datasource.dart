import 'package:genesis_vera_tesis/data/datasource/http_static.dart';
import 'package:http/http.dart' as http;

abstract class LogeoDatasource {
  Future<String> inicioSesion(String usuario, String contrasenia);
}

class LogeoDatasourceImp extends LogeoDatasource {
  final http.Client cliente;
  LogeoDatasourceImp(this.cliente);

  @override
  Future<String> inicioSesion(String usuario, String contrasenia) async {
    try {
      final data = {"correo": usuario, "password": contrasenia};
      final result = await cliente
          .post(Uri.parse(HttpStatic.baseUrl + "auth/login"), body: data);
      return result.body;
    } catch (ex) {
      return "Error en Datasource" + ex.toString();
    }
  }
}
