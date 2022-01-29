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
        DataGridCell<String>(columnName: 'codigo', value: product.codPro),
        DataGridCell<String>(columnName: 'producto', value: product.nomPro),
        DataGridCell<double>(columnName: 'cantidad', value: product.proCan),
        DataGridCell<double>(columnName: 'precio u.', value: product.proUnt),
        DataGridCell<double>(columnName: 'precio t.', value: product.proTtl)
      ]);
    }).toList(growable: false);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.centerLeft,
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(fontSize: 12),
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
        constraints: BoxConstraints(maxWidth: 100, minWidth: 70),
        alignment: Alignment.centerLeft,
        child: Tooltip(
          message: row.getCells()[2].value.toString(),
          child: Text(
            row.getCells()[2].value.toString(),
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
              .format(row.getCells()[3].value),
          style: TextStyle(fontSize: 12),
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
          row.getCells()[5].value.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: row.getCells()[5].value.toString() == 'U'
                ? Colors.red
                : Colors.green,
          ),
        ),
      ),
    ]);
  }
}
