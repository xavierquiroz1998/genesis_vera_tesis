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
              onChanged: (value) {
                usuarios.usuarioModel.cedula = value;
              },
              decoration: InputDecoration(labelText: "Cedula"),
            ),
            TextField(
              onChanged: (value) {
                usuarios.usuarioModel.nombres = value;
              },
              decoration: InputDecoration(labelText: "Nombres"),
            ),
            TextField(
              onChanged: (value) {
                usuarios.usuarioModel.direccion = value;
              },
              decoration: InputDecoration(labelText: "Direccion"),
            ),
            TextField(
              onChanged: (value) {
                usuarios.usuarioModel.correo = value;
              },
              decoration: InputDecoration(labelText: "Correo"),
            ),
            TextField(
              onChanged: (value) {
                usuarios.usuarioModel.celular = value;
              },
              decoration: InputDecoration(labelText: "Celular"),
            ),
            TextField(
              onChanged: (value) {
                usuarios.usuarioModel.contrasenia = value;
              },
              decoration: InputDecoration(labelText: "Contraseña"),
            ),
            TextField(
              onChanged: (value) {
                usuarios.repiteContrasenia = value;
              },
              decoration: InputDecoration(labelText: "Repita Contraseña"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    if (usuarios.usuarioModel.contrasenia != "" &&
                        usuarios.repiteContrasenia != "") {
                      usuarios.guardar();
                    } else {
                      print("Ingrese una contraseña");
                    }
                  },
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
