import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/providers/kardex/kardex_provider.dart';
import 'package:provider/provider.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/providers/Devoluciones/devolucionProvider.dart';

class DevolucionView extends StatefulWidget {
  DevolucionView({Key? key}) : super(key: key);

  @override
  State<DevolucionView> createState() => _DevolucionViewState();
}

class _DevolucionViewState extends State<DevolucionView> {
  @override
  Widget build(BuildContext context) {
    final devolucio = Provider.of<DevolucionProvider>(context);
    final kardex = Provider.of<KardexProvider>(context);
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: devolucio.cab.idDevolucion == null
                ? "Nueva Devolucion"
                : "Modificar Devolucion",
            child: Column(
              children: [
                TextFormField(
                  controller: devolucio.ctrObservacion,
                  decoration: InputDecoration(labelText: "Observacion"),
                ),
                TextButton(
                  onPressed: () {
                    devolucio.agregarDevolucion();
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
                    rows: devolucio.detalleDevolucion.map<DataRow>((e) {
                      return DataRow(
                        //key: LocalKey(),
                        cells: <DataCell>[
                          DataCell(
                            DropdownButton<Productos>(
                              items: Estaticas.listProductos
                                  .map(
                                    (eDrop) => DropdownMenuItem<Productos>(
                                      child: Text(eDrop.descripcion!),
                                      value: eDrop,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                e.idProducto = value?.id;
                                e.prdSelect = value!;
                                // prdSelect = value!;
                                setState(() {});
                              },
                              hint: e.idProducto == null
                                  ? Text("Seleccione Producto")
                                  : Text("${e.prdSelect.descripcion}"),
                            ),
                            // Combo(
                            //   provider: devolucio,
                            //   devolucionProd: e,
                            // ),
                          ),
                          DataCell(
                            TextFormField(
                              initialValue: e.detalle,
                              onChanged: (value) {
                                e.detalle = value;
                              },
                            ),
                          ),
                          DataCell(
                            TextFormField(
                              initialValue: "${e.cantidad}",
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                e.cantidad = int.tryParse(value);
                                devolucio.calcularTotal();
                              },
                            ),
                          ),
                          DataCell(
                            TextFormField(
                              initialValue: "${e.precio}",
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                e.precio = double.tryParse(value);
                                devolucio.calcularTotal();
                              },
                            ),
                          ),
                          DataCell(
                            Text(e.total.toString()),
                          ),
                          DataCell(Icon(Icons.delete), onTap: () {
                            devolucio.removerDevolucion(e);
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
                        devolucio.guardarDevolucion();
                        devolucio.detalleDevolucion.forEach((element) {
                          element.prdSelect.stock =
                              double.parse("${element.cantidad}");

                          /* Devolucion por compras */
                          kardex.entradas(element.prdSelect, false);
                          kardex.existenciasDev(element.prdSelect, false);
                          /* Fin d edevolucion por compras */

                          /* Dev por ventas */
                          /*  kardex.salidas(
                              element.prdSelect.stock!, element.prdSelect);
                          kardex.existenciasDev(element.prdSelect, true); */
                          /* Dev por venta fin */
                          /* Evento de impresion de kardex :) */
                          kardex.impresion();
                        });

                        if (devolucio.msgError == "") {
                          Navigator.pop(context);
                        } else {
                          // mensaje alerta
                        }
                      },
                      child: Text("Guardar Dev Compras"),
                    ),
                    TextButton(
                      onPressed: () {
                        devolucio.guardarDevolucion();
                        devolucio.detalleDevolucion.forEach((element) {
                          element.prdSelect.stock =
                              double.parse("${element.cantidad}");

                          /* Devolucion por compras */
                          /*    kardex.entradas(element.prdSelect, false);
                          kardex.existenciasDev(element.prdSelect, false); */
                          /* Fin d edevolucion por compras */

                          /* Dev por ventas */
                          kardex.salidas(element.prdSelect.stock!,
                              element.prdSelect, false);
                          kardex.existenciasComp(element.prdSelect, true);
                          /* Dev por venta fin */
                          /* Evento de impresion de kardex :) */
                          kardex.impresion();
                        });

                        if (devolucio.msgError == "") {
                          Navigator.pop(context);
                        } else {
                          // mensaje alerta
                        }
                      },
                      child: Text("Guardar Dev Ventas"),
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
