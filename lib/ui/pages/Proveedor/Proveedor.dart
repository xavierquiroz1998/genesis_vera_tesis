import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/providers/Proveedores/proveedoresProvider.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:provider/provider.dart';

class Proveedor extends StatefulWidget {
  const Proveedor({Key? key}) : super(key: key);

  @override
  State<Proveedor> createState() => _ProveedorState();
}

class _ProveedorState extends State<Proveedor> {
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
            title: provee.titulo,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null) {
                      return "Ingrese Numero de Identificación";
                    }
                  },
                  enabled: provee.proveedor.id != 0 ? false : true,
                  controller: provee.controllIdentificacion,
                  decoration: InputDecoration(labelText: "Identificación"),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null) {
                      return "Ingrese Nombres de Proveedor";
                    }
                  },
                  controller: provee.controllNombres,
                  decoration: InputDecoration(labelText: "Nombres"),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null) {
                      return "Ingrese Dirección";
                    }
                  },
                  controller: provee.controllDireccion,
                  decoration: InputDecoration(labelText: "Dirección"),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null) {
                      return "Ingrese Correo";
                    }
                  },
                  controller: provee.controllCorreo,
                  decoration: InputDecoration(labelText: "Correo"),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null) {
                      return "Ingrese Celular";
                    }
                  },
                  controller: provee.controllCelular,
                  decoration: InputDecoration(labelText: "Celular"),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null) {
                      return "Ingrese Tiempo de Holgura";
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(numeros))
                  ],
                  controller: provee.controllTiempoHolgura,
                  decoration: InputDecoration(labelText: "Tiempo de Holgura"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () async {
                          if (await provee.guardar()) {
                            NavigationService.replaceTo("/proveedores");
                          }
                        },
                        child: Text("Guardar")),
                    TextButton(
                        onPressed: () {
                          provee.clear();
                          Navigator.pop(context);
                        },
                        child: Text("Cancelar"))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
