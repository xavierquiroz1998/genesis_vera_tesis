import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';

class UnidadMedidaView extends StatelessWidget {
  const UnidadMedidaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          TextButton(onPressed: () {}, child: Text("Nuevo")),
          DataTable(
              columns: [
                DataColumn(label: Text("Id")),
                DataColumn(label: Text("Codigo")),
                DataColumn(label: Text("Descripcion")),
                DataColumn(label: Text("Estado")),
              ],
              rows: Estaticas.unidades.map<DataRow>((e) {
                return DataRow(cells: [
                  DataCell(Text(e.id.toString())),
                  DataCell(Text(e.codigo.toString())),
                  DataCell(Text(e.descripcion.toString())),
                  DataCell(Text(e.estado.toString())),
                ]);
              }).toList())
        ],
      ),
    );
  }
}
