import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/providers/unidadMedida/unidadProvider.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/unidad_medida/unidadMedida.dart';
import 'Widget/unidadWidget.dart';

class UnidadMedidaView extends StatefulWidget {
  const UnidadMedidaView({Key? key}) : super(key: key);

  @override
  State<UnidadMedidaView> createState() => _UnidadMedidaViewState();
}

class _UnidadMedidaViewState extends State<UnidadMedidaView> {
  @override
  void initState() {
    Provider.of<UnidadMedidaProvider>(context, listen: false).callgetMedidas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final unidadP = Provider.of<UnidadMedidaProvider>(context);
    return Container(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          WhiteCard(
              title: "Unidad Medida",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () async {
                        //unidadP.callgetMedidas();
                        unidadP.unidad = new UnidadMedidaEntity();
                        UnidadWidget.dialogoUnidad(context);
                      },
                      child: Text("Nuevo")),
                  Container(
                    width: double.infinity,
                    child: DataTable(
                        columns: [
                          DataColumn(label: Text("Id")),
                          DataColumn(label: Text("Código")),
                          DataColumn(label: Text("Descripción")),
                          DataColumn(label: Text("Estado")),
                          DataColumn(label: Text("Acciones")),
                          // DataColumn(label: Text("Anular")),
                        ],
                        rows: unidadP.listUnidad.map<DataRow>((e) {
                          return DataRow(cells: [
                            DataCell(Text(e.id.toString())),
                            DataCell(Text(e.codigo.toString())),
                            DataCell(Text(e.detalle.toString())),
                            DataCell(Icon(
                              e.estado ? Icons.check : Icons.dangerous,
                              color: e.estado ? Colors.green : Colors.red,
                            )),
                            DataCell(
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      unidadP.unidad = e;
                                      UnidadWidget.dialogoUnidad(context);
                                    },
                                    child: Icon(Icons.edit),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      unidadP.unidad = e;
                                      await unidadP.anular();
                                    },
                                    child: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ),
                          ]);
                        }).toList()),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
