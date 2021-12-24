import 'package:fluro/fluro.dart';
import 'package:genesis_vera_tesis/domain/repositories/Handlers.dart';

class Flurorouter {
  static final FluroRouter router = new FluroRouter();

  static String rootRouter = "/";
  static String incio = "/inicio";
  static String ingreso = "/ingreso";
  static String egreso = "/egreso";
  static String proveedores = "/proveedores";
  static String proveedor = "/proveedor";
  static String usuario = "/usuario";

  static void configureRoutes() {
    router.define(rootRouter,
        handler: Handlers.login, transitionType: TransitionType.none);
    router.define(incio,
        handler: Handlers.incio, transitionType: TransitionType.none);
    router.define(egreso,
        handler: Handlers.egreso, transitionType: TransitionType.fadeIn);
    router.define(ingreso,
        handler: Handlers.ingreso, transitionType: TransitionType.fadeIn);
    router.define(proveedores,
        handler: Handlers.proveedores, transitionType: TransitionType.fadeIn);
    router.define(proveedor,
        handler: Handlers.proveedor, transitionType: TransitionType.fadeIn);
    router.define(usuario,
        handler: Handlers.usuarios, transitionType: TransitionType.fadeIn);

    //router.notFoundHandler = ;
  }
}
