import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/ui/pages/Search_Text/SearchText.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      //color: Colors.red,
      decoration: buildBoxDecoration(),
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.menu_outlined)),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 250),
            child: SearchText(),
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
