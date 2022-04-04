import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/kardex/kardex.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ItemsDataSource extends DataGridSource {
  final List<Kardex> listProducts;
  final BuildContext context;
  List<DataGridRow> dataGridRows = [];

  ItemsDataSource(this.listProducts, this.context) {
    buildDataGridRow();
  }

  void buildDataGridRow() {
    dataGridRows = listProducts.map<DataGridRow>((Kardex product) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(columnName: 'codigo', value: product.codMov),
        DataGridCell<String>(
            columnName: 'producto', value: "${product.idProducto}"),
        DataGridCell<double>(
            columnName: 'cantidadI',
            value: double.parse(product.proCanI.toString())),
        DataGridCell<double>(columnName: 'costoI', value: product.proUntI),
        DataGridCell<double>(columnName: 'totalI', value: product.proTtlI),
        DataGridCell<double>(
            columnName: 'cantidadS',
            value: double.parse(product.proCanS.toString())),
        DataGridCell<double>(columnName: 'costoS', value: product.proUntS),
        DataGridCell<double>(columnName: 'totalS', value: product.proTtlS),
        DataGridCell<double>(
            columnName: 'cantidadE',
            value: double.parse(product.proCanE.toString())),
        DataGridCell<double>(columnName: 'costoE', value: product.proUntE),
        DataGridCell<double>(columnName: 'totalE', value: product.proTtlE)
      ]);
    }).toList(growable: false);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        constraints: BoxConstraints(maxWidth: 100, minWidth: 70),
        alignment: Alignment.centerLeft,
        child: Tooltip(
          message: row.getCells()[0].value.toString(),
          child: Text(
            row.getCells()[0].value.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
      Container(
        constraints: BoxConstraints(maxWidth: 100, minWidth: 70),
        alignment: Alignment.centerLeft,
        child: Tooltip(
          message: row.getCells()[1].value.toString(),
          child: Text(
            row.getCells()[1].value.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerRight,
        child: Text(
          NumberFormat.currency(locale: 'en_US', symbol: r'$', decimalDigits: 2)
              .format(row.getCells()[2].value),
          style: TextStyle(fontSize: 12),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerRight,
        child: Text(
          NumberFormat.currency(locale: 'en_US', symbol: r'$', decimalDigits: 2)
              .format(row.getCells()[3].value),
          style: TextStyle(fontSize: 12),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerRight,
        child: Text(
          NumberFormat.currency(locale: 'en_US', symbol: r'$', decimalDigits: 2)
              .format(row.getCells()[4].value),
          style: TextStyle(fontSize: 12),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerRight,
        child: Text(
          NumberFormat.currency(locale: 'en_US', symbol: r'$', decimalDigits: 2)
              .format(row.getCells()[5].value),
          style: TextStyle(fontSize: 12),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerRight,
        child: Text(
          NumberFormat.currency(locale: 'en_US', symbol: r'$', decimalDigits: 2)
              .format(row.getCells()[6].value),
          style: TextStyle(fontSize: 12),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerRight,
        child: Text(
          NumberFormat.currency(locale: 'en_US', symbol: r'$', decimalDigits: 2)
              .format(row.getCells()[7].value),
          style: TextStyle(fontSize: 12),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerRight,
        child: Text(
          NumberFormat.currency(locale: 'en_US', symbol: r'$', decimalDigits: 2)
              .format(row.getCells()[8].value),
          style: TextStyle(fontSize: 12),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerRight,
        child: Text(
          NumberFormat.currency(locale: 'en_US', symbol: r'$', decimalDigits: 2)
              .format(row.getCells()[9].value),
          style: TextStyle(fontSize: 12),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerRight,
        child: Text(
          NumberFormat.currency(locale: 'en_US', symbol: r'$', decimalDigits: 2)
              .format(row.getCells()[10].value),
          style: TextStyle(fontSize: 12),
        ),
      ),
    ]);
  }
}
