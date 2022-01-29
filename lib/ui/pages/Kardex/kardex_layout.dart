import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/ui/pages/items_source.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class KardexLayout extends StatelessWidget {
  const KardexLayout({Key? key}) : super(key: key);

  List<GridColumn> _getColumns() {
    List<GridColumn> columns;
    columns = <GridColumn>[
      GridColumn(
          columnName: 'customerName',
          width: 180,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Customer Name',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'city',
          width: 140,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'City',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'orderId',
          width: 140,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Order ID',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'orderDate',
          width: 140,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Order Date',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'product',
          width: 160,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Product',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'productId',
          width: 150,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Product ID',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'quantity',
          width: 150,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Quantity',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'unitPrice',
          width: 140,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Unit Price',
              overflow: TextOverflow.ellipsis,
            ),
          )),
    ];
    return columns;
  }

  Color _getHeaderCellBackgroundColor() {
    return const Color(0xFF3A3A3A);
  }

  Widget _getWidgetForStackedHeaderCell(String title) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Text(title));
  }

  List<StackedHeaderRow> _getStackedHeaderRows() {
    List<StackedHeaderRow> _stackedHeaderRows;
    _stackedHeaderRows = <StackedHeaderRow>[
      StackedHeaderRow(cells: <StackedHeaderCell>[
        StackedHeaderCell(
            columnNames: <String>['customerName', 'city', 'city'],
            child: _getWidgetForStackedHeaderCell('ENTRADAS')),
        StackedHeaderCell(
            columnNames: <String>['orderId', 'orderDate', 'orderDate'],
            child: _getWidgetForStackedHeaderCell('SALIDAS')),
        StackedHeaderCell(
            columnNames: <String>['product', 'productId', 'quantity'],
            child: _getWidgetForStackedHeaderCell('EXISTENCIA'))
      ])
    ];
    return _stackedHeaderRows;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: "Kardex",
            child: Column(
              children: [
                SfDataGrid(
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                  source: ItemsDataSource([], context),
                  columns: _getColumns(),
                  stackedHeaderRows: _getStackedHeaderRows(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
