import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/data/datasource/reference/local_storage.dart';
import 'package:genesis_vera_tesis/data/models/permiso/permiso.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/providers/permiso/permiso_provider.dart';
import 'package:genesis_vera_tesis/ui/Router/FluroRouter.dart';
import 'package:genesis_vera_tesis/ui/pages/Logo/Logo.dart';
import 'package:genesis_vera_tesis/ui/pages/SideBar/widget/menu_item.dart';
import 'package:genesis_vera_tesis/util/util_view.dart';
import 'package:provider/provider.dart';

import '../../../domain/providers/Login/loginProvider.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  void initState() {
    Provider.of<PermisoProvider>(context, listen: false).callgetPermisos("2");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logeo = Provider.of<LoginProvider>(context);
    final permiso = Provider.of<PermisoProvider>(context);
    /*   final LocalStorage _prefService = LocalStorage(); */
    return Container(
      width: 200,
      height: double.infinity,
      decoration: builBoxDecoration(),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Logo(),
          SizedBox(
            height: 50,
          ),
          for (var value in permiso.listGrupo) ...[
            MenuItem(
              text: value.proyecto!.nombre,
              icon: UtilView.icons[int.parse(value.proyecto!.referencia)],
              onPressed: () async {
                NavigationService.navigateTo(value.proyecto!.ruta);
                /*      _prefService.createCache(value).whenComplete(() {
                  Navigator.pushNamed(context, 'dashboard');
                }); */
              },
              isActive: NavigationService.currentPage == value.proyecto!.ruta,
            ),
          ],

          /*  MenuItem(
            text: 'Home',
            icon: Icons.home,
            onPressed: () => NavigationService.navigateTo(Flurorouter.inicio),
            isActive: NavigationService.currentPage == Flurorouter.inicio,
          ),
          if (Estaticas.permisos.ingreso) ...{
            MenuItem(
              text: 'Productos',
              icon: Icons.photo_size_select_actual_rounded,
              onPressed: () =>
                  NavigationService.navigateTo(Flurorouter.ingresos),
              isActive: NavigationService.currentPage == Flurorouter.ingresos,
            ),
          },

          // MenuItem(
          //   text: 'Salida de Productos',
          //   icon: Icons.photo_size_select_actual_rounded,
          //   onPressed: () => NavigationService.navigateTo(Flurorouter.egreso),
          //   isActive: NavigationService.currentPage == Flurorouter.egreso,
          // ),
          if (Estaticas.permisos.egreso) ...{
            MenuItem(
              text: 'Salida de Productos',
              icon: Icons.photo_size_select_actual_rounded,
              onPressed: () =>
                  NavigationService.navigateTo(Flurorouter.egresos),
              isActive: NavigationService.currentPage == Flurorouter.egresos,
            ),
          },
          if (Estaticas.permisos.devoluciones) ...{
            MenuItem(
              text: 'Devolucion de Productos',
              icon: Icons.person_add_alt_outlined,
              onPressed: () =>
                  NavigationService.navigateTo(Flurorouter.devoluciones),
              isActive:
                  NavigationService.currentPage == Flurorouter.devoluciones,
            )
          },
          if (Estaticas.permisos.usuarios) ...{
            MenuItem(
              text: 'Usuarios',
              icon: Icons.person_add_alt_outlined,
              onPressed: () =>
                  NavigationService.navigateTo(Flurorouter.usuarios),
              isActive: NavigationService.currentPage == Flurorouter.usuarios,
            )
          },
          if (Estaticas.permisos.proveedores) ...{
            MenuItem(
              text: 'Registro de Proveedores',
              icon: Icons.home,
              onPressed: () =>
                  NavigationService.navigateTo(Flurorouter.proveedores),
              isActive:
                  NavigationService.currentPage == Flurorouter.proveedores,
            ),
          },
          if (Estaticas.permisos.unidadMedida) ...{
            MenuItem(
              text: 'Unidad Medida',
              icon: Icons.home,
              onPressed: () => NavigationService.navigateTo(Flurorouter.unidad),
              isActive: NavigationService.currentPage == Flurorouter.unidad,
            )
          },
          if (Estaticas.permisos.tipoProd) ...{
            MenuItem(
              text: 'Tipos de Productos',
              icon: Icons.home,
              onPressed: () =>
                  NavigationService.navigateTo(Flurorouter.tipoProducto),
              isActive:
                  NavigationService.currentPage == Flurorouter.tipoProducto,
            ),
          },

          MenuItem(
            text: 'Reporte Pendientes',
            icon: Icons.home,
            onPressed: () {},
            // isActive: NavigationService.currentPage == Flurorouter.unidad,
          ),
          MenuItem(
            text: 'Reporte por Producto',
            icon: Icons.home,
            onPressed: () =>
                NavigationService.navigateTo(Flurorouter.dashboarPorTipo),
            // isActive: NavigationService.currentPage == Flurorouter.unidad,
          ),
          if (Estaticas.permisos.tipoProd) ...{
            MenuItem(
              text: 'Kardex',
              icon: Icons.assessment,
              onPressed: () => NavigationService.navigateTo(Flurorouter.kardex),
              isActive: NavigationService.currentPage == Flurorouter.kardex,
            )
          }, */
          MenuItem(
            text: 'Salir',
            icon: Icons.exit_to_app,
            onPressed: () {
              logeo.lagout();
              NavigationService.navigateTo("/login");
              //NavigationService.navigatorKey = new GlobalKey<NavigatorState>();
            },
            //isActive: NavigationService.currentPage == Flurorouter.salir,
          ),
        ],
      ),
    );
  }

  BoxDecoration builBoxDecoration() => BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff092044),
            Color(0xff092042),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
          ),
        ],
      );
}
