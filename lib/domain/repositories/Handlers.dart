import 'package:fluro/fluro.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/providers/Login/loginProvider.dart';
import 'package:genesis_vera_tesis/ui/pages/404/noFound.dart';
import 'package:genesis_vera_tesis/ui/pages/Devoluciones_Pages/Devolucion/devolucion_view.dart';
import 'package:genesis_vera_tesis/ui/pages/Devoluciones_Pages/Devoluciones/devoluciones_view.dart';
import 'package:genesis_vera_tesis/ui/pages/Egreso/egresoProducto.dart';
import 'package:genesis_vera_tesis/ui/pages/Egresos/egresoProductos.dart';
import 'package:genesis_vera_tesis/ui/pages/Kardex/kardex_layout.dart';
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

import '../../ui/Router/FluroRouter.dart';
import '../../ui/pages/clasificacion/clasificacionview.dart';
import '../../ui/pages/dashboard/dashboardClasificacion.dart';
import '../../ui/pages/dashboard/dashboardXproducto.dart';
import '../../ui/pages/ingresos/ingresos.dart';
import '../../ui/pages/ingresos/ingresosView.dart';
import '../../ui/pages/parametros/parameter.dart';
import '../../ui/pages/pedido/pedidoMes.dart';
import '../providers/Home/sideMenuProvider.dart';

class Handlers {
  static Handler login = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    return Login();
  });
  static Handler unidad = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.unidad);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return UnidadMedidaView();
    } else {
      return Login();
    }
  });

  static Handler egresos = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.egresos);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return EgresoProductosView();
    } else {
      return Login();
    }
  });

  static Handler noFound = Handler(handlerFunc: (context, param) {
    // validacion de sesion

    return NoPageFoundView();
  });

  static Handler proveedores = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.proveedores);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return Proveedores();
    } else {
      return Login();
    }
  });

  static Handler proveedor = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.proveedor);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return Proveedor();
    } else {
      return Login();
    }
  });

  static Handler usuario = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.usuario);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return RegistroUsuario();
    } else {
      return Login();
    }
  });

  static Handler usuarios = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.usuarios);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return UsuarioView();
    } else {
      return Login();
    }
  });

  static Handler incio = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.inicio);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return Inicio();
    } else {
      return Login();
    }
  });

  static Handler egreso = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.egreso);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return EgresoProducto();
    } else {
      return Login();
    }
  });

  static Handler ingreso = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.ingresos);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return ProductosTable();
    } else {
      return Login();
    }
  });

  static Handler ingresoCrud = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.ingreso);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return ProductoCrud();
    } else {
      return Login();
    }
  });

  static Handler tipoProducto = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.tipoProducto);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return TipoProducto();
    } else {
      return Login();
    }
  });

  static Handler devoluciones = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.devoluciones);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return DevolucionesView();
    } else {
      return Login();
    }
  });

  static Handler devolucion = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.devolucion);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return DevolucionView();
    } else {
      return Login();
    }
  });

  static Handler kardex = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.kardex);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return KardexLayout();
    } else {
      return Login();
    }
  });

  static Handler dashboardPorTipo = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.dashboarPorTipo);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return DashboardProducto();
    } else {
      return Login();
    }
  });

  static Handler parametros = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.parametros);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return ParametrosView();
    } else {
      return Login();
    }
  });

  static Handler ingresoss = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.ingresoss);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return IngresosView();
    } else {
      return Login();
    }
  });

  static Handler ingresossCrud = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.ingresossCrud);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return IngresoView();
    } else {
      return Login();
    }
  });

  static Handler clasificacion = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.calsificacion);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return ClasificacionView();
    } else {
      return Login();
    }
  });

  static Handler pedidos = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.pedido);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return PedidoMes();
    } else {
      return Login();
    }
  });

  static Handler dashboarClasificacion = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.dashboarClasificacion);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return DashboardClasificacion();
    } else {
      return Login();
    }
  });

  static Handler salir = Handler(handlerFunc: (context, param) {
    final logeo = Provider.of<LoginProvider>(context!);
    logeo.lagout();
    return Login();
  });
}
