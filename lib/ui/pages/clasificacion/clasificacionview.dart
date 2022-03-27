import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/providers/productosProvider.dart';
import '../../widgets/white_card.dart';

class ClasificacionView extends StatefulWidget {
  const ClasificacionView({Key? key}) : super(key: key);

  @override
  State<ClasificacionView> createState() => _ClasificacionViewState();
}

class _ClasificacionViewState extends State<ClasificacionView> {
  @override
  void initState() {
    Provider.of<ProductosProvider>(context, listen: false).calculos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final producto = Provider.of<ProductosProvider>(context);
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: "Clasificacion de Productos",
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: DataTable(
                    columns: <DataColumn>[
                      const DataColumn(
                        label: Center(child: Text("Id Producto")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Nombre Producto")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Total")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Clasificacion")),
                      ),
                    ],
                    rows: producto.lisCla.map<DataRow>((e) {
                      return DataRow(
                        //key: LocalKey(),
                        cells: <DataCell>[
                          DataCell(
                            Text(e.idProducto.toString()),
                          ),
                          DataCell(
                            Text(e.detalle.toString()),
                          ),
                          DataCell(Text(e.promedio.toString())),
                          DataCell(Text(e.clasificacion.toString())),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          WhiteCard(
            title: "Aprovisionamiento de productos",
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: DataTable(
                    columns: <DataColumn>[
                      const DataColumn(
                        label: Center(child: Text("Id Producto")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Nombre Producto")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Total")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Clasificacion")),
                      ),
                      const DataColumn(
                        label: Center(child: Text("Aprovisionar")),
                      ),
                    ],
                    rows: producto.aprovisionamientos.map<DataRow>((e) {
                      return DataRow(
                        //key: LocalKey(),
                        cells: <DataCell>[
                          DataCell(
                            Text(e.idProducto.toString()),
                          ),
                          DataCell(
                            Text(e.detalle.toString()),
                          ),
                          DataCell(Text(e.promedio.toString())),
                          DataCell(Text(e.clasificacion.toString())),
                          DataCell(Text(e.stockSeguridad.toString())),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
