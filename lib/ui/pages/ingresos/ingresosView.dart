import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';

import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/providers/kardex/kardex_provider.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/providers/ingreso/ingresosProvider.dart';
import '../../style/custom_inputs.dart';

class IngresoView extends StatefulWidget {
  const IngresoView({Key? key}) : super(key: key);

  @override
  State<IngresoView> createState() => _IngresoViewState();
}

class _IngresoViewState extends State<IngresoView> {
  DateTime selectedDate = new DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    var temProvider = Provider.of<IngresosProvider>(context, listen: false);
    temProvider.cargarPrd();
    if (temProvider.cab.id != 0) {
      var asd = DateTime.tryParse(temProvider.cab.fecha);
      if (asd != null) {
        selectedDate = asd;
      }
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

  @override
  Widget build(BuildContext context) {
    final ingreso = Provider.of<IngresosProvider>(context);
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
                    Text("NI-${ingreso.codRef}"),
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
                  initialValue: ingreso.ctrObservacion.text,
                  decoration: InputDecoration(labelText: "Observación"),
                  onChanged: (value) {
                    ingreso.ctrObservacion.text = value;
                  },
                ),
                TextButton(
                  onPressed: () {
                    ingreso.agregar();
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
                        label: Center(child: Text("Lote")),
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
                      const DataColumn(
                        label: Center(child: Text("")),
                      ),
                    ],
                    rows: ingreso.detalles.map<DataRow>((e) {
                      return DataRow(
                        //key: LocalKey(),
                        cells: <DataCell>[
                          DataCell(
                            DropdownButton<Productos>(
                              items: ingreso.listado
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
                          ),
                          DataCell(Text(e.lote)),
                          DataCell(
                            TextFormField(
                              initialValue: e.cantidad.toString(),
                              onChanged: (value) {
                                e.cantidad = int.parse(value);
                                ingreso.calcular();
                              },
                            ),
                          ),
                          DataCell(
                            TextFormField(
                              /*     // initialValue: NumberFormat.currency(
                                      locale: 'en_US', symbol: r'$')
                                  .format(e.total), */
                              initialValue: e.total.toString(),
                              onChanged: (value) {
                                e.total = double.parse(value);
                                ingreso.calcular();
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
                            ingreso.remover(e);
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
                        ingreso.cab.fecha = selectedDate.toIso8601String();
                        if (ingreso.cab.id == 0) {
                          await ingreso.guardarIngresos();
                        } else {
                          await ingreso.actualizar();
                        }
                        try {
                          for (var item in ingreso.detalles) {
                            item.productos!.cantidad = item.cantidad.toDouble();
                            item.productos!.precio = item.total;
                            await kardex.entradas(item.productos!, true, true);
                          }
                        } catch (ex) {
                          print("Erro en ingresar kardex ${ex.toString()}");
                        }

                        // AwesomeDialog(
                        //   context: context,
                        //   dialogType: DialogType.SUCCES,
                        //   animType: AnimType.BOTTOMSLIDE,
                        //   title: 'Guardado Correctamente',
                        //   desc: '',
                        // )..show();
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
                        NavigationService.replaceTo("/ingresoss");
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
