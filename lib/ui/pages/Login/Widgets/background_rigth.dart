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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Distribuidora"),
                ),
                Text(
                  "KIARITA",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  "imagen",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(color: Colors.red);
  }
}
