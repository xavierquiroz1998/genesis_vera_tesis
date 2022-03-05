import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/providers/Login/loginProvider.dart';
import 'package:provider/provider.dart';

class FormLoginView extends StatefulWidget {
  const FormLoginView({
    Key? key,
  }) : super(key: key);

  @override
  State<FormLoginView> createState() => _FormLoginViewState();
}

class _FormLoginViewState extends State<FormLoginView> {
  @override
  Widget build(BuildContext context) {
    final logeo = Provider.of<LoginProvider>(context);
    return Container(
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
