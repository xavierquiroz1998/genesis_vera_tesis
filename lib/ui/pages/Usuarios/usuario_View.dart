import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/providers/Usuarios/UsuariosProvider.dart';
import 'package:genesis_vera_tesis/ui/Router/FluroRouter.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:provider/provider.dart';

class UsuarioView extends StatefulWidget {
  const UsuarioView({Key? key}) : super(key: key);

  @override
  State<UsuarioView> createState() => _UsuarioViewState();
}

class _UsuarioViewState extends State<UsuarioView> {
  @override
  void initState() {
    Provider.of<UsuariosProvider>(context, listen: false).cargaProveedores();
    super.initState();
  }

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
                        DataColumn(label: Text("Expiración")),
                        DataColumn(label: Text("Estado")),
                        DataColumn(label: Text("Acciones")),
                      ],
                      rows: userProvider.listaUsuarios.map<DataRow>((e) {
                        return DataRow(cells: [
                          DataCell(Text(e.id.toString())),
                          DataCell(Text(e.nombre.toString())),
                          DataCell(Text(e.email.toString())),
                          DataCell(Text(e.expiracion.toString())),
                          DataCell(Icon(
                            e.estado ? Icons.check : Icons.dangerous,
                            color: e.estado ? Colors.green : Colors.red,
                          )),
                          DataCell(
                            Row(
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
                                  onTap: () async {
                                    await userProvider.anularUsuario(e);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
