import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/providers/grupo/grupo_provider.dart';
import 'package:genesis_vera_tesis/ui/pages/tipo_producto/modal/tipo_modal.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TipoProducto extends StatefulWidget {
  TipoProducto({Key? key}) : super(key: key);

  @override
  _TipoProductoState createState() => _TipoProductoState();
}

class _TipoProductoState extends State<TipoProducto> {
  @override
  void initState() {
    Provider.of<GrupoProvider>(context, listen: false).callgetGrupos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productoProvider = Provider.of<GrupoProvider>(context);
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              WhiteCard(
                  title: 'Tipo de producto',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            productoProvider.isShowUpdate = "0";
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (_) => TipoModal(
                                categoria: null,
                              ),
                            );
                          },
                          child: Text("Nuevo")),
                      Container(
                        width: double.infinity,
                        child: DataTable(
                            columns: [
                              DataColumn(
                                  label: Text("Codigo",
                                      style: buildCustomStyle())),
                              DataColumn(
                                  label: Text("Nombre",
                                      style: buildCustomStyle())),
                              DataColumn(
                                  label: Text("Descripcion",
                                      style: buildCustomStyle())),
                              DataColumn(
                                  label: Text("Estado",
                                      style: buildCustomStyle())),
                              DataColumn(
                                  label: Text("Acciones",
                                      style: buildCustomStyle())),
                            ],
                            rows: productoProvider.listGrupo.map<DataRow>((e) {
                              return DataRow(cells: [
                                DataCell(Text(e.referencia.toString())),
                                DataCell(Text(e.nombre.toString())),
                                DataCell(Text(e.detalle.toString())),
                                DataCell(Icon(
                                  e.estado ? Icons.check : Icons.dangerous,
                                  color: e.estado ? Colors.green : Colors.red,
                                )),
                                DataCell(Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        productoProvider.isShowUpdate = "1";
                                        showModalBottomSheet(
                                          context: context,
                                          backgroundColor: Colors.transparent,
                                          builder: (_) => TipoModal(
                                            categoria: e,
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () => {},

                                        //productoProvider.deleteTipo(e)
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))
                                  ],
                                )),
                              ]);
                            }).toList()),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  TextStyle buildCustomStyle() {
    return GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.bold);
  }
}
