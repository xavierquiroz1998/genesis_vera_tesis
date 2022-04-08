import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/services/codRef.dart';
import 'package:genesis_vera_tesis/ui/Router/FluroRouter.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/registro/entityRegistor.dart';
import '../../../domain/providers/ingreso/ingresosProvider.dart';

class IngresosView extends StatefulWidget {
  const IngresosView({Key? key}) : super(key: key);

  @override
  State<IngresosView> createState() => _IngresosViewState();
}

class _IngresosViewState extends State<IngresosView> {
  @override
  void initState() {
    Provider.of<IngresosProvider>(context, listen: false).getRegistrosDev();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ingreso = Provider.of<IngresosProvider>(context);
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: "Nota de Ingreso",
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      //style: ButtonStyle(),
                      onPressed: () {
                        ingreso.cab = new EntityRegistro();
                        ingreso.detalles = [];
                        NavigationService.navigateTo(Flurorouter.ingresossCrud);
                      },
                      child: Text("Nuevo Ingreso"),
                    ),
                    // TextButton(
                    //   onPressed: () {
                    //     // EgresoProductosWidgets.openFileEgreso(context);
                    //   },
                    //   child: Text("Cargar Excel"),
                    // ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: DataTable(
                    columns: <DataColumn>[
                      // const DataColumn(
                      //   label: Center(child: Text("Id")),
                      // ),
                      const DataColumn(
                        label: Center(child: Text("Cod Ref.")),
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
                    rows: ingreso.listTableRegistrosDev.map<DataRow>((e) {
                      return DataRow(
                        //key: LocalKey(),
                        cells: <DataCell>[
                          // DataCell(
                          //   Text(e.id.toString()),
                          // ),
                          DataCell(
                            Text("NV-${Helper.generarTitulo(e.referencia)} "),
                          ),
                          DataCell(Icon(
                            e.estado ? Icons.check : Icons.dangerous,
                            color: e.estado ? Colors.green : Colors.red,
                          )),
                          DataCell(
                            Icon(Icons.edit),
                            onTap: () async {
                              ingreso.cab = e;
                              ingreso.detalles = [];
                              NavigationService.navigateTo(
                                  Flurorouter.ingresossCrud);
                            },
                          ),
                          DataCell(
                            Icon(Icons.delete),
                            onTap: () async {
                              await ingreso.anular(e);
                            },
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
