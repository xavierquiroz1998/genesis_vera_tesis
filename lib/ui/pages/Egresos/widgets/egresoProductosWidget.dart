import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/egreso/egresoProducto.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';

class EgresoProductosWidgets {
  static Future<void> openFileEgreso(BuildContext context) async {
    try {
      EgresoCabecera cabecera = new EgresoCabecera();
      List<EgresoDetalle> listEgresoTemp = [];
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
            var detalle = row[1]!.value;
            var cantidad = row[2]!.value;
            var precio = row[3]!.value;
            var total = row[3]!.value;
            // valida encabezado
            if (codigo.toString() != "codigo productos") {
              //falta agregar validacion de los demas campos
              EgresoDetalle p = new EgresoDetalle(
                idProducto: int.parse(codigo.toString()),
                detalle: detalle.toString(),
                cantidad: int.parse(cantidad.toString()),
                precio: double.parse(precio.toString()),
                total: double.parse(total.toString()),
              );

              var result = Estaticas.listProductos
                  .firstWhere((e) => e.id == p.idProducto);
              if (result.id! > 0) {
                listEgresoTemp.add(p);
              }
            }
          }
        }
        if (listEgresoTemp.length > 0) {
          cabecera.detalle = listEgresoTemp;
          await dialogProductos(context, cabecera);
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

  static Future<void> dialogProductos(
      BuildContext context, EgresoCabecera temp) async {
    final size = MediaQuery.of(context).size;
    try {
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
                        label: Center(child: Text("Producto")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Detalle")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Cantidad")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Precio")),
                      ),
                    ],
                    rows: temp.detalle!.map<DataRow>((e) {
                      return DataRow(
                        //key: LocalKey(),
                        cells: <DataCell>[
                          DataCell(
                            Text(e.idProducto.toString()),
                          ),
                          DataCell(
                            Text(e.detalle!.toString()),
                          ),
                          DataCell(
                            Text(e.cantidad.toString()),
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
                    int sec = 0;
                    for (var value in temp.detalle!) {
                      var result = Estaticas.listProductos
                          .firstWhere((e) => e.id == value.idProducto);
                      double totalStock = result.stock! - value.cantidad;
                      Estaticas.listProductos.remove(result);
                      result.stock = totalStock;
                      Estaticas.listProductos.add(result);
                      value.idEgresoDetalle = value.secuencia = sec++;
                    }
                    temp.idEgreso = Estaticas.listProductosEgreso.length + 1;
                    Estaticas.listProductosEgreso.add(temp);
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
}
