import 'dart:convert';
import 'dart:io';
import 'package:pdf/widgets.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import "package:universal_html/html.dart";

class PdfApi {
  static Future saveDocument({
    required String name,
    required Document pdf,
  }) async {
    try {
      final bytes = await pdf.save();
      print("000");
      // final dir = await getTemporaryDirectory();
      // final file = File('${dir.path}/$name');

// Create a new PDF document.
      //final PdfDocument document = PdfDocument(inputBytes: bytes);
      AnchorElement(
          href:
              "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
        ..setAttribute("download", name)
        ..click();

      // return f;
    } catch (ex) {
      print("***** Erro en ${ex.toString()}");
      //return File('');
    }
  }

  // static Future openFile(File file) async {
  //   final url = file.path;

  //   await OpenFile.open(url);
  // }
}
