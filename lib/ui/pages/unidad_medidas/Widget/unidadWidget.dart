import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesis_vera_tesis/domain/providers/unidadMedida/unidadProvider.dart';
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
              TextField(
                onChanged: (value) {
                  unidadP.unidad.codigo = value;
                },
                inputFormatters: [UpperCaseTextFormatter()],
                decoration: InputDecoration(labelText: "Codigo"),
              ),
              TextField(
                onChanged: (value) {
                  unidadP.unidad.descripcion = value;
                },
                inputFormatters: [UpperCaseTextFormatter()],
                decoration: InputDecoration(labelText: "Descripcion"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (await unidadP.guardar()) {
                Navigator.pop(context);
              }
            },
            child: Text("Aceptar"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
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
