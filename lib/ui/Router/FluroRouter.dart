import 'package:fluro/fluro.dart';
import 'package:genesis_vera_tesis/domain/repositories/Handlers.dart';

class Flurorouter {
  static final FluroRouter router = new FluroRouter();

  static String rootRouter = "/";
  static String ingreso = "/ingreso";
  static String egreso = "/egreso";

  static void configureRoutes() {
    router.define(rootRouter,
        handler: Handlers.incio, transitionType: TransitionType.none);
    router.define(egreso,
        handler: Handlers.egreso, transitionType: TransitionType.none);
    router.define(ingreso,
        handler: Handlers.ingreso, transitionType: TransitionType.none);

    //router.notFoundHandler = ;
  }
}
