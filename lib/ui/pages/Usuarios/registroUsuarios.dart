import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/providers/Usuarios/UsuariosProvider.dart';
import 'package:provider/provider.dart';

class RegistroUsuario extends StatelessWidget {
  const RegistroUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usuarios = Provider.of<UsuariosProvider>(context);
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(labelText: ""),
            ),
            TextField(
              decoration: InputDecoration(labelText: ""),
            ),
            TextField(
              decoration: InputDecoration(labelText: ""),
            ),
            TextField(
              decoration: InputDecoration(labelText: ""),
            ),
            TextField(
              decoration: InputDecoration(labelText: ""),
            ),
            TextField(
              decoration: InputDecoration(labelText: "contraseñia"),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Repita contraseñia"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text("Guardar"),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("Cancelar"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
