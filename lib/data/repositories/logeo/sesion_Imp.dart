import 'package:genesis_vera_tesis/data/datasource/logeo/logeo_datasource.dart';
import 'package:genesis_vera_tesis/domain/repositories/logeo/abstract_sesion.dart';

class SesionImp extends AbstractSesion {
  final LogeoDatasource logeo;
  SesionImp(this.logeo);

  @override
  Future<String> inicioSesion(String usuario, String contrasenia) async {
    try {
      return await logeo.inicioSesion(usuario, contrasenia);
    } catch (e) {
      return "Error";
    }
  }
}
