import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/providers/Login/loginProvider.dart';
import 'package:genesis_vera_tesis/main.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logeo = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Container(
              width: 250,
              height: 250,
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      logeo.cedula = value;
                    },
                    decoration: InputDecoration(labelText: "Usuario"),
                  ),
                  TextField(
                    onChanged: (value) {
                      logeo.contrasenia = value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(labelText: "Contraseña"),
                  ),
                  TextButton(
                    onPressed: () {
                      logeo.logeo(context);
                    },
                    child: Text("Ingresar"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
