import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackgroundRigth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildBoxDecoration(),
      child: Container(
        constraints: BoxConstraints(maxWidth: 400),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 500,
                  height: 500,
                  child: Image.asset(
                    "Ferreteria.png",
                    fit: BoxFit.contain,
                  ),
                ),

                /*   Text(
                  "KIARITA",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  "imagen",
                ), */
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
        image:
            DecorationImage(image: AssetImage('fondo.jpg'), fit: BoxFit.cover));
  }
}
