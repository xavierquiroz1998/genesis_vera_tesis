import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/providers/Proveedores/proveedoresProvider.dart';
import 'package:genesis_vera_tesis/domain/services/codRef.dart';
import 'package:genesis_vera_tesis/ui/style/custom_inputs.dart';
import 'package:genesis_vera_tesis/ui/widgets/toast_notification.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:provider/provider.dart';

class Proveedor extends StatefulWidget {
  const Proveedor({Key? key}) : super(key: key);

  @override
  State<Proveedor> createState() => _ProveedorState();
}

class _ProveedorState extends State<Proveedor> {
  final keyProducto = GlobalKey<FormState>();

  String numeros = r'^(?:\+|-)?\d+$';
  @override
  void initState() {
    var provee = Provider.of<ProveedoresProvider>(context, listen: false);
    if (provee.proveedor.id != 0) {}

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provee = Provider.of<ProveedoresProvider>(context);
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: "Nuevo Proveedor",
            child: Form(
              key: keyProducto,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Ingrese Numero de Identificación";
                      }
                      return null;
                    },
                    enabled: provee.proveedor.id != 0 ? false : true,
                    controller: provee.controllIdentificacion,
                    decoration: CustomInputs.formInputDecoration(
                        hint: "Identificación",
                        icon: Icons.assignment,
                        label: "Identificación"),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Ingrese Nombres de Proveedor";
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(Helper.sololetras),
                      ),
                      LengthLimitingTextInputFormatter(50),
                    ],
                    controller: provee.controllNombres,
                    decoration: CustomInputs.formInputDecoration(
                        hint: "Nombres",
                        icon: Icons.assignment,
                        label: "Nombres"),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Ingrese Dirección";
                      }
                      return null;
                    },
                    controller: provee.controllDireccion,
                    decoration: CustomInputs.formInputDecoration(
                        hint: "Dirección",
                        icon: Icons.assignment,
                        label: "Dirección"),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Ingrese Correo";
                      }
                      return null;
                    },
                    controller: provee.controllCorreo,
                    decoration: CustomInputs.formInputDecoration(
                        hint: "Correo",
                        icon: Icons.assignment,
                        label: "Correo"),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Ingrese Celular";
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(Helper.soloNumeros),
                      ),
                      LengthLimitingTextInputFormatter(10),
                    ],
                    controller: provee.controllCelular,
                    decoration: CustomInputs.formInputDecoration(
                        hint: "Celular",
                        icon: Icons.assignment,
                        label: "Celular"),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Ingrese Tiempo de Holgura (Días)";
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(numeros))
                    ],
                    controller: provee.controllTiempoHolgura,
                    decoration: CustomInputs.formInputDecoration(
                        hint: "Tiempo de Holgura (Días)",
                        icon: Icons.assignment,
                        label: "Tiempo de Holgura (Días)"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () async {
                            if (keyProducto.currentState!.validate()) {
                              if (await provee.guardar()) {
                                NavigationService.replaceTo("/proveedores");
                              }
                            }
                          },
                          child: Text("Guardar")),
                      TextButton(
                          onPressed: () {
                            provee.clear();
                            NavigationService.replaceTo("/proveedores");
                          },
                          child: Text("Cancelar"))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
