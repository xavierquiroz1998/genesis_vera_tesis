import 'package:genesis_vera_tesis/Home.dart';

import 'injection.dart' as di;
import 'ui/Router/FluroRouter.dart';
import 'package:flutter/material.dart';

void main() {
  //setPathUrlStrategy();
  di.init();
  Flurorouter.configureRoutes();
  runApp(MyApp());
}
