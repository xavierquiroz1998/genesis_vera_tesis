import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:provider/provider.dart';

import '../../../domain/providers/productosProvider.dart';

class PedidoMes extends StatefulWidget {
  const PedidoMes({Key? key}) : super(key: key);

  @override
  State<PedidoMes> createState() => _PedidoMesState();
}

class _PedidoMesState extends State<PedidoMes> {
  String numeros = r'^(?:\+|-)?\d+$';
  @override
  void initState() {
    Provider.of<ProductosProvider>(context, listen: false).cargarPrd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final producto = Provider.of<ProductosProvider>(context);
    return WhiteCard(
      child: Expanded(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    width: double.infinity,
                    child: DataTable(
                      columns: <DataColumn>[
                        const DataColumn(
                          label: Center(child: Text("Id")),
                        ),
                        const DataColumn(
                          label: Center(child: Text("Codigo")),
                        ),
                        const DataColumn(
                          label: Center(child: Text("Descripcion")),
                        ),
                        const DataColumn(
                          label: Center(child: Text("Stock")),
                        ),
                        const DataColumn(
                          label: Center(child: Text("Pedido")),
                        ),
                      ],
                      rows: producto.listado.map<DataRow>((e) {
                        return DataRow(
                          color: MaterialStateProperty.resolveWith<Color?>(
                              (states) {
                            if (!e.estado) {
                              return Colors.red.shade300;
                            }
                            return null;
                          }),
                          //key: LocalKey(),
                          cells: <DataCell>[
                            DataCell(
                              Text(e.id.toString()),
                            ),
                            DataCell(
                              //Text(e.codigo.toString()),
                              Text(e.referencia.toString()),
                            ),
                            DataCell(
                              Text(e.detalle),
                            ),
                            DataCell(
                              Text(e.cantidad.toString()),
                            ),
                            DataCell(TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(numeros))
                              ],
                              initialValue: e.pedido.toString(),
                              decoration:
                                  InputDecoration(hintText: "Pedido del Mes"),
                              onChanged: (value) {
                                e.pedido = int.parse(value);
                              },
                            )),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () async {
                if (await producto.pedidosMes()) {}
              },
              child: Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
