import 'Proveedores/Proveedores.dart';
import 'egreso/egresoProducto.dart';
import 'unidad_medida/unidadMedida.dart';
import 'usuarios/registroUsuarios.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';

class Estaticas {
  static List<Productos> listProductos = [];
  static List<EgresoDetalle> listProductosEgreso = [];
  static List<RegistUser> listUsuarios = [];
  static List<ProveedoresEntity> listProveedores = [];
  static List<UnidadMedida> unidades = [];

  static cargaInicial() {
    for (int i = 0; i < 3; i++) {
      listProductos.add(
        new Productos(id: i, descripcion: "Prod$i", stock: i + 50, precio: 1),
      );

// proveedores
      listProveedores.add(new ProveedoresEntity(
          idProveedor: i,
          identificacion: "0988888879",
          nombres: "Proveedorer$i",
          direccion: "direccion",
          correo: "noexiste@gmail.com",
          estado: "A",
          celular: "123456789"));
    }

// unidad medida
    unidades.add(new UnidadMedida(
        id: 1, codigo: "UNI", descripcion: "UNIDAD", estado: "A"));
    unidades.add(new UnidadMedida(
        id: 2, codigo: "M", descripcion: "METRO", estado: "A"));
    unidades.add(new UnidadMedida(
        id: 3, codigo: "KG", descripcion: "KILOGRAMO", estado: "A"));
    unidades.add(new UnidadMedida(
        id: 4, codigo: "LB", descripcion: "LIBRA", estado: "A"));
    unidades.add(new UnidadMedida(
        id: 5, codigo: "G", descripcion: "GRAMO", estado: "A"));

    listUsuarios.add(
      new RegistUser(
          idUsuario: 1,
          nombres: "Administrador",
          correo: "admin@gmail.com",
          celular: "099999999",
          cedula: "admin",
          contrasenia: "123",
          estado: "A"),
    );
  }
}
