import 'dart:async';
import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:typed_data';

///Para guardar el archivo pdf en el dispositivo
class FileSaveHelper {
  static Future<void> saveAndLaunchFile(
      List<int> bytes, String fileName) async {
    AnchorElement(
        href:
            'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
      ..setAttribute('download', fileName)
      ..click();
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }
}
