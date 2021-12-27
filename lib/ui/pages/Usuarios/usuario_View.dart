import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/ui/Router/FluroRouter.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';

class UsuarioView extends StatelessWidget {
  const UsuarioView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: "Usuarios",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      NavigationService.navigateTo(Flurorouter.usuario);
                    },
                    child: Text("Nuevo")),
                Container(
                  width: double.infinity,
                  child: DataTable(
                      columns: [
                        DataColumn(label: Text("Id")),
                        DataColumn(label: Text("Nombres")),
                        DataColumn(label: Text("Correo")),
                        DataColumn(label: Text("Celular")),
                        DataColumn(label: Text("Estado")),
                        DataColumn(label: Text("Editar")),
                      ],
                      rows: Estaticas.listUsuarios.map<DataRow>((e) {
                        return DataRow(cells: [
                          DataCell(Text(e.idUsuario.toString())),
                          DataCell(Text(e.nombres.toString())),
                          DataCell(Text(e.correo.toString())),
                          DataCell(Text(e.celular.toString())),
                          DataCell(Text(e.estado.toString())),
                          DataCell(TextButton(
                              onPressed: () {}, child: Text("Editar"))),
                        ]);
                      }).toList()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
