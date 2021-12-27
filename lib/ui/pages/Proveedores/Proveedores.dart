import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:provider/provider.dart';
import 'package:genesis_vera_tesis/ui/Router/FluroRouter.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/Proveedores/Proveedores.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/providers/Proveedores/proveedoresProvider.dart';

class Proveedores extends StatelessWidget {
  const Proveedores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provee = Provider.of<ProveedoresProvider>(context);
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: "Proveedores",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      provee.titulo = "Nuevo Proveedor";
                      provee.proveedor = new ProveedoresEntity();
                      NavigationService.navigateTo(Flurorouter.proveedor);
                    },
                    child: Text("Nuevo Proveedor")),
                DataTable(
                    columns: [
                      DataColumn(label: Text("Identificacion")),
                      DataColumn(label: Text("Nombres")),
                      DataColumn(label: Text("Direccion")),
                      DataColumn(label: Text("Correo")),
                      DataColumn(label: Text("Estado")),
                      DataColumn(label: Text("Editar")),
                      DataColumn(label: Text("Anular")),
                    ],
                    rows: Estaticas.listProveedores.map<DataRow>((e) {
                      return DataRow(cells: [
                        DataCell(Text(e.identificacion.toString())),
                        DataCell(Text(e.nombres.toString())),
                        DataCell(Text(e.direccion.toString())),
                        DataCell(Text(e.correo.toString())),
                        DataCell(Text(e.estado.toString())),
                        DataCell(TextButton(
                          onPressed: () {
                            provee.titulo = "Modificar Proveedor";
                            provee.proveedor = e;
                            NavigationService.navigateTo(Flurorouter.proveedor);
                          },
                          child: Text("Editar"),
                        )),
                        DataCell(TextButton(
                          onPressed: () {
                            provee.proveedor = e;
                            provee.anular();
                          },
                          child: Text("anular"),
                        )),
                      ]);
                    }).toList())
              ],
            ),
          ),
        ],
      ),
    );
  }
}
