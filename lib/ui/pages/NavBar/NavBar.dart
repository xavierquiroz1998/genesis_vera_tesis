import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/providers/Home/sideMenuProvider.dart';
import 'package:genesis_vera_tesis/ui/pages/NavBarAvatar/NavBarAvatar.dart';
import 'package:genesis_vera_tesis/ui/pages/Search_Text/SearchText.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: 50,
      //color: Colors.red,
      decoration: buildBoxDecoration(),
      child: Row(
        children: [
          if (size.width <= 700) ...[
            IconButton(
                onPressed: () {
                  SideMenuProvider.openMenu();
                },
                icon: Icon(Icons.menu_outlined)),
          ],

          // icono de menu

          // buscar
          // if (size.width > 400)
          //   ConstrainedBox(
          //     constraints: BoxConstraints(maxWidth: 250),
          //     child: SearchText(),
          //   ),
          Spacer(),
          NavBarAvatar(),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() =>
      BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black26, blurRadius: 5),
      ]);
}
