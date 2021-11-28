import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
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
            // SfDataGrid(
            //     source: egreso.employeeDataSource,
            //     allowEditing: true,
            //     columnWidthMode: ColumnWidthMode.none,
            //     columns: <GridColumn>[
            //       GridColumn(
            //           columnName: 'id',
            //           label: Container(
            //               padding: EdgeInsets.all(16.0),
            //               alignment: Alignment.center,
            //               child: Text(
            //                 'ID',
            //               ))),
            //       GridColumn(
            //           columnName: 'name',
            //           label: Container(
            //               padding: EdgeInsets.all(8.0),
            //               alignment: Alignment.center,
            //               child: Text('Name'))),
            //       GridColumn(
            //           columnName: 'designation',
            //           label: Container(
            //               padding: EdgeInsets.all(8.0),
            //               alignment: Alignment.center,
            //               child: Text(
            //                 'Designation',
            //                 overflow: TextOverflow.ellipsis,
            //               ))),
            //       GridColumn(
            //           columnName: 'salary',
            //           label: Container(
            //               padding: EdgeInsets.all(8.0),
            //               alignment: Alignment.center,
            //               child: Text('Salary'))),
            //       GridColumn(
            //           columnName: 'edit',
            //           label: Container(
            //               padding: EdgeInsets.all(8.0),
            //               alignment: Alignment.center,
            //               child: Text(''))),
            //     ]),

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
                      DropdownButton<Productos>(
                        items: Estaticas.listProductos
                            .map(
                              (e) => DropdownMenuItem<Productos>(
                                child: Text(e.descripcion!),
                                value: new Productos(precio: 0),
                              ),
                            )
                            .toList(),
                        onChanged: (prod) {},
                        //value: new Productos(precio: 0),
                        hint: Text("funciona?"),
                      ),
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

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text("Guardar"),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("Cancelar"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
