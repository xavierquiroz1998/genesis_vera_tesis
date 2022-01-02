import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/egreso/egresoProducto.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class EProductoProvider extends ChangeNotifier {
  List<EgresoDetalle> _listPRoduct = [];
  late EmployeeDataSource employeeDataSource =
      EmployeeDataSource(employeeData: listaProducto);
  Productos _prd = new Productos(precio: 0);

  Productos get prd => _prd;

  set prd(Productos prd) {
    _prd = prd;
    notifyListeners();
  }

  List<EgresoDetalle> get listaProducto => _listPRoduct;

  void agregar() {
    listaProducto.add(new EgresoDetalle());
    employeeDataSource = EmployeeDataSource(employeeData: listaProducto);
    notifyListeners();
  }

  void remover(EgresoDetalle e) {
    listaProducto.remove(e);
    notifyListeners();
  }

  Future<void> guardarEgreso() async {
    try {
      for (var item in listaProducto) {
        var result =
            Estaticas.listProductos.firstWhere((e) => e.id == item.idProducto);
        if (result.id! > 0) {
          double totalStock = result.stock! - item.cantidad!;
          Estaticas.listProductos.remove(result);
          result.stock = totalStock;
          Estaticas.listProductos.add(result);
          item.idEgreso = Estaticas.listProductosEgreso.length + 1;
          Estaticas.listProductosEgreso.add(item);
        }
      }
    } catch (e) {
      print("Error en guardar ${e.toString()}");
    }
  }
}

// prueba
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<EgresoDetalle> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.idProducto),
              DataGridCell<String>(columnName: 'name', value: e.detalle),
              DataGridCell<int>(columnName: 'designation', value: e.cantidad),
              DataGridCell<double>(columnName: 'salary', value: e.precio),
              DataGridCell<String>(columnName: 'salary', value: ""),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      DropdownButton<Productos>(
        items: Estaticas.listProductos
            .map(
              (e) => DropdownMenuItem<Productos>(
                child: Text(e.descripcion!),
              ),
            )
            .toList(),
        onChanged: (prod) {},
        //value: new Productos(precio: 0),
        hint: Text("funciona?"),
      ),
      TextField(),
      Text(""),
      Text(""),
      Icon(Icons.delete)
    ]);
  }
}
