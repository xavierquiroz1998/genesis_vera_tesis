import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/providers/kardex/kardex_provider.dart';
import 'package:genesis_vera_tesis/ui/style/custom_inputs.dart';
import 'package:intl/intl.dart';
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
  String flujoSelect = "-";
  DateTime selectedDate = new DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    var provi = Provider.of<DevolucionProvider>(context, listen: false);
    provi.cargarPrd();
    if (provi.cab.id != 0) {
      var asd = DateTime.tryParse(provi.cab.fecha);
      if (asd != null) {
        selectedDate = asd;
      }
      provi.cargarDetalle(provi.cab.id);
      //provi.generarT(provi.cab.referencia);
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

  @override
  Widget build(BuildContext context) {
    final devolucio = Provider.of<DevolucionProvider>(context);
    final kardex = Provider.of<KardexProvider>(context);
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: devolucio.cab.id == 0
                ? "Nueva Devolución"
                : "Modificar Devolución",
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Codigo Ref"),
                    SizedBox(
                      width: 20,
                    ),
                    Text("${devolucio.codRef}"),
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
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
                          child: Text("${formatter.format(selectedDate)}"),
                        ))
                  ],
                ),
                TextFormField(
                  controller: devolucio.ctrObservacion,
                  decoration: InputDecoration(labelText: "Observación"),
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  onTap: () {},
                  onChanged: (value) async {
                    tipoDevSelect = value!;
                    devolucio.pedidoSelec = new EntityRegistro();
                    devolucio.detalles = [];
                    String ref = "";
                    if (tipoDevSelect == "PROVEEDOR") {
                      devolucio.cab.cliente = "P";
                      await devolucio.getRegistrosDev(1);
                      ref = await devolucio.generarT("P");

                      devolucio.codRef = "Dev / pr-";
                    } else if (tipoDevSelect == "CLIENTE") {
                      devolucio.cab.cliente = "C";

                      await devolucio.getRegistrosDev(2);
                      ref = await devolucio.generarT("C");
                      devolucio.codRef = "Dev / cl-";
                    }

                    devolucio.codRef += ref;
                    setState(() {});
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
                  onChanged: (value) async {
                    if (value != null) {
                      devolucio.cab.idSecundario = value.id;
                      devolucio.pedidoSelec = value;
                      bool lote = tipoDevSelect == "CLIENTE" ? false : true;
                      await devolucio.cargarDetalle(
                          devolucio.pedidoSelec.id, lote);
                    }
                  },
                  items: devolucio.listTableRegistrosDev
                      .map(
                        (item) => DropdownMenuItem<EntityRegistro>(
                          value: item,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              tipoDevSelect == "CLIENTE"
                                  ? "NV-${devolucio.generar(item.referencia)} ${item.cliente}"
                                  : item.detalle,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  decoration: CustomInputs.formInputDecoration(
                      hint: '',
                      label: tipoDevSelect == "CLIENTE"
                          ? 'Seleccione Nota Venta'
                          : 'Seleccione Nota Pedido',
                      icon: Icons.info),
                ),
                SizedBox(
                  height: 10,
                ),

                // Row(
                //   children: [
                //     Text("Tipo de Flujo : "),
                //     SizedBox(width: 20),
                //     for (var item in tipoFlujo) ...{
                //       Radio(
                //         value: item,
                //         groupValue: flujoSelect,
                //         onChanged: (value) {
                //           flujoSelect = value.toString();
                //           setState(() {});
                //         },
                //       ),
                //       Text("$item"),
                //       SizedBox(width: 20),
                //     },
                //   ],
                // ),

                // DropdownButtonFormField<String>(
                //   onChanged: (value) async {
                //     flujoSelect = value!;
                //   },
                //   items: tipoFlujo.map((item) {
                //     return DropdownMenuItem(
                //       value: item,
                //       child: Align(
                //           alignment: Alignment.centerLeft,
                //           child: Text(
                //             item,
                //             style: TextStyle(
                //                 fontSize: 15, fontWeight: FontWeight.w400),
                //           )),
                //     );
                //   }).toList(),
                //   decoration: CustomInputs.formInputDecoration(
                //       hint: '',
                //       label: 'Seleccione Tipo Flujo',
                //       icon: Icons.info),
                // ),

                SizedBox(
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     TextButton(
                //       onPressed: () {
                //         devolucio.agregarDevolucion();
                //       },
                //       child: Text("Agregar"),
                //     ),
                //   ],
                // ),
                Container(
                  width: double.infinity,
                  child: DataTable(
                    columns: <DataColumn>[
                      const DataColumn(
                        label: Center(child: Text("Producto")),
                      ),
                      if (tipoDevSelect != "CLIENTE") ...{
                        const DataColumn(
                          label: Center(child: Text("Proveedor")),
                        ),
                      },
                      const DataColumn(
                        label: Center(child: Text("Flujo")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("cantidad")),
                      ),
                      const DataColumn(
                        label: Center(child: Text(r"$ Costo Uni.")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Total")),
                      ),
                      // const DataColumn(
                      //   label: Center(child: Text("")),
                      // ),
                    ],
                    rows: devolucio.detalles.map<DataRow>((e) {
                      return DataRow(
                        //key: LocalKey(),
                        cells: <DataCell>[
                          DataCell(
                            IgnorePointer(
                              ignoring: true,
                              child: DropdownButton<Productos>(
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
                                  //setState(() {});
                                },
                                hint: e.idProducto == 0
                                    ? Text("Seleccione Producto")
                                    : Text(e.productos!.detalle.length > 15
                                        ? e.productos!.detalle.substring(0, 15)
                                        : e.productos!.detalle),
                              ),
                            ),
                            // Combo(
                            //   provider: devolucio,
                            //   devolucionProd: e,
                            // ),
                          ),
                          DataCell(Text("${e.productos!.proveedor!.nombre}")),
                          DataCell(
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
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      )),
                                );
                              }).toList(),
                              decoration: CustomInputs.formInputDecoration(
                                  hint: '',
                                  label: 'Seleccione Flujo',
                                  icon: Icons.info),
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
                            Text(NumberFormat.currency(
                                    locale: 'en_US', symbol: r'$')
                                .format(e.to)),
                          ),
                          // DataCell(Icon(Icons.delete), onTap: () {
                          //   devolucio.removerDevolucion(e);
                          // }),
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
                          await devolucio.getRegistrosDev(3);
                          NavigationService.replaceTo("/devoluciones");
                        } else {
                          // mensaje alerta
                        }
                      },
                      child: Text("Guardar"), // cliente
                    ),
                    TextButton(
                      onPressed: () async {
                        await devolucio.getRegistrosDev(3);
                        NavigationService.replaceTo("/devoluciones");
                        //Navigator.pop(context);
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
