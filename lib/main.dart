import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/providers/egreso/e_productoProvider.dart';
import 'package:genesis_vera_tesis/domain/providers/productosProvider.dart';
import 'package:genesis_vera_tesis/ui/pages/Egreso/egresoProducto.dart';
import 'package:genesis_vera_tesis/ui/pages/Productos/productos.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductosProvider()),
        ChangeNotifierProvider(create: (_) => EProductoProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
            // Navigator(
            //   pages: [

            //   ],
            //   //transitionDelegate: ,
            //   onPopPage: (route, result) {
            //     return route.didPop(result);
            //   },
            // )
            MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductosTable(),
                  ),
                );
              },
              child: Text("Ingreso Productos"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EgresoProducto(),
                  ),
                );
              },
              child: Text("Egreso Productos"),
            ),
            TextButton(
              onPressed: () {},
              child: Text("Home"),
            ),
            TextButton(
              onPressed: () {},
              child: Text("Login"),
            ),
            TextButton(
              onPressed: () {},
              child: Text("Reportes"),
            ),
            TextButton(
              onPressed: () {
                openFile();
              },
              child: Text("Cargar Excel"),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> openFile() async {
  try {
    File file;
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['xlsx']);

    // String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (result != null) {
      //file = File(result.files.first.path!);
      var bytesData = result.files.first.bytes;
      var excel = Excel.decodeBytes(bytesData!);

      for (var item in excel.tables.keys) {
        print(item);
        print(excel.tables[item]!.maxCols);
        print(excel.tables[item]!.maxRows);
        for (var row in excel.tables[item]!.rows) {
          var codigo = row[0]!.value;
          var descripcion = row[1]!.value;
          var stock = row[2]!.value;
          var precio = row[3]!.value;
          // valida encabezado
          if (codigo.toString() != "codigo") {
            Productos p = new Productos(
                codigo: codigo.toString(),
                descripcion: descripcion.toString(),
                stock: int.parse(stock.toString()),
                precio: double.parse(precio.toString()));
            p.id = Estaticas.listProductos.length + 1;
            Estaticas.listProductos.add(p);
          }
        }
      }
    } else {
      // User canceled the picker
    }
    //final _result = await OpenFile.open(filePath);
    //print(_result.message);

  } catch (e) {
    print("erro en open file ${e.toString()}");
  }
}
