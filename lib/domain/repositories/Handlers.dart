import 'package:fluro/fluro.dart';
import 'package:genesis_vera_tesis/ui/pages/404/noFound.dart';
import 'package:genesis_vera_tesis/ui/pages/Egreso/egresoProducto.dart';
import 'package:genesis_vera_tesis/ui/pages/Egresos/egresoProductos.dart';
import 'package:genesis_vera_tesis/ui/pages/Login/login.dart';
import 'package:genesis_vera_tesis/ui/pages/Productos/productos.dart';
import 'package:genesis_vera_tesis/ui/pages/Proveedor/Proveedor.dart';
import 'package:genesis_vera_tesis/ui/pages/Proveedores/Proveedores.dart';
import 'package:genesis_vera_tesis/ui/pages/Usuario/registroUsuarios.dart';
import 'package:genesis_vera_tesis/ui/pages/Usuarios/usuario_View.dart';
import 'package:genesis_vera_tesis/ui/pages/incio/inicio.dart';
import 'package:genesis_vera_tesis/ui/pages/tipo_producto/tipo_producto.dart';
import 'package:genesis_vera_tesis/ui/pages/unidad_medidas/unidadMedidaView.dart';

class Handlers {
  static Handler login = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    if (true) {
      return Login();
    }
  });
  static Handler unidad = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    if (true) {
      return UnidadMedidaView();
    }
  });
  static Handler egresos = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    if (true) {
      return EgresoProductosView();
    }
  });

  static Handler noFound = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    if (true) {
      return NoPageFoundView();
    }
  });

  static Handler proveedores = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    if (true) {
      return Proveedores();
    }
  });

  static Handler proveedor = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    if (true) {
      return Proveedor();
    }
  });

  static Handler usuario = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    if (true) {
      return RegistroUsuario();
    }
  });

  static Handler usuarios = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    if (true) {
      return UsuarioView();
    }
  });

  static Handler incio = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    if (true) {
      return Inicio();
    } else {
      return Login();
    }
  });

  static Handler egreso = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    if (true) {
      return EgresoProducto();
    } else {
      return Login();
    }
  });

  static Handler ingreso = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    if (true) {
      return ProductosTable();
    }
  });
  static Handler tipoProducto = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    if (true) {
      return TipoProducto();
    }
  });
}
