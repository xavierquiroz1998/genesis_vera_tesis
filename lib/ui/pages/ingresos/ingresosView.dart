import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';

import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/providers/kardex/kardex_provider.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:provider/provider.dart';

import '../../../domain/providers/ingreso/ingresosProvider.dart';

class IngresoView extends StatefulWidget {
  const IngresoView({Key? key}) : super(key: key);

  @override
  State<IngresoView> createState() => _IngresoViewState();
}

class _IngresoViewState extends State<IngresoView> {
  @override
  void initState() {
    var temProvider = Provider.of<IngresosProvider>(context, listen: false);
    temProvider.cargarPrd();
    if (temProvider.cab.id != 0) {
      temProvider.cargarDetalle(temProvider.cab.id);
    }
    super.initState();
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
                TextFormField(
                  initialValue: ingreso.ctrObservacion.text,
                  decoration: InputDecoration(labelText: "Observacion"),
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
                    rows: ingreso.detalles.map<DataRow>((e) {
                      return DataRow(
                        //key: LocalKey(),
                        cells: <DataCell>[
                          DataCell(
                            DropdownButton<Productos>(
                              items: ingreso.listado
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
                              initialValue: e.cantidad.toString(),
                              onChanged: (value) {
                                e.cantidad = int.parse(value);
                                ingreso.calcular();
                              },
                            ),
                          ),
                          DataCell(
                            TextFormField(
                              initialValue: e.total.toString(),
                              onChanged: (value) {
                                e.to = double.parse(value);
                                ingreso.calcular();
                                //e.total = e.cantidad * e.precio!;
                              },
                            ),
                          ),
                          DataCell(
                            Text(e.to.toString()),
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
                        if (ingreso.cab.id == 0) {
                          await ingreso.guardarIngresos();
                        } else {
                          await ingreso.actualizar();
                        }

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
