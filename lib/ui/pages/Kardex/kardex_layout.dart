// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/providers/kardex/kardex_provider.dart';
import 'package:genesis_vera_tesis/ui/pages/items_source.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../domain/entities/productos.dart';

class KardexLayout extends StatefulWidget {
  const KardexLayout({Key? key}) : super(key: key);

  @override
  State<KardexLayout> createState() => _KardexLayoutState();
}

class _KardexLayoutState extends State<KardexLayout> {
  List<GridColumn> _getColumns() {
    List<GridColumn> columns;
    columns = <GridColumn>[
      GridColumn(
          columnName: 'Fecha',
          width: 85,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Fecha',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )),
      GridColumn(
          columnName: 'Codigo',
          width: 85,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'cod-mov',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )),
      GridColumn(
          columnName: 'Promedio',
          width: 85,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Promedio',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )),
      GridColumn(
          columnName: 'cantidadI',
          width: 85,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Cantidad',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )),
      GridColumn(
          columnName: 'costoI',
          width: 85,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Cost.Unit',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )),
      GridColumn(
          columnName: 'totalI',
          width: 85,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Total',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )),
      GridColumn(
          columnName: 'cantidadS',
          width: 85,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Cantidad',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )),
      GridColumn(
          columnName: 'costoS',
          width: 85,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Cost.Unit',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )),
      GridColumn(
          columnName: 'totalS',
          width: 85,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Total',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )),
      GridColumn(
          columnName: 'cantidadE',
          width: 85,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Cantidad',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )),
      GridColumn(
          columnName: 'costoE',
          width: 85,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Cost.Unit',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )),
      GridColumn(
          columnName: 'totalE',
          width: 85,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Total',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
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
            columnNames: <String>['codigo', 'Promedio'],
            child: _getWidgetForStackedHeaderCell('PRODUCTO')),
        StackedHeaderCell(
            columnNames: <String>['cantidadI', 'costoI', 'totalI'],
            child: _getWidgetForStackedHeaderCell('ENTRADAS')),
        StackedHeaderCell(
            columnNames: <String>['cantidadS', 'costoS', 'totalS'],
            child: _getWidgetForStackedHeaderCell('SALIDAS')),
        StackedHeaderCell(
            columnNames: <String>['cantidadE', 'costoE', 'totalE'],
            child: _getWidgetForStackedHeaderCell('EXISTENCIAS'))
      ])
    ];
    return _stackedHeaderRows;
  }

  @override
  void initState() {
    Provider.of<KardexProvider>(context, listen: false).cargarPrd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kardex = Provider.of<KardexProvider>(context);
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: "Kardex",
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Producto: "),
                    SizedBox(
                      width: 20,
                    ),
                    DropdownButton<Productos>(
                      items: kardex.listado
                          .where((e) => e.estado)
                          .map(
                            (eDrop) => DropdownMenuItem<Productos>(
                              child: Container(
                                constraints: BoxConstraints(maxWidth: 150),
                                child: Text(
                                  eDrop.nombre,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              value: eDrop,
                            ),
                          )
                          .toList(),
                      onChanged: (value) async {
                        kardex.prdSelect = value!;
                        await kardex.getKardexProducto(value.id);
                        // e.productos = value;
                        // e.total = value.precio;
                        setState(() {});
                      },
                      hint: kardex.prdSelect.id == 0
                          ? Text("Seleccione Producto")
                          : Text(kardex.prdSelect.detalle.length > 15
                              ? kardex.prdSelect.detalle.substring(0, 15)
                              : kardex.prdSelect.detalle),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SfDataGrid(
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                  columnWidthMode: ColumnWidthMode.fill,
                  isScrollbarAlwaysShown: true,
                  source: ItemsDataSource(kardex.kardexRegistro, context),
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
