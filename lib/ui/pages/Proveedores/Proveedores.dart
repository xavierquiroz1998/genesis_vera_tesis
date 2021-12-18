import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';

class Proveedores extends StatelessWidget {
  const Proveedores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          TextButton(onPressed: () {}, child: Text("Nuevo Proveedor")),
          DataTable(
              columns: [
                DataColumn(label: Text("Identificacion")),
                DataColumn(label: Text("Nombres")),
                DataColumn(label: Text("Direccion")),
                DataColumn(label: Text("Correo")),
              ],
              rows: Estaticas.listProveedores.map<DataRow>((e) {
                return DataRow(cells: [
                  DataCell(Text(e.identificacion.toString())),
                  DataCell(Text(e.nombres.toString())),
                  DataCell(Text(e.direccion.toString())),
                  DataCell(Text(e.correo.toString())),
                ]);
              }).toList())
        ],
      ),
    );
  }
}
