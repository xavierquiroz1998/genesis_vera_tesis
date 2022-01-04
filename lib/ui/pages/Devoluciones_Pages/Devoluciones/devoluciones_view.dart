import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/entities/Devoluciones/devolucion_cab.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/providers/Devoluciones/devolucionProvider.dart';
import 'package:genesis_vera_tesis/ui/Router/FluroRouter.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:provider/provider.dart';

class DevolucionesView extends StatelessWidget {
  const DevolucionesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final devolucio = Provider.of<DevolucionProvider>(context);
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: "Devoluciones",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      devolucio.cab = new DevolucionCab();
                      NavigationService.navigateTo(Flurorouter.devolucion);
                    },
                    child: Text("Nueva Devolucion")),
                Container(
                  width: double.infinity,
                  child: DataTable(
                    columns: <DataColumn>[
                      const DataColumn(
                        label: Center(child: Text("Id")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Observacion")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Estado")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Editar")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Anular")),
                      ),
                    ],
                    rows: Estaticas.listDevoluciones.map<DataRow>((e) {
                      return DataRow(
                        //key: LocalKey(),
                        cells: <DataCell>[
                          DataCell(
                            Text(e.idDevolucion.toString()),
                          ),
                          DataCell(
                            Text(e.observacion.toString()),
                          ),
                          DataCell(
                            Text(e.estado!.toString()),
                          ),
                          DataCell(
                            Icon(Icons.edit),
                            onTap: () {
                              devolucio.cab = e;
                              NavigationService.navigateTo(
                                  Flurorouter.devolucion);
                            },
                          ),
                          DataCell(
                            Icon(Icons.delete),
                            onTap: () {},
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
