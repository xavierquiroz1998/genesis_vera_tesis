import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/ui/Router/FluroRouter.dart';
import 'package:genesis_vera_tesis/ui/pages/Logo/Logo.dart';
import 'package:genesis_vera_tesis/ui/pages/SideBar/widget/menu_item.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          MenuItem(
            text: 'Home',
            icon: Icons.home,
            onPressed: () => NavigationService.navigateTo(Flurorouter.incio),
            isActive: NavigationService.currentPage == Flurorouter.incio,
          ),
          MenuItem(
            text: 'Ingreso Producto',
            icon: Icons.photo_size_select_actual_rounded,
            onPressed: () => NavigationService.navigateTo(Flurorouter.ingreso),
            isActive: NavigationService.currentPage == Flurorouter.ingreso,
          ),
          MenuItem(
            text: 'Salida de Productos',
            icon: Icons.photo_size_select_actual_rounded,
            onPressed: () => NavigationService.navigateTo(Flurorouter.egreso),
            isActive: NavigationService.currentPage == Flurorouter.egreso,
          ),
          MenuItem(
            text: 'Egreso de Productos',
            icon: Icons.photo_size_select_actual_rounded,
            onPressed: () => NavigationService.navigateTo(Flurorouter.egresos),
            isActive: NavigationService.currentPage == Flurorouter.egresos,
          ),
          MenuItem(
            text: 'Usuarios',
            icon: Icons.person_add_alt_outlined,
            onPressed: () => NavigationService.navigateTo(Flurorouter.usuarios),
            isActive: NavigationService.currentPage == Flurorouter.usuarios,
          ),
          MenuItem(
            text: 'Registro de Usuario',
            icon: Icons.person_add_alt_outlined,
            onPressed: () => NavigationService.navigateTo(Flurorouter.usuario),
            isActive: NavigationService.currentPage == Flurorouter.usuario,
          ),
          MenuItem(
            text: 'Registro de Proveedores',
            icon: Icons.home,
            onPressed: () =>
                NavigationService.navigateTo(Flurorouter.proveedores),
            isActive: NavigationService.currentPage == Flurorouter.proveedores,
          ),
          MenuItem(
            text: 'Unidad Medida',
            icon: Icons.home,
            onPressed: () => NavigationService.navigateTo(Flurorouter.unidad),
            isActive: NavigationService.currentPage == Flurorouter.unidad,
          ),
          MenuItem(
            text: 'Tipos de Productos',
            icon: Icons.home,
            onPressed: () =>
                NavigationService.navigateTo(Flurorouter.tipoProducto),
            isActive: NavigationService.currentPage == Flurorouter.tipoProducto,
          ),
          MenuItem(
            text: 'Reporte Pendientes',
            icon: Icons.home,
            onPressed: () {},
            // isActive: NavigationService.currentPage == Flurorouter.unidad,
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
