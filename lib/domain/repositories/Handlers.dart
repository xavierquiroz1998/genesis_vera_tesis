import 'package:fluro/fluro.dart';
import 'package:genesis_vera_tesis/ui/pages/Egreso/egresoProducto.dart';
import 'package:genesis_vera_tesis/ui/pages/Login/login.dart';
import 'package:genesis_vera_tesis/ui/pages/Productos/productos.dart';
import 'package:genesis_vera_tesis/ui/pages/incio/inicio.dart';

class Handlers {
  static Handler login = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    if (true) {
      return Login();
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
