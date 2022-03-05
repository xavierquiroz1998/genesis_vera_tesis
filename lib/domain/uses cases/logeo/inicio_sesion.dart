import '../../repositories/logeo/abstract_sesion.dart';

class InicioSesion {
  final AbstractSesion sesionRepository;
  InicioSesion(this.sesionRepository);

  Future<String> call(String usuario, String contrasenia) async {
    return await sesionRepository.inicioSesion(usuario, contrasenia);
  }
}
