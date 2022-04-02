import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/providers/kardex/kardex_provider.dart';
import 'package:genesis_vera_tesis/ui/style/custom_inputs.dart';
import 'package:provider/provider.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/providers/Devoluciones/devolucionProvider.dart';

import '../../../../domain/entities/registro/entityRegistor.dart';

class DevolucionView extends StatefulWidget {
  DevolucionView({Key? key}) : super(key: key);

  @override
  State<DevolucionView> createState() => _DevolucionViewState();
}

class _DevolucionViewState extends State<DevolucionView> {
  List<String> tipoDev = ["CLIENTE", "PROVEEDOR"];
  List<String> tipoFlujo = ["+", "-"];
  String tipoDevSelect = "";
  String flujoSelect = "";

  @override
  void initState() {
    var provi = Provider.of<DevolucionProvider>(context, listen: false);
    provi.cargarPrd();
    if (provi.cab.id != 0) {
      provi.cargarDetalle(provi.cab.id);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final devolucio = Provider.of<DevolucionProvider>(context);
    final kardex = Provider.of<KardexProvider>(context);
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: devolucio.cab.id == 0
                ? "Nueva Devolucion"
                : "Modificar Devolucion",
            child: Column(
              children: [
                TextFormField(
                  controller: devolucio.ctrObservacion,
                  decoration: InputDecoration(labelText: "Observacion"),
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  onChanged: (value) async {
                    tipoDevSelect = value!;
                    devolucio.pedidoSelec = new EntityRegistro();
                    if (tipoDevSelect == "PROVEEDOR") {
                      await devolucio.getRegistrosDev(1);
                    } else if (tipoDevSelect == "CLIENTE") {
                      await devolucio.getRegistrosDev(2);
                    }

                    //producto.product.tipoProdcuto = value!.codRef;
                  },
                  items: tipoDev.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          )),
                    );
                  }).toList(),
                  decoration: CustomInputs.formInputDecoration(
                      hint: '',
                      label: 'Seleccione Tipo Devolución',
                      icon: Icons.info),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField<EntityRegistro>(
                  onChanged: (value) {
                    devolucio.pedidoSelec = value!;
                  },
                  items: devolucio.listTableRegistrosDev.map((item) {
                    return DropdownMenuItem<EntityRegistro>(
                      value: item,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item.detalle,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                      ),
                    );
                  }).toList(),
                  decoration: CustomInputs.formInputDecoration(
                      hint: '', label: 'Seleccione Pedido', icon: Icons.info),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField<String>(
                  onChanged: (value) async {
                    flujoSelect = value!;
                  },
                  items: tipoFlujo.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          )),
                    );
                  }).toList(),
                  decoration: CustomInputs.formInputDecoration(
                      hint: '',
                      label: 'Seleccione Tipo Flujo',
                      icon: Icons.info),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        devolucio.agregarDevolucion();
                      },
                      child: Text("Agregar"),
                    ),
                  ],
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
                    rows: devolucio.detalles.map<DataRow>((e) {
                      return DataRow(
                        //key: LocalKey(),
                        cells: <DataCell>[
                          DataCell(
                            DropdownButton<Productos>(
                              items: devolucio.listado
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
                              onChanged: (value) {
                                e.idProducto = value!.id;
                                e.productos = value;
                                setState(() {});
                              },
                              hint: e.idProducto == 0
                                  ? Text("Seleccione Producto")
                                  : Text(e.productos!.detalle.length > 15
                                      ? e.productos!.detalle.substring(0, 15)
                                      : e.productos!.detalle),
                            ),
                            // Combo(
                            //   provider: devolucio,
                            //   devolucionProd: e,
                            // ),
                          ),
                          DataCell(
                            TextFormField(
                              initialValue: e.observacion,
                              onChanged: (value) {
                                e.observacion = value;
                              },
                            ),
                          ),
                          DataCell(
                              TextFormField(
                                initialValue: "${e.cantidad}",
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^(?:\+|-)?\d+$'))
                                ],
                                onChanged: (value) {
                                  e.cantidad = int.parse(value);
                                  devolucio.calcularTotal();
                                },
                              ),
                              placeholder: true),
                          DataCell(
                            TextFormField(
                              initialValue: "${e.total}",
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^(?:\+|-)?\d+$'))
                              ],
                              onChanged: (value) {
                                e.total = double.parse(value);
                                devolucio.calcularTotal();
                              },
                            ),
                          ),
                          DataCell(
                            Text(e.to.toString()),
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
                    // TextButton(
                    //   onPressed: () {
                    //     devolucio.guardarDevolucion();
                    //     devolucio.detalleDevolucion.forEach((element) {
                    //       element.prdSelect.stock =
                    //           double.parse("${element.cantidad}");

                    //       /* Devolucion por compras */
                    //       kardex.entradas(element.prdSelect, false);
                    //       kardex.existenciasDev(element.prdSelect, false);
                    //       /* Fin d edevolucion por compras */

                    //       /* Dev por ventas */
                    //       /*  kardex.salidas(
                    //           element.prdSelect.stock!, element.prdSelect);
                    //       kardex.existenciasDev(element.prdSelect, true); */
                    //       /* Dev por venta fin */
                    //       /* Evento de impresion de kardex :) */
                    //       kardex.impresion();
                    //     });

                    //     if (devolucio.msgError == "") {
                    //       Navigator.pop(context);
                    //     } else {
                    //       // mensaje alerta
                    //     }
                    //   },
                    //   child: Text("Guardar Dev Compras"),
                    // ),

                    TextButton(
                      onPressed: () async {
                        var valTemp = 0.0;
                        if (tipoDevSelect == "PROVEEDOR") {
                          await devolucio.guardarDevolucion();
                          /*devolucio.detalleDevolucion.forEach((element) {
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
                          }); */
                        } else if (tipoDevSelect == "CLIENTE") {
                          await devolucio.guardarDevolucion();
                          // devolucio.detalleDevolucion.forEach((element) {
                          //   valTemp = element.prdSelect.stock! -
                          //       double.parse("${element.cantidad}");

                          //   element.prdSelect.stock =
                          //       double.parse("${element.cantidad}");

                          //   /* Devolucion por compras */
                          //   /* kardex.entradas(element.prdSelect, true, false); */
                          //   kardex.devoluciones(element.prdSelect, true);
                          //   /*    kardex.existenciasDev(element.prdSelect, false); */
                          //   /* Fin d edevolucion por compras */

                          //   /* Dev por ventas */
                          //   /*  kardex.salidas(
                          //     element.prdSelect.stock!, element.prdSelect);
                          // kardex.existenciasDev(element.prdSelect, true); */
                          //   /* Dev por venta fin */
                          //   /* Evento de impresion de kardex :) */
                          //   element.prdSelect.stock = valTemp;

                          //   kardex.impresion();
                          // });
                        } else {
                          devolucio.msgError = "Seleccione Tipo de Devolución";
                        }

                        if (devolucio.msgError == "") {
                          NavigationService.replaceTo("/devoluciones");
                        } else {
                          // mensaje alerta
                        }
                      },
                      child: Text("Guardar"), // cliente
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
