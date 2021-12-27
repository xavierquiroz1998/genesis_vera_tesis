import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/unidad_medida/unidadMedida.dart';
import 'package:genesis_vera_tesis/domain/providers/unidadMedida/unidadProvider.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:provider/provider.dart';
import 'Widget/unidadWidget.dart';

class UnidadMedidaView extends StatelessWidget {
  const UnidadMedidaView({Key? key}) : super(key: key);

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
                      onPressed: () {
                        unidadP.unidad = new UnidadMedida();
                        UnidadWidget.dialogoUnidad(context);
                      },
                      child: Text("Nuevo")),
                  Container(
                    width: double.infinity,
                    child: DataTable(
                        columns: [
                          DataColumn(label: Text("Id")),
                          DataColumn(label: Text("Codigo")),
                          DataColumn(label: Text("Descripcion")),
                          DataColumn(label: Text("Estado")),
                          DataColumn(label: Text("Editar")),
                        ],
                        rows: unidadP.unidades.map<DataRow>((e) {
                          return DataRow(cells: [
                            DataCell(Text(e.id.toString())),
                            DataCell(Text(e.codigo.toString())),
                            DataCell(Text(e.descripcion.toString())),
                            DataCell(Text(e.estado.toString())),
                            DataCell(TextButton(
                                onPressed: () {
                                  unidadP.unidad = e;
                                  UnidadWidget.dialogoUnidad(context);
                                },
                                child: Text("Editar"))),
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
