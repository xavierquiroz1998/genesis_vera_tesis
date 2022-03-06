import 'package:genesis_vera_tesis/domain/entities/usuarios/permisos_usuarios.dart';

import 'egreso/egresoProducto.dart';
import 'Proveedores/Proveedores.dart';
import 'usuarios/registroUsuarios.dart';
import 'unidad_medida/unidadMedida.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/entities/tipo/tipo_producto.dart';
import 'package:genesis_vera_tesis/domain/entities/Devoluciones/devolucion_cab.dart';

class Estaticas {
  static List<Productos> listProductos = [];
  static List<EgresoCabecera> listProductosEgreso = [];
  static List<DevolucionCab> listDevoluciones = [];
  static List<RegistUser> listUsuarios = [];
  static List<ProveedoresEntity> listProveedores = [];
  static List<UnidadMedidaEntity> unidades = [];
  static List<TipoProducto> listTipoProduct = [];
  static PermisoUsuarios permisos = new PermisoUsuarios();
  static cargaInicial() {
    for (int i = 0; i < 3; i++) {
      // listProductos.add(
      //   new Productos(
      //       id: i,
      //       codigo: "0$i",
      //       descripcion: "Prod$i",
      //       stock: i + 50,
      //       precio: 1,
      //       unidadMedida: 1,
      //       estado: "A",
      //       tipoProdcuto: "1372"),
      // );

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
/*     unidades.add(new UnidadMedida(
        id: 1, codigo: "UNI", descripcion: "UNIDAD", estado: "A"));
    unidades.add(new UnidadMedida(
        id: 2, codigo: "M", descripcion: "METRO", estado: "A"));
    unidades.add(new UnidadMedida(
        id: 3, codigo: "KG", descripcion: "KILOGRAMO", estado: "A"));
    unidades.add(new UnidadMedida(
        id: 4, codigo: "LB", descripcion: "LIBRA", estado: "A"));
    unidades.add(new UnidadMedida(
        id: 5, codigo: "G", descripcion: "GRAMO", estado: "A")); */

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

    permisos.egreso = true;
    permisos.ingreso = true;
    permisos.tipoProd = true;
    permisos.proveedores = true;
    permisos.devoluciones = true;
    permisos.kardex = true;
    permisos.unidadMedida = true;
    permisos.usuarios = true;
    //Tipo

    listTipoProduct.add(TipoProducto(
        codPro: "${listTipoProduct.length}",
        codRef: '1372',
        nomPro: 'Herramientas de casa',
        desPro: 'Artefactos para el uso de viviendas',
        stsPro: 'A'));
  }
}
