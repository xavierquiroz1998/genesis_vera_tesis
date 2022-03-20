import 'package:genesis_vera_tesis/Home.dart';
import 'package:genesis_vera_tesis/data/datasource/reference/local_storage.dart';

import 'injection.dart' as di;
import 'ui/Router/FluroRouter.dart';
import 'package:flutter/material.dart';

void main() {
  //setPathUrlStrategy();
  LocalStorage.configurePrefs();
  di.init();
  Flurorouter.configureRoutes();
  runApp(MyApp());
}
