import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              TextButton(
                  onPressed: () => openFile(), child: Text("Cargar Excel"))
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
    );
  }
}

Future<void> openFile() async {
  try {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['xlsx']);

    // String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (result != null) {
      //file = File(result.files.first.path!);
      var bytesData = result.files.first.bytes;
      var excel = Excel.decodeBytes(bytesData!);

      for (var item in excel.tables.keys) {
        print(item);
        print(excel.tables[item]!.maxCols);
        print(excel.tables[item]!.maxRows);
        for (var row in excel.tables[item]!.rows) {
          var codigo = row[0]!.value;
          var descripcion = row[1]!.value;
          var stock = row[2]!.value;
          var precio = row[3]!.value;
          // valida encabezado
          if (codigo.toString() != "codigo") {
            // falta agregar validacion de los demas campos
            Productos p = new Productos(
                codigo: codigo.toString(),
                descripcion: descripcion.toString(),
                stock: int.parse(stock.toString()),
                precio: double.parse(precio.toString()));
            p.id = Estaticas.listProductos.length + 1;
            Estaticas.listProductos.add(p);
          }
        }
      }
    } else {
      // User canceled the picker
    }
    //final _result = await OpenFile.open(filePath);
    //print(_result.message);

  } catch (e) {
    print("erro en open file ${e.toString()}");
  }
}
