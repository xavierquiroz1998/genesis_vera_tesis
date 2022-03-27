import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/providers/Proveedores/proveedoresProvider.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:provider/provider.dart';

class Proveedor extends StatelessWidget {
  const Proveedor({Key? key}) : super(key: key);

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
                      return "Ingrese Numero de Identificacion";
                    }
                  },
                  enabled: provee.proveedor.id != 0 ? false : true,
                  controller: provee.controllIdentificacion,
                  decoration: InputDecoration(labelText: "Identificacion"),
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
                      return "Ingrese Direccion";
                    }
                  },
                  controller: provee.controllDireccion,
                  decoration: InputDecoration(labelText: "Direccion"),
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
                // TextFormField(
                //   validator: (value) {
                //     if (value == null) {
                //       return "Ingrese Holgura";
                //     }
                //   },
                //   controller: provee.controllCelular,
                //   decoration: InputDecoration(labelText: "Holgura"),
                // ),
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
