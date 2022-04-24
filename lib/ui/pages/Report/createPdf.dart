import 'dart:io';
import 'package:genesis_vera_tesis/domain/entities/registro/entityRegistor.dart';
import 'package:genesis_vera_tesis/ui/pages/Report/pdfApi.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfInvoiceApi {
  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static Future generate(EntityRegistro invoice, String codRef) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice, codRef),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(invoice),
        buildInvoice(invoice),
        Divider(),
        buildTotal(invoice),
      ],
      //footer: (context) => buildFooter(invoice),
    ));

    PdfApi.saveDocument(name: 'nota.pdf', pdf: pdf);
  }

  static Widget buildHeader(EntityRegistro invoice, String cod) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSupplierAddress(cod),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // buildCustomerAddress(invoice.customer),
              // buildInvoiceInfo(invoice.info),
            ],
          ),
        ],
      );

  static Widget buildSupplierAddress(String cod) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nv-" + cod, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text("adreess"),
        ],
      );

  static Widget buildTitle(EntityRegistro registro) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   "NV-" + codRef,
          //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          // ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text("Fecha : " + registro.fecha),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text("Cliente : " + registro.cliente),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text("Observaciones : " + registro.detalle),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(EntityRegistro invoice) {
    final headers = ['Producto', 'Lote', 'Cantidad', 'Precio', 'Total'];
    final data = invoice.detalles.map((item) {
      //final total = item.unitPrice * item.quantity * (1 + item.vat);

      return [
        item.productos.detalle,
        '${item.lote}',
        ' ${item.cantidad}',
        '\$ ${item.total.toStringAsFixed(2)} ',
        '\$ ${item.to.toStringAsFixed(2)}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      // headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(EntityRegistro invoice) {
    final netTotal = invoice.detalles
        .map((item) =>
            double.parse(item.total.toStringAsFixed(2)) * item.cantidad)
        .reduce((item1, item2) => item1 + item2);
    // final vatPercent = invoice.items.first.vat;
    // final vat = netTotal * vatPercent;
    // final total = netTotal + vat;

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'total',
                  //value: Utils.formatPrice(netTotal),
                  value: formatPrice(netTotal),
                  unite: true,
                ),
                // buildText(
                //   title: 'Vat ${vatPercent * 100} %',
                //   value: Utils.formatPrice(vat),
                //   unite: true,
                // ),
                // Divider(),
                // buildText(
                //   title: 'Total amount due',
                //   titleStyle: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.bold,
                //   ),
                //   value: Utils.formatPrice(total),
                //   unite: true,
                // ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    //TextStyle? titleStyle,
    bool unite = false,
  }) {
    //final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
          )),
          Text(value),
        ],
      ),
    );
  }
}
