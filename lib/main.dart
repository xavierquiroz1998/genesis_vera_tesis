import 'package:genesis_vera_tesis/Home.dart';
import 'package:genesis_vera_tesis/data/datasource/reference/local_storage.dart';

import 'injection.dart' as di;
import 'ui/Router/FluroRouter.dart';
import 'package:flutter/material.dart';

void main() {
  //setPathUrlStrategy();
  ErrorWidget.builder = (details) => ErrorFailWidget(
        detail: details,
      );
  LocalStorage.configurePrefs();
  di.init();
  Flurorouter.configureRoutes();
  runApp(MyApp());
}

class ErrorFailWidget extends StatelessWidget {
  FlutterErrorDetails? detail;
  ErrorFailWidget({this.detail});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(detail!.exception.toString())],
      ),
    );
  }
}
