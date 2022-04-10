import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/providers/egreso/e_productoProvider.dart';
import 'package:genesis_vera_tesis/domain/providers/kardex/kardex_provider.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data/models/movimiento/modelMovimiento.dart';
import '../../../domain/providers/productosProvider.dart';

class EgresoProducto extends StatefulWidget {
  const EgresoProducto({Key? key}) : super(key: key);

  @override
  State<EgresoProducto> createState() => _EgresoProductoState();
}

class _EgresoProductoState extends State<EgresoProducto> {
  DateTime selectedDate = new DateTime.now();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    var temProvider = Provider.of<EProductoProvider>(context, listen: false);
    temProvider.cargarPrd();
    if (temProvider.cab.id != 0) {
      selectedDate = DateTime.parse(temProvider.cab.fecha);
      temProvider.cargarDetalle(temProvider.cab.id);
      temProvider.generar(temProvider.cab.referencia);
    } else {
      temProvider.generar();
    }
    super.initState();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        //_dateController.text = DateFormat.yMd().format(selectedDate);
      });
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
                Row(
                  children: [
                    Text("Codigo Ref"),
                    SizedBox(
                      width: 20,
                    ),
                    Text("NV-${egreso.codRef}"),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text("Fecha"),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () async {
                          await _selectDate(context);
                        },
                        child: Container(
                          child: Text("${formatter.format(selectedDate)}"),
                        ))
                  ],
                ),
                TextFormField(
                  initialValue: egreso.ctrCliente.text,
                  decoration: InputDecoration(labelText: "Nombre del Cliente"),
                  onChanged: (value) {
                    egreso.ctrCliente.text = value;
                  },
                ),
                TextFormField(
                  initialValue: egreso.ctrObservacion.text,
                  decoration: InputDecoration(labelText: "Observación"),
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
                      // const DataColumn(
                      //   label: Center(child: Text("Cod Prod.")),
                      // ),
                      const DataColumn(
                        label: Center(child: Text("Lote")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Stock ")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Costo Uni.")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("cantidad")),
                      ),
                      const DataColumn(
                        label: Center(child: Text(r"$ Precio")),
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
                            DropdownButton<Productos>(
                              items: egreso.listado
                                  .where((e) => e.estado)
                                  .map(
                                    (eDrop) => DropdownMenuItem<Productos>(
                                      child: Container(
                                        constraints:
                                            BoxConstraints(maxWidth: 150),
                                        child: Text(
                                          eDrop.nombre,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      value: eDrop,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) async {
                                e.idProducto = value!.id;
                                e.productos = value;
                                e.productos!.cantidad = 0;
                                //e.total = value.precio;
                                await egreso.cargarMovimientos(e.idProducto);
                                setState(() {});
                              },
                              hint: e.idProducto == 0
                                  ? Text("Seleccione Producto")
                                  : Text(e.productos!.detalle.length > 15
                                      ? e.productos!.detalle.substring(0, 15)
                                      : e.productos!.detalle),
                            ),
                          ),
                          // DataCell(e.productos != null
                          //     ? Text("${e.productos!.referencia}")
                          //     : Text("")),
                          DataCell(
                            DropdownButton<ModelMovimiento>(
                              items: egreso.listaMovimientos
                                  .map(
                                    (eDrop) =>
                                        DropdownMenuItem<ModelMovimiento>(
                                      child: Container(
                                        constraints:
                                            BoxConstraints(maxWidth: 100),
                                        child: Text(
                                          eDrop.codigo,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      value: eDrop,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                e.lote = value!.codigo;
                                e.mov = value;
                                e.productos!.cantidad = value.actual.toDouble();

                                setState(() {});
                              },
                              hint: e.lote == ""
                                  ? Text("Lote")
                                  : Text(e.mov!.codigo),
                            ),
                          ),
                          DataCell(e.productos != null
                              ? Text("${e.productos!.cantidad}")
                              : Text("")),
                          DataCell(e.productos != null
                              ? Text("${e.productos!.precio}")
                              : Text("")),
                          DataCell(
                            TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(numeros))
                              ],
                              initialValue: e.cantidad.toString(),
                              onChanged: (value) {
                                e.cantidad = int.parse(value);
                                egreso.calcular();
                              },
                            ),
                          ),
                          DataCell(
                            TextFormField(
                              // initialValue: NumberFormat.currency(
                              //         locale: 'en_US', symbol: r'$')
                              //     .format(e.total),
                              initialValue: e.total.toString(),
                              onChanged: (value) {
                                e.total = double.parse(value);
                                egreso.calcular();
                                //e.total = e.cantidad * e.precio!;
                              },
                            ),
                          ),
                          DataCell(
                            Text(NumberFormat.currency(
                                    locale: 'en_US', symbol: r'$')
                                .format(e.to)),
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
                        egreso.cab.fecha = selectedDate.toIso8601String();
                        if (egreso.cab.id == 0) {
                          await egreso.guardarEgreso();
                        } else {
                          await egreso.actualizar();
                        }
                        // AwesomeDialog(
                        //   context: context,
                        //   dialogType: DialogType.SUCCES,
                        //   animType: AnimType.BOTTOMSLIDE,
                        //   title: 'Guardado Correctamente',
                        //   desc: '',
                        // )..show();
                        if (producto.listado.length == 0) {
                          await producto.cargarPrd();
                        }
                        for (var item in egreso.detalles) {
                          var result = producto.listado
                              .firstWhere((e) => e.id == item.idProducto);
                          print("---------${result.id}");
                          if (result.id > 0) {
                            try {
                              await kardex.salidas(
                                  item.cantidad.toDouble(), result);
                            } catch (ex) {
                              print("#rror kardex de egreso ${ex.toString()}");
                            }

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
