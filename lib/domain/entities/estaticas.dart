import 'package:genesis_vera_tesis/domain/entities/productos.dart';

import 'usuarios/registroUsuarios.dart';

class Estaticas {
  static List<Productos> listProductos = [];
  static List<RegistUser> listUsuarios = [];

  static cargaInicial() {
    for (int i = 0; i < 3; i++) {
      listProductos.add(
        new Productos(id: i, descripcion: "Prod$i", stock: i + 50, precio: 1),
      );
    }

    listUsuarios.add(
      new RegistUser(cedula: "admin", contrasenia: "123"),
    );
  }
}
