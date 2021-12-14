import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/ui/pages/Logo/Logo.dart';

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
          Text("Home"),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.home),
            label: Text("Home"),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.photo_size_select_actual_rounded),
            label: Text("Ingreso Producto"),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.photo_size_select_actual_rounded),
            label: Text("Salida de Productos"),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.person_add_alt_outlined),
            label: Text("Registro de Usuario"),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.paste_rounded),
            label: Text("Reporte Pendientes"),
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
