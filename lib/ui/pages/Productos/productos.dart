import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';

class ProductosTable extends StatefulWidget {
  const ProductosTable({Key? key}) : super(key: key);

  @override
  _ProductosState createState() => _ProductosState();
}

class _ProductosState extends State<ProductosTable> {
  List<Productos> productos = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      productos.add(
        new Productos(id: i, descripcion: "Prod$i", stock: i + 50, precio: 1),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ListView(
          children: [
            TextButton(
              onPressed: () {},
              child: Text("Nuevo"),
            ),
            DataTable(
              columns: <DataColumn>[
                const DataColumn(
                  label: Text("Id"),
                ),
                const DataColumn(
                  label: Text("Descripcion"),
                ),
                const DataColumn(
                  label: Text("Stock"),
                ),
              ],
              rows: productos.map<DataRow>((e) {
                return DataRow(
                  //key: LocalKey(),
                  cells: <DataCell>[
                    DataCell(
                      Text(e.id.toString()),
                    ),
                    DataCell(
                      Text(e.descripcion!),
                    ),
                    DataCell(
                      Text(e.stock.toString()),
                    ),
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
