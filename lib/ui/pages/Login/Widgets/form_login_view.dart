import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/providers/Login/loginProvider.dart';
import 'package:genesis_vera_tesis/ui/style/custom_inputs.dart';
import 'package:provider/provider.dart';

class FormLoginView extends StatefulWidget {
  const FormLoginView({
    Key? key,
  }) : super(key: key);

  @override
  State<FormLoginView> createState() => _FormLoginViewState();
}

class _FormLoginViewState extends State<FormLoginView> {
  final _keyLogin = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final logeo = Provider.of<LoginProvider>(context);
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _keyLogin,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "INICIAR SESIÓN",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  logeo.cedula = value;
                },
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingrese Usuario";
                  }
                },
                decoration: CustomInputs.loginInputDecoration(
                    hint: "Usuario",
                    label: "Usuario",
                    icon: Icons.assignment_ind_rounded),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  logeo.contrasenia = value;
                },
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingrese Contraseña";
                  }
                },
                obscureText: true,
                decoration: CustomInputs.loginInputDecoration(
                    hint: "Contraseña", label: "Contraseña", icon: Icons.lock),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextButton(
                  onPressed: () async {
                    if (_keyLogin.currentState!.validate()) {
                      logeo.logeo();
                    }
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
