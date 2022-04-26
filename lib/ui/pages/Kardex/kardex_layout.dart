// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesis_vera_tesis/domain/providers/kardex/kardex_provider.dart';
import 'package:genesis_vera_tesis/ui/pages/items_source.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../domain/entities/productos.dart';

import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:genesis_vera_tesis/util/save_file_web.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

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
          columnName: 'fecha',
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
          columnName: 'codigo',
          width: 85,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Cod-Mov',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )),
      GridColumn(
          columnName: 'C. P. P.',
          width: 85,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'C. P. P.',
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
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ));
  }

  List<StackedHeaderRow> _getStackedHeaderRows() {
    List<StackedHeaderRow> _stackedHeaderRows;
    _stackedHeaderRows = <StackedHeaderRow>[
      StackedHeaderRow(cells: <StackedHeaderCell>[
        StackedHeaderCell(
            columnNames: <String>['fecha', 'codigo', 'C. P. P.'],
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
    final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();
    return Container(
      child: WhiteCard(
        title: "Kardex",
        child: Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text("Producto: "),
                  SizedBox(
                    width: 20,
                  ),
                  DropdownButton<Productos>(
                    items: kardex.listado
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

                      await kardex.getKardexProducto(kardex.prdSelect.id);
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
              Expanded(
                child: SfDataGrid(
                  key: _key,
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                  columnWidthMode: ColumnWidthMode.fill,
                  isScrollbarAlwaysShown: true,
                  source: ItemsDataSource(kardex.kardexRegistro, context),
                  columns: _getColumns(),
                  stackedHeaderRows: _getStackedHeaderRows(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton.icon(
                    icon: const Icon(Icons.receipt_sharp),
                    onPressed: () =>
                        exportDataGridToPdf(_key, kardex.prdSelect.nombre),
                    label: const Text("Generar Reporte PDF")),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> exportDataGridToPdf(
    GlobalKey<SfDataGridState> key, String nombre) async {
  final ByteData data = await rootBundle.load('assets/sinfondo.png');
  final PdfDocument document = key.currentState!.exportToPdfDocument(
      fitAllColumnsInOnePage: true,
      autoColumnWidth: true,
      cellExport: (DataGridCellPdfExportDetails details) {
        if (details.cellType == DataGridExportCellType.row) {
          if (details.columnName == 'fecha' || details.columnName == 'codigo') {
            /*  details.pdfCell.value = DateFormat('MM/dd/yyyy')
                .format(DateTime.parse(details.pdfCell.value)); */
          } else {
            details.pdfCell.value =
                double.parse(details.pdfCell.value).toStringAsFixed(2);
          }
        }
      },
      headerFooterExport: (DataGridPdfHeaderFooterExportDetails details) {
        final double width = details.pdfPage.getClientSize().width;
        final PdfPageTemplateElement header =
            PdfPageTemplateElement(Rect.fromLTWH(0, 0, width, 65));

        header.graphics.drawImage(
            PdfBitmap(data.buffer
                .asUint8List(data.offsetInBytes, data.lengthInBytes)),
            Rect.fromLTWH(width - 148, 0, 148, 60));

        header.graphics.drawString(
          'KARDEX: ' +
              nombre +
              " " +
              DateFormat('MM/dd/yyyy hh:mm a').format(DateTime.now()),
          PdfStandardFont(PdfFontFamily.helvetica, 12,
              style: PdfFontStyle.bold),
          bounds: const Rect.fromLTWH(0, 25, 200, 60),
        );

        details.pdfDocumentTemplate.top = header;
      });
  final List<int> bytes = document.save();
  await FileSaveHelper.saveAndLaunchFile(bytes, 'export_kardex.pdf');
  document.dispose();
}
