import 'package:genesis_vera_tesis/domain/providers/kardex/kardex_provider.dart';

import 'ui/Router/FluroRouter.dart';
import 'ui/pages/NavBar/NavBar.dart';
import 'package:flutter/material.dart';
import 'ui/pages/SideBar/SideBar.dart';
import 'package:provider/provider.dart';
import 'domain/providers/Login/loginProvider.dart';
import 'domain/providers/Home/sideMenuProvider.dart';
import 'domain/providers/Usuarios/UsuariosProvider.dart';
import 'domain/providers/unidadMedida/unidadProvider.dart';
import 'package:genesis_vera_tesis/domain/providers/productosProvider.dart';
import 'package:genesis_vera_tesis/domain/providers/egreso/e_productoProvider.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/providers/Productos/producto_provider.dart';
import 'package:genesis_vera_tesis/domain/providers/Devoluciones/devolucionProvider.dart';
import 'package:genesis_vera_tesis/domain/providers/Proveedores/proveedoresProvider.dart';

void main() {
  //setPathUrlStrategy();
  Flurorouter.configureRoutes();
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
        ChangeNotifierProvider(create: (_) => UnidadMedidaProvider()),
        ChangeNotifierProvider(create: (_) => ProductoProvider()),
        ChangeNotifierProvider(create: (_) => DevolucionProvider()),
        ChangeNotifierProvider(create: (_) => KardexProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        initialRoute: "/login", //"/inicio",
        onGenerateRoute: Flurorouter.router.generator,
        navigatorKey: NavigationService.navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        builder: (context1, child) {
          final logeo = Provider.of<LoginProvider>(context1);

          if (!logeo.authenticated) {
            return child!;
          } else {
            return HomePage(child: child!);
          }
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SideMenuProvider.menuController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              if (size.width >= 700) SideBar(),
              Expanded(
                child: Column(
                  children: [
                    NavBar(),
                    Expanded(
                      child: widget.child,
                    ),
                  ],
                ),
              )
            ],
          ),
          if (size.width < 700)
            AnimatedBuilder(
              animation: SideMenuProvider.menuController,
              builder: (context, _) => Stack(
                children: [
                  if (SideMenuProvider.menuOpen)
                    Opacity(
                      opacity: SideMenuProvider.opacity.value,
                      child: GestureDetector(
                        onTap: () {
                          SideMenuProvider.closeMenu();
                        },
                        child: Container(
                          width: size.width,
                          height: size.height,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                  Transform.translate(
                    offset: Offset(SideMenuProvider.movimiento.value, 0),
                    child: SideBar(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
