import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/providers/egreso/e_productoProvider.dart';
import 'package:provider/provider.dart';

class EgresoProducto extends StatelessWidget {
  const EgresoProducto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final egreso = Provider.of<EProductoProvider>(context);
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Cliente"),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Observacion"),
            ),
            TextButton(
              onPressed: () {
                egreso.agregar();
              },
              child: Text("Agregar"),
            ),
            DataTable(
              columns: <DataColumn>[
                const DataColumn(
                  label: Center(child: Text("Producto")),
                ),
                const DataColumn(
                  label: Center(child: Text("observacion")),
                ),
                const DataColumn(
                  label: Center(child: Text("cantidad")),
                ),
                const DataColumn(
                  label: Center(child: Text("Precio")),
                ),
                const DataColumn(
                  label: Center(child: Text("Total")),
                ),
                const DataColumn(
                  label: Center(child: Text("")),
                ),
              ],
              rows: egreso.listaProducto.map<DataRow>((e) {
                return DataRow(
                  //key: LocalKey(),
                  cells: <DataCell>[
                    DataCell(
                      Text(e.idProducto.toString()),
                    ),
                    DataCell(
                      Text(e.detalle.toString()),
                    ),
                    DataCell(
                      TextFormField(
                        onChanged: (value) {
                          e.cantidad = int.parse(value);
                        },
                      ),
                    ),
                    DataCell(
                      TextFormField(
                        onChanged: (value) {
                          e.precio = double.parse(value);
                          e.total = e.cantidad! * e.precio!;
                        },
                      ),
                    ),
                    DataCell(
                      Text(e.total.toString()),
                    ),
                    DataCell(Icon(Icons.delete), onTap: () {
                      egreso.remover(e);
                    }),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
