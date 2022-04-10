import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/entities/Devoluciones/devolucion_cab.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/providers/Devoluciones/devolucionProvider.dart';
import 'package:genesis_vera_tesis/domain/services/codRef.dart';
import 'package:genesis_vera_tesis/ui/Router/FluroRouter.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:provider/provider.dart';

import '../../../../domain/entities/registro/entityRegistor.dart';

class DevolucionesView extends StatefulWidget {
  const DevolucionesView({Key? key}) : super(key: key);

  @override
  State<DevolucionesView> createState() => _DevolucionesViewState();
}

class _DevolucionesViewState extends State<DevolucionesView> {
  @override
  void initState() {
    Provider.of<DevolucionProvider>(context, listen: false)
        .getRegistrosDevPRes(3);
    super.initState();
  }

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
                      devolucio.cab = new EntityRegistro();
                      devolucio.ctrObservacion.text = "";
                      devolucio.detalles = [];
                      NavigationService.navigateTo(Flurorouter.devolucion);
                    },
                    child: Text("Nueva Devolución")),
                Container(
                  width: double.infinity,
                  child: DataTable(
                    columns: <DataColumn>[
                      const DataColumn(
                        label: Center(child: Text("Fecha")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Codido Ref")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Estado")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Acciones")),
                      ),
                      // const DataColumn(
                      //   label: Center(child: Text("Anular")),
                      // ),
                    ],
                    rows: devolucio.listTableRegistrosDev.map<DataRow>((e) {
                      return DataRow(
                        //key: LocalKey(),
                        cells: <DataCell>[
                          DataCell(
                            Text(e.fecha),
                          ),
                          DataCell(Text(e.cliente == "P"
                              ? "Dev / pr-${Helper.generarTitulo(e.referencia).toString()}"
                              : "Dev / cl-${Helper.generarTitulo(e.referencia).toString()}")),
                          DataCell(Icon(
                            e.estado ? Icons.check : Icons.dangerous,
                            color: e.estado ? Colors.green : Colors.red,
                          )),
                          DataCell(
                            Row(
                              children: [
                                TextButton.icon(
                                  label: Text(""),
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    devolucio.cab = e;
                                    devolucio.detalles = [];
                                    NavigationService.navigateTo(
                                        Flurorouter.devolucion);
                                  },
                                ),
                                TextButton.icon(
                                  label: Text(""),
                                  icon: Icon(Icons.delete),
                                  onPressed: () async {
                                    await devolucio.anular(e);
                                  },
                                ),
                              ],
                            ),
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
