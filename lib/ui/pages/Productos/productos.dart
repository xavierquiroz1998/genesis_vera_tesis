import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/ui/pages/Producto/productoCrud.dart';

class ProductosTable extends StatefulWidget {
  const ProductosTable({Key? key}) : super(key: key);

  @override
  _ProductosState createState() => _ProductosState();
}

class _ProductosState extends State<ProductosTable> {
  @override
  void initState() {
    super.initState();
    if (Estaticas.listProductos.length == 0) {
      cargarLista();
    }
  }

  void cargarLista() {
    for (int i = 0; i < 3; i++) {
      Estaticas.listProductos.add(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  //style: ButtonStyle(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductoCrud(),
                      ),
                    );
                  },
                  child: Text("Nuevo"),
                ),
              ],
            ),
            DataTable(
              columns: <DataColumn>[
                const DataColumn(
                  label: Center(child: Text("Id")),
                ),
                const DataColumn(
                  label: Center(child: Text("Codigo")),
                ),
                const DataColumn(
                  label: Center(child: Text("Descripcion")),
                ),
                const DataColumn(
                  label: Center(child: Text("Stock")),
                ),
                const DataColumn(
                  label: Center(child: Text("Precio")),
                ),
                const DataColumn(
                  label: Center(child: Text("Editar")),
                ),
                const DataColumn(
                  label: Center(child: Text("Anular")),
                ),
              ],
              rows: Estaticas.listProductos.map<DataRow>((e) {
                return DataRow(
                  //key: LocalKey(),
                  cells: <DataCell>[
                    DataCell(
                      Text(e.id.toString()),
                    ),
                    DataCell(
                      Text(e.codigo.toString()),
                    ),
                    DataCell(
                      Text(e.descripcion!),
                    ),
                    DataCell(
                      Text(e.stock.toString()),
                    ),
                    DataCell(
                      Text(e.precio.toString()),
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
          ],
        ),
      ),
    );
  }
}
