import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> alert(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(""),
      content: Text(""),
      actions: [
        TextButton(onPressed: () {}, child: Text("Aceptar")),
        TextButton(onPressed: () {}, child: Text("Cancelar"))
      ],
    ),
  );
}
