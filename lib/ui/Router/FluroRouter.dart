import 'package:fluro/fluro.dart';
import 'package:genesis_vera_tesis/domain/repositories/Handlers.dart';

class Flurorouter {
  static final FluroRouter router = new FluroRouter();

  static String rootRouter = "/login";
  static String inicio = "/inicio";
  static String ingresos = "/ingresos";
  static String ingreso = "/ingreso";
  static String egreso = "/egreso";
  static String egresos = "/egresos";
  static String proveedores = "/proveedores";
  static String proveedor = "/proveedor";
  static String usuario = "/usuario";
  static String usuarios = "/usuarios";
  static String unidad = "/unidadMedida";
  static String tipoProducto = "/tipo/producto";
  static String parametros = "/parametros";
  static String ingresoss = "/ingresoss";
  static String ingresossCrud = "/ingresossCrud";
  static String calsificacion = "/clasificacion";

  static String devoluciones = "/devoluciones";
  static String devolucion = "/devolucion";
  static String dashboarPorTipo = "/dashboard/PorTipo";

  static String kardex = "/kardex";
  //static String salir = "/login";

  static void configureRoutes() {
    router.define(rootRouter,
        handler: Handlers.login, transitionType: TransitionType.fadeIn);
    router.define(inicio,
        handler: Handlers.incio, transitionType: TransitionType.fadeIn);
    router.define(egreso,
        handler: Handlers.egreso, transitionType: TransitionType.fadeIn);
    router.define(egresos,
        handler: Handlers.egresos, transitionType: TransitionType.fadeIn);
    router.define(ingresos,
        handler: Handlers.ingreso, transitionType: TransitionType.fadeIn);
    router.define(ingreso,
        handler: Handlers.ingresoCrud, transitionType: TransitionType.fadeIn);
    router.define(proveedores,
        handler: Handlers.proveedores, transitionType: TransitionType.fadeIn);
    router.define(proveedor,
        handler: Handlers.proveedor, transitionType: TransitionType.fadeIn);
    router.define(usuario,
        handler: Handlers.usuario, transitionType: TransitionType.fadeIn);
    router.define(usuarios,
        handler: Handlers.usuarios, transitionType: TransitionType.fadeIn);
    router.define(unidad,
        handler: Handlers.unidad, transitionType: TransitionType.fadeIn);
    router.define(tipoProducto,
        handler: Handlers.tipoProducto, transitionType: TransitionType.fadeIn);

    router.define(devoluciones,
        handler: Handlers.devoluciones, transitionType: TransitionType.fadeIn);

    router.define(devolucion,
        handler: Handlers.devolucion, transitionType: TransitionType.fadeIn);

    router.define(kardex,
        handler: Handlers.kardex, transitionType: TransitionType.fadeIn);

    router.define(parametros,
        handler: Handlers.parametros, transitionType: TransitionType.fadeIn);

    router.define(ingresoss,
        handler: Handlers.ingresoss, transitionType: TransitionType.fadeIn);

    router.define(ingresossCrud,
        handler: Handlers.ingresossCrud, transitionType: TransitionType.fadeIn);
    router.define(calsificacion,
        handler: Handlers.clasificacion, transitionType: TransitionType.fadeIn);

    router.define(dashboarPorTipo,
        handler: Handlers.dashboardPorTipo,
        transitionType: TransitionType.fadeIn);

    router.notFoundHandler = Handlers.noFound;
  }
}
