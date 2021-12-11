import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/providers/Login/loginProvider.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logeo = Provider.of<LoginProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            LoginIzquierdo(size: size),
            LoginDerecho(size: size, logeo: logeo),
          ],
        ),
      ),
    );
  }
}

class LoginDerecho extends StatelessWidget {
  const LoginDerecho({
    Key? key,
    required this.size,
    required this.logeo,
  }) : super(key: key);

  final Size size;
  final LoginProvider logeo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 2,
      height: size.height,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: logeo.keyLogin,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                onChanged: (value) {
                  logeo.cedula = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingrese Usuario";
                  }
                },
                decoration: InputDecoration(
                  labelText: "Usuario",
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  logeo.contrasenia = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingrese Contraseña";
                  }
                },
                obscureText: true,
                decoration: InputDecoration(labelText: "Contraseña"),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextButton(
                  onPressed: () {
                    logeo.logeo(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    elevation: 15,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(9),
                    child: Text(
                      "Ingresar",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginIzquierdo extends StatelessWidget {
  const LoginIzquierdo({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 2,
      height: size.height,
      color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
