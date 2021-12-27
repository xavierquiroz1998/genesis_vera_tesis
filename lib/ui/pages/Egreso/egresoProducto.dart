import 'package:flutter/material.dart';
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
          TextFormField(
            decoration: InputDecoration(labelText: "Cliente"),
          ),
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
                    // combo(
                    //   provider: egreso,
                    //   idprd: e.idProducto ?? 0,
                    // ),
                    TextFormField(
                      onChanged: (value) {
                        e.idProducto = int.parse(value);
                      },
                    ),
                  ),
                  DataCell(
                    Text(e.detalle.toString()),
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

class combo extends StatefulWidget {
  combo({
    Key? key,
    required this.provider,
    required this.idprd,
  }) : super(key: key);

  EProductoProvider provider;
  int idprd;

  @override
  _comboState createState() => _comboState();
}

class _comboState extends State<combo> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Productos>(
      items: Estaticas.listProductos
          .map(
            (eDrop) => DropdownMenuItem<Productos>(
              child: Text(eDrop.descripcion!),
              value: new Productos(precio: 0),
            ),
          )
          .toList(),
      onChanged: (prod) {
        widget.provider.prd = prod!;
        widget.idprd = prod.id!;
      },
      //value: new Productos(precio: 0),
      hint: widget.provider.prd.id == null
          ? Text("Selecciones")
          : Text("${widget.provider.prd.descripcion}"),
    );
  }
}
