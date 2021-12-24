import 'package:fluro/fluro.dart';
import 'package:genesis_vera_tesis/ui/pages/Egreso/egresoProducto.dart';
import 'package:genesis_vera_tesis/ui/pages/Login/login.dart';
import 'package:genesis_vera_tesis/ui/pages/Productos/productos.dart';
import 'package:genesis_vera_tesis/ui/pages/Proveedor/Proveedor.dart';
import 'package:genesis_vera_tesis/ui/pages/Proveedores/Proveedores.dart';
import 'package:genesis_vera_tesis/ui/pages/Usuarios/registroUsuarios.dart';
import 'package:genesis_vera_tesis/ui/pages/incio/inicio.dart';

class Handlers {
  static Handler login = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    if (true) {
      return Login();
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

  static Handler usuarios = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    if (true) {
      return RegistroUsuario();
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
    } else {
      return Login();
    }
  });
}
