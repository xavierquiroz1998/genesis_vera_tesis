import 'package:genesis_vera_tesis/domain/entities/productos.dart';

import 'Proveedores/Proveedores.dart';
import 'usuarios/registroUsuarios.dart';

class Estaticas {
  static List<Productos> listProductos = [];
  static List<RegistUser> listUsuarios = [];
  static List<Proveedores> listProveedores = [];

  static cargaInicial() {
    for (int i = 0; i < 3; i++) {
      listProductos.add(
        new Productos(id: i, descripcion: "Prod$i", stock: i + 50, precio: 1),
      );

// proveedores
      listProveedores.add(new Proveedores(
          idProveedor: i,
          identificacion: "0988888879",
          nombres: "Proveedorer$i",
          direccion: "direccion",
          correo: "noexiste@gmail.com",
          celular: "123456789"));
    }

    listUsuarios.add(
      new RegistUser(cedula: "admin", contrasenia: "123"),
    );
  }
}
