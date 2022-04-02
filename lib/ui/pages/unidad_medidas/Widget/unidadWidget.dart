import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesis_vera_tesis/domain/providers/unidadMedida/unidadProvider.dart';
import 'package:genesis_vera_tesis/ui/widgets/toast_notification.dart';
import 'package:provider/provider.dart';

class UnidadWidget {
  static Future<void> dialogoUnidad(BuildContext context) {
    final unidadP = Provider.of<UnidadMedidaProvider>(context, listen: false);
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Nueva Medida"),
        content: Container(
          width: 450,
          height: 130,
          child: ListView(
            children: [
              TextFormField(
                controller: unidadP.controllCodigo,
                enabled: unidadP.unidad.id != 0 ? false : true,
                inputFormatters: [UpperCaseTextFormatter()],
                decoration: InputDecoration(labelText: "Código"),
              ),
              TextFormField(
                controller: unidadP.controlldescripcion,
                inputFormatters: [UpperCaseTextFormatter()],
                decoration: InputDecoration(labelText: "Descripción"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (await unidadP.guardar()) {
                //Navigator.pop(context);
                ToastNotificationView.messageAccess('Exito :) ');
              }
            },
            child: Text("Aceptar"),
          ),
          TextButton(
            onPressed: () {
              unidadP.refresh();
            },
            child: Text("Cancelar"),
          ),
        ],
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}
