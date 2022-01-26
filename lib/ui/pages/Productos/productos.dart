import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/providers/productosProvider.dart';
import 'package:genesis_vera_tesis/ui/Router/FluroRouter.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:provider/provider.dart';

class ProductosTable extends StatelessWidget {
  const ProductosTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final producto = Provider.of<ProductosProvider>(context);
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: "Ingreso Productos",
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      //style: ButtonStyle(),
                      onPressed: () {
                        producto.product = new Productos(precio: 0);
                        NavigationService.navigateTo(Flurorouter.ingreso);
                      },
                      child: Text("Nuevo"),
                    ),
                    TextButton(
                        onPressed: () => openFile(context),
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
                            onTap: () {
                              producto.product = e;
                              NavigationService.navigateTo(Flurorouter.ingreso);
                            },
                          ),
                          DataCell(
                            Icon(Icons.delete),
                            onTap: () {},
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

Future<void> dialogProductos(BuildContext context, List<Productos> temp) async {
  try {
    final size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Productos"),
          content: Container(
            width: size.width / 2,
            height: size.height / 3,
            child: ListView(
              children: [
                DataTable(
                  columns: <DataColumn>[
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
                  ],
                  rows: temp.map<DataRow>((e) {
                    return DataRow(
                      //key: LocalKey(),
                      cells: <DataCell>[
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
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  for (var value in temp) {
                    value.id = Estaticas.listProductos.length + 1;
                    Estaticas.listProductos.add(value);
                  }
                  Navigator.pop(context);
                },
                child: Text("Guardar")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancelar")),
          ],
        );
      },
    );
  } catch (e) {
    print("${e.toString()}");
  }
}

Future<void> openFile(BuildContext context) async {
  try {
    List<Productos> listProductosTemp = [];
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['xlsx']);

    if (result != null) {
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
          var unidad = row[4]!.value;
          var tipo = row[5]!.value;
          // valida encabezado
          if (codigo.toString() != "codigo") {
            // falta agregar validacion de los demas campos
            Productos p = new Productos(
                codigo: codigo.toString(),
                descripcion: descripcion.toString(),
                stock: double.tryParse(stock.toString()),
                precio: double.parse(precio.toString()),
                unidadMedida: Estaticas.unidades
                    .firstWhere((e) => e.codigo == unidad.toString())
                    .id,
                tipoProdcuto: tipo.toString());

            listProductosTemp.add(p);
          }
        }
      }
      if (listProductosTemp.length > 0) {
        await dialogProductos(context, listProductosTemp);
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
