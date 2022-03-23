import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/egreso/egresoProducto.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/providers/egreso/e_productoProvider.dart';
import 'package:genesis_vera_tesis/domain/providers/kardex/kardex_provider.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:provider/provider.dart';

class EgresoProducto extends StatefulWidget {
  const EgresoProducto({Key? key}) : super(key: key);

  @override
  State<EgresoProducto> createState() => _EgresoProductoState();
}

class _EgresoProductoState extends State<EgresoProducto> {
  @override
  void initState() {
    Provider.of<EProductoProvider>(context, listen: false).cargarPrd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final egreso = Provider.of<EProductoProvider>(context);
    final kardex = Provider.of<KardexProvider>(context);
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            child: Column(
              children: [
                TextFormField(
                  initialValue: egreso.ctrObservacion.text,
                  decoration: InputDecoration(labelText: "Observacion"),
                  onChanged: (value) {
                    egreso.ctrObservacion.text = value;
                  },
                ),
                TextButton(
                  onPressed: () {
                    egreso.agregar();
                  },
                  child: Text("Agregar"),
                ),
                Container(
                  width: double.infinity,
                  child: DataTable(
                    columns: <DataColumn>[
                      const DataColumn(
                        label: Center(child: Text("Producto")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("observacion")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("cantidad")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Precio")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Total")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("")),
                      ),
                    ],
                    rows: egreso.detalles.map<DataRow>((e) {
                      return DataRow(
                        //key: LocalKey(),
                        cells: <DataCell>[
                          DataCell(DropdownButton<Productos>(
                            items: egreso.listado
                                .map(
                                  (eDrop) => DropdownMenuItem<Productos>(
                                    child: Text(eDrop.detalle),
                                    value: eDrop,
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              e.idProducto = value!.id;
                              e.productos = value;
                              setState(() {});
                            },
                            hint: e.idProducto == 0
                                ? Text("Seleccione Producto")
                                : Text("${e.productos!.detalle}"),
                          )),
                          DataCell(
                            TextFormField(
                              onChanged: (value) {
                                e.observacion = value;
                              },
                            ),
                          ),
                          DataCell(
                            TextFormField(
                              onChanged: (value) {
                                e.cantidad = int.parse(value);
                                egreso.calcular();
                              },
                            ),
                          ),
                          DataCell(
                            TextFormField(
                              onChanged: (value) {
                                e.to = double.parse(value);
                                egreso.calcular();
                                //e.total = e.cantidad * e.precio!;
                              },
                            ),
                          ),
                          DataCell(
                            Text(e.total.toString()),
                          ),
                          DataCell(Icon(Icons.delete), onTap: () {
                            egreso.remover(e);
                          }),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        egreso.guardarEgreso();
                        // for (var item in egreso.listaProducto.detalle!) {
                        //   var result = Estaticas.listProductos
                        //       .firstWhere((e) => e.id == item.idProducto);
                        //   if (result.id > 0) {
                        //     kardex.salidas(
                        //         double.parse(item.cantidad.toString()), result);
                        //     /*   result.stock =
                        //         double.parse(item.cantidad.toString()); */
                        //     /*     kardex.existencias(result, false, false); */
                        //     kardex.impresion();
                        //   }
                        // }
                        Navigator.pop(context);
                      },
                      child: Text("Guardar"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancelar"),
                    ),
                  ],
                )
              ],
            ),
          ),
          // TextFormField(
          //   decoration: InputDecoration(labelText: "Cliente"),
          // ),
        ],
      ),
    );
  }
}
