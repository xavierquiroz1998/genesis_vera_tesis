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

  List<EgresoDetalle> get listaProducto => _listPRoduct;

  set _listaProductoSet(List<EgresoDetalle> lista) {
    _listPRoduct = lista;
    notifyListeners();
  }

  void agregar() {
    listaProducto.add(new EgresoDetalle());
    employeeDataSource = EmployeeDataSource(employeeData: listaProducto);
    notifyListeners();
  }

  void remover(EgresoDetalle e) {
    listaProducto.remove(e);
    notifyListeners();
  }
}

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
        //onChanged: (prod) {},
        value: new Productos(precio: 0),
        hint: Text("funciona?"),
      ),
      TextField(),
      Text(""),
      Text(""),
      Icon(Icons.delete)
    ]);
  }
}
