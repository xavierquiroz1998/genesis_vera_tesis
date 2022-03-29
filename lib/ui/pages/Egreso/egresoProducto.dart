import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/providers/egreso/e_productoProvider.dart';
import 'package:genesis_vera_tesis/domain/providers/kardex/kardex_provider.dart';
import 'package:genesis_vera_tesis/domain/uses%20cases/productos/productosGeneral.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:provider/provider.dart';

import '../../../domain/providers/productosProvider.dart';

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

  String numeros = r'^(?:\+|-)?\d+$';

  @override
  Widget build(BuildContext context) {
    final egreso = Provider.of<EProductoProvider>(context);
    final producto = Provider.of<ProductosProvider>(context);
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
                        label: Center(child: Text("Stock Producto")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Cod Producto")),
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
                          DataCell(
                            Container(
                              width: 180,
                              child: DropdownButton<Productos>(
                                items: egreso.listado
                                    .map(
                                      (eDrop) => DropdownMenuItem<Productos>(
                                        child: Text(eDrop.detalle.length > 15
                                            ? eDrop.detalle.substring(0, 15)
                                            : eDrop.detalle),
                                        value: eDrop,
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  e.idProducto = value!.id;
                                  e.productos = value;
                                  e.total = value.precio;
                                  setState(() {});
                                },
                                hint: e.idProducto == 0
                                    ? Text("Seleccione Producto")
                                    : Text(e.productos!.detalle.length > 15
                                        ? e.productos!.detalle.substring(0, 15)
                                        : e.productos!.detalle),
                              ),
                            ),
                          ),
                          DataCell(e.productos != null
                              ? Text("${e.productos!.cantidad}")
                              : Text("")),
                          DataCell(e.productos != null
                              ? Text("${e.productos!.referencia}")
                              : Text("")),
                          DataCell(
                            TextFormField(
                              onChanged: (value) {
                                e.observacion = value;
                              },
                            ),
                          ),
                          DataCell(
                            TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(numeros))
                              ],
                              onChanged: (value) {
                                e.cantidad = int.parse(value);
                                egreso.calcular();
                              },
                            ),
                          ),
                          DataCell(
                            TextFormField(
                              onChanged: (value) {
                                e.total = double.parse(value);
                                egreso.calcular();
                                //e.total = e.cantidad * e.precio!;
                              },
                            ),
                          ),
                          DataCell(
                            Text(e.to.toString()),
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
                      onPressed: () async {
                        await egreso.guardarEgreso();
                        if (producto.listado.length == 0) {
                          await producto.cargarPrd();
                        }
                        for (var item in egreso.detalles) {
                          var result = producto.listado
                              .firstWhere((e) => e.id == item.idProducto);
                          if (result.id > 0) {
                            await kardex.salidas(
                                double.parse(item.cantidad.toString()), result);
                            /*   result.stock =
                                double.parse(item.cantidad.toString()); */
                            /*     kardex.existencias(result, false, false); */

                            // actualizo Stock Prd
                            Productos prd = new Productos();
                            prd.id = result.id;
                            prd.detalle = result.detalle;
                            prd.estado = result.estado;
                            prd.idGrupo = result.idGrupo;
                            prd.idUnidad = result.idUnidad;
                            prd.idProveedor = result.idProveedor;
                            prd.nombre = result.nombre;
                            prd.pedido = result.pedido;
                            prd.precio = result.precio;
                            prd.referencia = result.referencia;

                            prd.cantidad = result.cantidad - item.cantidad;

                            await egreso.generalProducto.update(prd);
                            kardex.impresion();
                          }
                        }
                        NavigationService.replaceTo("/egresos");
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
