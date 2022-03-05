import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/providers/Usuarios/UsuariosProvider.dart';
import 'package:genesis_vera_tesis/ui/Router/FluroRouter.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:provider/provider.dart';

class UsuarioView extends StatelessWidget {
  const UsuarioView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsuariosProvider>(context);
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
                        DataColumn(label: Text("Acciones")),
                      ],
                      rows: Estaticas.listUsuarios.map<DataRow>((e) {
                        return DataRow(cells: [
                          DataCell(Text(e.idUsuario.toString())),
                          DataCell(Text(e.nombres.toString())),
                          DataCell(Text(e.correo.toString())),
                          DataCell(Text(e.celular.toString())),
                          DataCell(Text(e.estado.toString())),
                          DataCell(Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  userProvider.fillText(e);
                                  NavigationService.navigateTo(
                                      Flurorouter.usuario);
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                              InkWell(
                                  onTap: () => userProvider.deleteUser(e),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ))
                            ],
                          )),
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
