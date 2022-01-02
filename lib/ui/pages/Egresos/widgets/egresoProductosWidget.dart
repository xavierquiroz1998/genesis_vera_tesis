import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:genesis_vera_tesis/domain/entities/egreso/egresoProducto.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';

class EgresoProductosWidgets {
  static Future<void> openFileEgreso() async {
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
                double totalStock = result.stock! - p.cantidad!;
                Estaticas.listProductos.remove(result);
                result.stock = totalStock;
                Estaticas.listProductos.add(result);
                p.idEgreso = Estaticas.listProductosEgreso.length + 1;
                Estaticas.listProductosEgreso.add(p);
              }
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
}
