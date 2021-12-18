import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/providers/Proveedores/proveedoresProvider.dart';
import 'package:genesis_vera_tesis/domain/providers/egreso/e_productoProvider.dart';
import 'package:genesis_vera_tesis/domain/providers/productosProvider.dart';
import 'package:genesis_vera_tesis/ui/pages/Egreso/egresoProducto.dart';
import 'package:genesis_vera_tesis/ui/pages/Productos/productos.dart';
import 'package:genesis_vera_tesis/ui/pages/Proveedores/Proveedores.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'domain/providers/Login/loginProvider.dart';
import 'domain/providers/Usuarios/UsuariosProvider.dart';
import 'ui/pages/Login/login.dart';
import 'ui/pages/NavBar/NavBar.dart';
import 'ui/pages/SideBar/SideBar.dart';
import 'ui/pages/Usuarios/registroUsuarios.dart';

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
        ChangeNotifierProvider(create: (_) => UsuariosProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => ProveedoresProvider()),
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
  void initState() {
    super.initState();
    Estaticas.cargaInicial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: HomePage(), //Login(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              //
              if (size.width >= 700) SideBar(),
              //
              Expanded(
                child: Column(
                  children: [
                    //
                    NavBar(),
                    //
                    Expanded(
                      child: Text("-----------"),
                    ),
                  ],
                ),
              )
            ],
          ),
          if (size.width < 700) SideBar(),
        ],
      ),
    );
  }
}

class ItemsPage extends StatelessWidget {
  const ItemsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Login(),
                ),
              );
            },
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
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RegistroUsuario(),
                ),
              );
            },
            child: Text("Registro Usuario"),
          ),
        ],
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
            // falta agregar validacion de los demas campos
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
