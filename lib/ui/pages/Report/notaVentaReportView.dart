import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/registro/entityRegistor.dart';

class NotaVentaView extends StatefulWidget {
  NotaVentaView({Key? key, required this.registro, required this.codRef})
      : super(key: key);
  EntityRegistro registro;
  String codRef;

  @override
  State<NotaVentaView> createState() => _NotaVentaViewState();
}

class _NotaVentaViewState extends State<NotaVentaView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(children: [
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text("Codigo Ref"),
            SizedBox(
              width: 20,
            ),
            Text("NV-${widget.codRef}"),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text("Cliente :"),
            SizedBox(
              width: 20,
            ),
            Text("${widget.registro.fecha}"),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text("Cliente :"),
            SizedBox(
              width: 20,
            ),
            Text("${widget.registro.cliente}"),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text("Observacion : "),
            SizedBox(
              width: 20,
            ),
            Text("${widget.registro.detalle}"),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        DataTable(
          columns: <DataColumn>[
            const DataColumn(
              label: Center(child: Text("Producto")),
            ),
            const DataColumn(
              label: Center(child: Text("Lote")),
            ),
            const DataColumn(
              label: Center(child: Text("cantidad")),
            ),
            const DataColumn(
              label: Center(child: Text(r"$ Precio")),
            ),
            const DataColumn(
              label: Center(child: Text("Total")),
            ),
          ],
          rows: widget.registro.detalles.map<DataRow>((e) {
            return DataRow(cells: <DataCell>[
              DataCell(
                Text("${e.productos.detalle}"),
              ),
              DataCell(
                Text("${e.lote}"),
              ),
              DataCell(
                Text("${e.cantidad}"),
              ),
              DataCell(
                Text("${e.total}"),
              ),
              DataCell(
                Text("${e.to}"),
              ),
            ]);
          }).toList(),
        )
      ]),
    );
  }
}
