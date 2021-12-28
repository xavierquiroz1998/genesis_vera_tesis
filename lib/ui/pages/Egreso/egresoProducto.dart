import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/egreso/egresoProducto.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:genesis_vera_tesis/domain/providers/egreso/e_productoProvider.dart';
import 'package:provider/provider.dart';

class EgresoProducto extends StatelessWidget {
  const EgresoProducto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final egreso = Provider.of<EProductoProvider>(context);
    return Container(
      child: ListView(
        children: [
          // TextFormField(
          //   decoration: InputDecoration(labelText: "Cliente"),
          // ),
          TextFormField(
            decoration: InputDecoration(labelText: "Observacion"),
          ),
          TextButton(
            onPressed: () {
              egreso.agregar();
            },
            child: Text("Agregar"),
          ),
          DataTable(
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
            rows: egreso.listaProducto.map<DataRow>((e) {
              return DataRow(
                //key: LocalKey(),
                cells: <DataCell>[
                  DataCell(
                    Combo(
                      provider: egreso,
                      egresoProd: e,
                    ),
                    // TextFormField(
                    //   onChanged: (value) {
                    //     e.idProducto = int.parse(value);
                    //   },
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
                      onChanged: (value) {
                        e.cantidad = int.parse(value);
                      },
                    ),
                  ),
                  DataCell(
                    TextFormField(
                      onChanged: (value) {
                        e.precio = double.parse(value);
                        e.total = e.cantidad! * e.precio!;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  egreso.guardarEgreso();
                  Navigator.pop(context);
                },
                child: Text("Guardar"),
              ),
              TextButton(
                onPressed: () {},
                child: Text("Cancelar"),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Combo extends StatefulWidget {
  Combo({
    Key? key,
    required this.provider,
    required this.egresoProd,
  }) : super(key: key);

  EProductoProvider provider;
  EgresoDetalle egresoProd;
  Productos prdSelect = new Productos(precio: 0);

  @override
  _comboState createState() => _comboState();
}

class _comboState extends State<Combo> {
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
        //widget.provider.prd = prod!;
        //widget.idprd = prod.id!;
        widget.egresoProd.idProducto = value?.id;
        widget.prdSelect = value!;
        setState(() {});
      },
      //value: new Productos(precio: 0),
      hint: widget.prdSelect.id == null
          ? Text("Seleccione Producto")
          : Text("${widget.prdSelect.descripcion}"),
    );
  }
}
