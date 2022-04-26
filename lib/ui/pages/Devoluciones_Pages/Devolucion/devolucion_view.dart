import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/providers/kardex/kardex_provider.dart';
import 'package:genesis_vera_tesis/ui/style/custom_inputs.dart';
import 'package:genesis_vera_tesis/ui/widgets/toast_notification.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/providers/Devoluciones/devolucionProvider.dart';
import 'package:searchfield/searchfield.dart';

import '../../../../domain/entities/registro/entityRegistor.dart';

class DevolucionView extends StatefulWidget {
  DevolucionView({Key? key}) : super(key: key);

  @override
  State<DevolucionView> createState() => _DevolucionViewState();
}

class _DevolucionViewState extends State<DevolucionView> {
  List<String> tipoDev = ["CLIENTE", "PROVEEDOR"];
  String tipoDevSelect = "";
  String flujoSelect = "-";
  DateTime selectedDate = new DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final keyProducto = GlobalKey<FormState>();

  @override
  void initState() {
    var provi = Provider.of<DevolucionProvider>(context, listen: false);
    provi.limpiarVariables();
    provi.cargarPrd();
    if (provi.cab.id != 0) {
      var asd = DateTime.tryParse(provi.cab.fecha);
      if (asd != null) {
        selectedDate = asd;
      }
      tipoDevSelect = provi.cab.cliente == "C" ? "CLIENTE" : "PROVEEDOR";
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
            child: Form(
              key: keyProducto,
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
                    onTap: () {
                      setState(() {
                        devolucio.listTableRegistrosDev.clear();
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Seleccione uno";
                      }
                      return null;
                    },
                    onChanged: (value) async {
                      devolucio.detalles = [];
                      tipoDevSelect = value!;
                      devolucio.pedidoSelec = new EntityRegistro();
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
                        label: devolucio.cab.id == 0
                            ? 'Seleccione Tipo Devolución'
                            : tipoDevSelect,
                        icon: Icons.info),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SearchField<EntityRegistro>(
                    hint: tipoDevSelect == "CLIENTE"
                        ? 'Seleccione Nota Venta'
                        : 'Seleccione Lote',
                    validator: (value) {
                      if (value == null) {
                        return "Seleccione uno";
                      }
                      return null;
                    },
                    searchInputDecoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    suggestions: devolucio.listTableRegistrosDev
                        .map(
                          (i) => SearchFieldListItem<EntityRegistro>(
                            tipoDevSelect == "CLIENTE"
                                ? "NV-${devolucio.generar(i.referencia)} ${i.cliente}"
                                : i.detalle,
                            item: i,
                            child: Text(
                              tipoDevSelect == "CLIENTE"
                                  ? "NV-${devolucio.generar(i.referencia)} ${i.cliente}"
                                  : i.detalle,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                        .toList(),
                    onSuggestionTap: (value) async {
                      if (value.item != null) {
                        devolucio.cab.idSecundario = value.item!.id;
                        devolucio.pedidoSelec = value.item!;
                        bool lote = tipoDevSelect == "CLIENTE" ? false : true;

                        await devolucio.cargarDetalle(
                            devolucio.pedidoSelec.id, lote);
                      }
                      setState(() {});
                    },
                    // initialValue: devolucio.selectEntity.id > 0
                    //     ? SearchFieldListItem<EntityRegistro>(
                    //         tipoDevSelect == "CLIENTE"
                    //             ? "NV-${devolucio.generar(devolucio.selectEntity.referencia)} ${devolucio.selectEntity.cliente}"
                    //             : devolucio.selectEntity.detalle,
                    //         item: devolucio.selectEntity)
                    //     : null,
                  ),
                  // DropdownButtonFormField<EntityRegistro>(
                  //   onChanged: (value) async {
                  //     if (value != null) {
                  //       devolucio.cab.idSecundario = value.id;
                  //       devolucio.pedidoSelec = value;
                  //       bool lote = tipoDevSelect == "CLIENTE" ? false : true;

                  //       await devolucio.cargarDetalle(
                  //           devolucio.pedidoSelec.id, lote);
                  //     }
                  //     setState(() {});
                  //   },
                  //   value: devolucio.selectEntity,
                  //   items: devolucio.listTableRegistrosDev
                  //       .map(
                  //         (item) => DropdownMenuItem<EntityRegistro>(
                  //           value: item,
                  //           child: Align(
                  //             alignment: Alignment.centerLeft,
                  //             child: Text(
                  //               tipoDevSelect == "CLIENTE"
                  //                   ? "NV-${devolucio.generar(item.referencia)} ${item.cliente}"
                  //                   : item.detalle,
                  //               style: TextStyle(
                  //                   fontSize: 15, fontWeight: FontWeight.w400),
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //       .toList(),
                  //   decoration: CustomInputs.formInputDecoration(
                  //       hint: '',
                  //       label: tipoDevSelect == "CLIENTE"
                  //           ? 'Seleccione Nota Venta'
                  //           : 'Seleccione Lote',
                  //       icon: Icons.info),
                  // ),

                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: DataTable(
                      columns: <DataColumn>[
                        const DataColumn(
                          label: Center(child: Text("Producto")),
                        ),
                        const DataColumn(
                          label: Center(child: Text("Proveedor")),
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
                      ],
                      rows: devolucio.detalles.map<DataRow>((e) {
                        return DataRow(
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
                                      : Text(e.productos.detalle.length > 15
                                          ? e.productos.detalle.substring(0, 15)
                                          : e.productos.detalle),
                                ),
                              ),
                            ),
                            DataCell(Text(e.productos.proveedor!.nombre)),
                            DataCell(
                                SizedBox(
                                  width: 50,
                                  child: TextFormField(
                                    controller: TextEditingController(
                                        text: "${e.cantidad}"),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^(?:\+|-)?\d+$'))
                                    ],
                                    onChanged: (value) {
                                      e.cantidad = int.parse(value);
                                      devolucio.calcularTotal();
                                    },
                                    decoration:
                                        CustomInputs.cantInputDecoration(
                                            hint: ""),
                                  ),
                                ),
                                placeholder: true),
                            DataCell(
                                Text(
                                  NumberFormat.currency(
                                          locale: 'en_US',
                                          symbol: r'$',
                                          decimalDigits: 2)
                                      .format(e.total),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                placeholder: true),

                            /* DataCell(
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
                            ), */
                            DataCell(
                              Text(NumberFormat.currency(
                                      locale: 'en_US', symbol: r'$')
                                  .format(e.to)),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (devolucio.cab.id == 0) ...{
                        TextButton(
                          onPressed: () async {
                            if (devolucio.detalles.isNotEmpty) {
                              devolucio.cab.fecha =
                                  selectedDate.toIso8601String();
                              if (tipoDevSelect == "PROVEEDOR") {
                                await devolucio.guardarDevolucion("P");
                                devolucio.detalles.forEach((element) async {
                                  element.productos.cantidad =
                                      element.cantidad.toDouble();
                                  element.productos.precio =
                                      element.total.toDouble();
                                  await kardex.devolucionesProveedor(
                                      element.productos, selectedDate);
                                });
                              } else if (tipoDevSelect == "CLIENTE") {
                                await devolucio.guardarDevolucion("C");
                                devolucio.detalles.forEach((element) async {
                                  element.productos.cantidad =
                                      element.cantidad.toDouble();
                                  await kardex.devolucionesCliente(
                                      element.productos, selectedDate);
                                });
                              } else {
                                devolucio.msgError =
                                    "Seleccione Tipo de Devolución";
                              }

                              if (devolucio.msgError == "") {
                                await devolucio.getRegistrosDev(3);
                                ToastNotificationView.messageAccess('Generado');

                                NavigationService.replaceTo("/devoluciones");
                              } else {
                                // mensaje alerta
                              }
                            } else {
                              ToastNotificationView.messageWarning(
                                  'Lista vacia');
                            }
                          },
                          child: Text("Guardar"), // cliente
                        ),
                      },
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
          ),
          // TextFormField(
          //   decoration: InputDecoration(labelText: "Cliente"),
          // ),
        ],
      ),
    );
  }
}
