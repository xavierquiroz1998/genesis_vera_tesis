import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/ui/Router/FluroRouter.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/registro/entityRegistor.dart';
import '../../../domain/providers/egreso/e_productoProvider.dart';
import 'widgets/egresoProductosWidget.dart';

class EgresoProductosView extends StatefulWidget {
  const EgresoProductosView({Key? key}) : super(key: key);

  @override
  State<EgresoProductosView> createState() => _EgresoProductosViewState();
}

class _EgresoProductosViewState extends State<EgresoProductosView> {
  @override
  void initState() {
    Provider.of<EProductoProvider>(context, listen: false).getRegistrosDev();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final egreso = Provider.of<EProductoProvider>(context);
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
                        egreso.cab = new EntityRegistro();
                        egreso.detalles = [];
                        NavigationService.navigateTo(Flurorouter.egreso);
                      },
                      child: Text("Nuevo Egreso"),
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
                    rows: egreso.listTableRegistrosDev.map<DataRow>((e) {
                      return DataRow(
                        //key: LocalKey(),
                        cells: <DataCell>[
                          DataCell(
                            Text(e.id.toString()),
                          ),
                          DataCell(
                            Text(e.detalle.toString()),
                          ),
                          DataCell(Icon(
                            e.estado ? Icons.check : Icons.dangerous,
                            color: e.estado ? Colors.green : Colors.red,
                          )),
                          DataCell(
                            Icon(Icons.edit),
                            onTap: () async {
                              egreso.cab = e;
                              egreso.detalles = [];
                              NavigationService.navigateTo(
                                  Flurorouter.ingresossCrud);
                            },
                          ),
                          DataCell(
                            Icon(Icons.delete),
                            onTap: () async {
                              await egreso.anular(e);
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
