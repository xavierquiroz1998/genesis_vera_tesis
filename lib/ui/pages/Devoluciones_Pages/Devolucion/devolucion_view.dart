import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/Devoluciones/devoluciones_entity.dart';
import 'package:provider/provider.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/providers/Devoluciones/devolucionProvider.dart';

class DevolucionView extends StatefulWidget {
  DevolucionView({Key? key}) : super(key: key);

  Productos prdSelect = new Productos(precio: 0);

  @override
  State<DevolucionView> createState() => _DevolucionViewState();
}

class _DevolucionViewState extends State<DevolucionView> {
  @override
  Widget build(BuildContext context) {
    final devolucio = Provider.of<DevolucionProvider>(context);
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: devolucio.devolucion.idDevolucion == null
                ? "Nueva Devolucion"
                : "Modificar Devolucion",
            child: Column(
              children: [
                TextFormField(
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
                    rows: devolucio.listaDevolucion.map<DataRow>((e) {
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
                                widget.prdSelect = value!;
                                setState(() {});
                              },
                              hint: e.idProducto == null
                                  ? Text("Seleccione Producto")
                                  : Text("${widget.prdSelect.descripcion}"),
                            ),
                            // Combo(
                            //   provider: devolucio,
                            //   devolucionProd: e,
                            // ),
                          ),
                          DataCell(
                            TextFormField(
                              onChanged: (value) {
                                e.detalle = value;
                              },
                            ),
                          ),
                          DataCell(
                            TextFormField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                e.cantidad = int.tryParse(value!);
                                devolucio.calcularTotal();
                              },
                            ),
                          ),
                          DataCell(
                            TextFormField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                e.precio = double.tryParse(value!);
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
                        if (devolucio.msgError == "") {
                          Navigator.pop(context);
                        } else {
                          // mensaje alerta
                        }
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

class Combo extends StatefulWidget {
  Combo({
    Key? key,
    required this.provider,
    required this.devolucionProd,
  }) : super(key: key);

  DevolucionProvider provider;
  DevolucionesEntity devolucionProd;
  Productos prdSelect = new Productos(precio: 0);

  @override
  _ComboState createState() => _ComboState();
}

class _ComboState extends State<Combo> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Productos>(
      items: Estaticas.listProductos
          .map(
            (eDrop) => DropdownMenuItem<Productos>(
              child: Text(eDrop.descripcion!),
              value: eDrop,
            ),
          )
          .toList(),
      onChanged: (value) {
        widget.devolucionProd.idProducto = value?.id;
        widget.prdSelect = value!;
        setState(() {});
      },
      hint: widget.prdSelect.id == null
          ? Text("Seleccione Producto")
          : Text("${widget.prdSelect.descripcion}"),
    );
  }
}
