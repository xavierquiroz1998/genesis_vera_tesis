import 'package:fluro/fluro.dart';
import 'package:genesis_vera_tesis/domain/providers/Login/loginProvider.dart';
import 'package:genesis_vera_tesis/ui/pages/404/noFound.dart';
import 'package:genesis_vera_tesis/ui/pages/Devoluciones_Pages/Devolucion/devolucion_view.dart';
import 'package:genesis_vera_tesis/ui/pages/Devoluciones_Pages/Devoluciones/devoluciones_view.dart';
import 'package:genesis_vera_tesis/ui/pages/Egreso/egresoProducto.dart';
import 'package:genesis_vera_tesis/ui/pages/Egresos/egresoProductos.dart';
import 'package:genesis_vera_tesis/ui/pages/Login/login.dart';
import 'package:genesis_vera_tesis/ui/pages/Producto/productoCrud.dart';
import 'package:genesis_vera_tesis/ui/pages/Productos/productos.dart';
import 'package:genesis_vera_tesis/ui/pages/Proveedor/Proveedor.dart';
import 'package:genesis_vera_tesis/ui/pages/Proveedores/Proveedores.dart';
import 'package:genesis_vera_tesis/ui/pages/Usuario/registroUsuarios.dart';
import 'package:genesis_vera_tesis/ui/pages/Usuarios/usuario_View.dart';
import 'package:genesis_vera_tesis/ui/pages/incio/inicio.dart';
import 'package:genesis_vera_tesis/ui/pages/tipo_producto/tipo_producto.dart';
import 'package:genesis_vera_tesis/ui/pages/unidad_medidas/unidadMedidaView.dart';
import 'package:provider/provider.dart';

class Handlers {
  static Handler login = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    return Login();
  });
  static Handler unidad = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    if (logeo.authenticated) {
      return UnidadMedidaView();
    } else {
      return Login();
    }
  });
  static Handler egresos = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    if (logeo.authenticated) {
      return EgresoProductosView();
    } else {
      return Login();
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
    final logeo = Provider.of<LoginProvider>(context!);
    if (logeo.authenticated) {
      return Proveedores();
    } else {
      return Login();
    }
  });

  static Handler proveedor = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    if (logeo.authenticated) {
      return Proveedor();
    } else {
      return Login();
    }
  });

  static Handler usuario = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    if (logeo.authenticated) {
      return RegistroUsuario();
    } else {
      return Login();
    }
  });

  static Handler usuarios = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    if (logeo.authenticated) {
      return UsuarioView();
    } else {
      return Login();
    }
  });

  static Handler incio = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    if (logeo.authenticated) {
      return Inicio();
    } else {
      return Login();
    }
  });

  static Handler egreso = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    if (logeo.authenticated) {
      return EgresoProducto();
    } else {
      return Login();
    }
  });

  static Handler ingreso = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    if (logeo.authenticated) {
      return ProductosTable();
    } else {
      return Login();
    }
  });

  static Handler ingresoCrud = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    if (logeo.authenticated) {
      return ProductoCrud();
    } else {
      return Login();
    }
  });

  static Handler tipoProducto = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    if (logeo.authenticated) {
      return TipoProducto();
    } else {
      return Login();
    }
  });

  static Handler devoluciones = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    if (logeo.authenticated) {
      return DevolucionesView();
    } else {
      return Login();
    }
  });

  static Handler devolucion = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    if (logeo.authenticated) {
      return DevolucionView();
    } else {
      return Login();
    }
  });
}
