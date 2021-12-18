import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/providers/Proveedores/proveedoresProvider.dart';
import 'package:provider/provider.dart';

class Proveedor extends StatelessWidget {
  const Proveedor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provee = Provider.of<ProveedoresProvider>(context);
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Center(child: Text("Proveedor")),
                  TextFormField(
                    onChanged: (value) {
                      provee.proveedor.identificacion = value;
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Ingrese Numero de Identificacion";
                      }
                    },
                    decoration: InputDecoration(labelText: "Identificacion"),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      provee.proveedor.nombres = value;
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Ingrese Nombres de Proveedor";
                      }
                    },
                    decoration: InputDecoration(labelText: "Nombres"),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      provee.proveedor.direccion = value;
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Ingrese Direccion";
                      }
                    },
                    decoration: InputDecoration(labelText: "Direccion"),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      provee.proveedor.correo = value;
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Ingrese Correo";
                      }
                    },
                    decoration: InputDecoration(labelText: "Correo"),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      provee.proveedor.celular = value;
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Ingrese Celular";
                      }
                    },
                    decoration: InputDecoration(labelText: "Celular"),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      provee.guardar(context);
                    },
                    child: Text("Guardar")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancelar"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
