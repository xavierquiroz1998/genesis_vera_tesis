import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/ui/Router/FluroRouter.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';

import 'widgets/egresoProductosWidget.dart';

class EgresoProductosView extends StatelessWidget {
  const EgresoProductosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: "Salida de Productos",
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      //style: ButtonStyle(),
                      onPressed: () {
                        NavigationService.navigateTo(Flurorouter.egreso);
                      },
                      child: Text("Nuevo"),
                    ),
                    TextButton(
                        onPressed: () {
                          EgresoProductosWidgets.openFileEgreso(context);
                        },
                        child: Text("Cargar Excel"))
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: DataTable(
                    columns: <DataColumn>[
                      const DataColumn(
                        label: Center(child: Text("Id")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Producto")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Detalle")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Cantidad")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Editar")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Anular")),
                      ),
                    ],
                    rows: Estaticas.listProductosEgreso.map<DataRow>((e) {
                      return DataRow(
                        //key: LocalKey(),
                        cells: <DataCell>[
                          DataCell(
                            Text(e.idEgreso.toString()),
                          ),
                          DataCell(
                            Text(e.idProducto.toString()),
                          ),
                          DataCell(
                            Text(e.detalle!.toString()),
                          ),
                          DataCell(
                            Text(e.cantidad.toString()),
                          ),
                          DataCell(
                            Icon(Icons.edit),
                            onTap: () {},
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
          ),
        ],
      ),
    );
  }
}
