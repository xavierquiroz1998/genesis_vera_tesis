import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesis_vera_tesis/domain/providers/Usuarios/login_form_provider.dart';
import 'package:genesis_vera_tesis/ui/style/custom_inputs.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:provider/provider.dart';
import 'package:genesis_vera_tesis/domain/providers/Usuarios/UsuariosProvider.dart';

import '../../../data/services/Navigation/NavigationService.dart';
import '../../../domain/providers/permiso/permiso_provider.dart';
import '../../../domain/providers/proyecto/proyecto_provider.dart';

class RegistroUsuario extends StatefulWidget {
  const RegistroUsuario({Key? key}) : super(key: key);

  @override
  State<RegistroUsuario> createState() => _RegistroUsuarioState();
}

class _RegistroUsuarioState extends State<RegistroUsuario> {
  String numeros = r'^(?:\+|-)?\d+$';
  @override
  void initState() {
    var proye = Provider.of<ProyectoProvider>(context, listen: false);
    proye.callgetProyecto();
    var pUser = Provider.of<UsuariosProvider>(context, listen: false);
    if (pUser.usuario.id != 0) {
      print("carga permisos ");
      proye.cargarPermisso(pUser.usuario.id);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final usuarios = Provider.of<UsuariosProvider>(context);
    final permisos = Provider.of<ProyectoProvider>(context);
    return ChangeNotifierProvider(
      create: (_) => LoginFormProvider(),
      child: Builder(builder: (context) {
        final loginFormProvider =
            Provider.of<LoginFormProvider>(context, listen: false);
        return Container(
          child: ListView(
            children: [
              WhiteCard(
                title: 'Usuario',
                child: Form(
                  key: loginFormProvider.formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                  controller: usuarios.controlCedula,
                                  decoration: CustomInputs.formInputDecoration(
                                      hint: 'Cédula',
                                      label: 'Cédula',
                                      icon: Icons.person),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Campo Requerido*";
                                    }
                                    return null;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(numeros)),
                                    LengthLimitingTextInputFormatter(13),
                                  ]
                                  //enabled: usuarios.blockCedula,
                                  ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: usuarios.controlNombre,
                                decoration: CustomInputs.formInputDecoration(
                                    hint: 'Nombres',
                                    label: 'Nombres',
                                    icon: Icons.person),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Campo Requerido*";
                                  }
                                  return null;
                                },
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(50),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: usuarios.controlDireccion,
                          decoration: CustomInputs.formInputDecoration(
                              hint: 'Dirección',
                              label: 'Dirección',
                              icon: Icons.directions),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Campo Requerido*";
                            }
                            return null;
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(100),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: usuarios.controlEmail,
                          decoration: CustomInputs.formInputDecoration(
                              hint: 'Correo',
                              label: 'Correo',
                              icon: Icons.email),
                          validator: (value) {
                            if (!EmailValidator.validate(value ?? ''))
                              return 'Email no valido';
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(numeros)),
                            LengthLimitingTextInputFormatter(10),
                          ],
                          controller: usuarios.controlCelular,
                          decoration: CustomInputs.formInputDecoration(
                              hint: 'Celular',
                              label: 'Celular',
                              icon: Icons.phone),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Campo Requerido*";
                            }
                            return null;
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: usuarios.controlpassword,
                                obscureText: true,
                                decoration: CustomInputs.formInputDecoration(
                                    hint: '******',
                                    label: 'Contraseña',
                                    icon: Icons.password),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Campo Requerido*";
                                  } else if (usuarios.controlpassword.text !=
                                      usuarios.controlpassword2.text) {
                                    return "Contraseña no coincide";
                                  }
                                  return null;
                                },
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(50),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: usuarios.controlpassword2,
                                obscureText: true,
                                decoration: CustomInputs.formInputDecoration(
                                    hint: '******',
                                    label: 'Repetir Contraseña',
                                    icon: Icons.password),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Campo Requerido*";
                                  } else if (usuarios.controlpassword.text !=
                                      usuarios.controlpassword2.text) {
                                    return "Contraseña no coincide";
                                  }
                                  return null;
                                },
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(50),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: DataTable(
                    columns: [
                      DataColumn(label: Text("Id")),
                      DataColumn(label: Text("Nombres")),
                      DataColumn(label: Text("Crear")),
                      DataColumn(label: Text("Modificar")),
                      DataColumn(label: Text("Consultar")),
                      DataColumn(label: Text("Anular")),
                    ],
                    rows: permisos.listProyectos.map<DataRow>((e) {
                      return DataRow(cells: [
                        DataCell(Text(e.id.toString())),
                        DataCell(Text(e.nombre.toString())),
                        DataCell(Checkbox(
                          value: e.crear,
                          onChanged: (value) {
                            e.crear = value!;
                            setState(() {});
                          },
                        )),
                        DataCell(Checkbox(
                          value: e.modificar,
                          onChanged: (value) {
                            e.modificar = value!;
                            setState(() {});
                          },
                        )),
                        DataCell(Checkbox(
                          value: e.consultar,
                          onChanged: (value) {
                            e.consultar = value!;
                            setState(() {});
                          },
                        )),
                        DataCell(Checkbox(
                          value: e.anular,
                          onChanged: (value) {
                            e.anular = value!;
                            setState(() {});
                          },
                        )),
                      ]);
                    }).toList()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      final opt = loginFormProvider.validateForm();
                      if (opt) {
                        var usu = await usuarios.saveUser();
                        if (usu != null) {
                          bool val =
                              usuarios.isShowUpdate == "1" ? true : false;
                          await permisos.guardar(usu.id, val);
                          NavigationService.replaceTo("/usuarios");
                        }
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      "Guardar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      usuarios.clearText();
                      permisos.clear();
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
