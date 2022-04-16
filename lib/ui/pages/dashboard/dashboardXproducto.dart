import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/tipo/grupo.dart';
import '../../../domain/providers/dashboard/dashboard_provider.dart';
import '../../../domain/providers/productosProvider.dart';
import '../../style/custom_inputs.dart';
import '../../widgets/white_card.dart';

class DashboardProducto extends StatefulWidget {
  const DashboardProducto({Key? key}) : super(key: key);

  @override
  State<DashboardProducto> createState() => _DashboardProductoState();
}

class _DashboardProductoState extends State<DashboardProducto> {
  @override
  void initState() {
    var temp = Provider.of<DashboardProvider>(context, listen: false);
    temp.listGrupos = [];
    temp.listProductos = [];
    temp.cargarGrupo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<DashboardProvider>(context);
    final produc = Provider.of<ProductosProvider>(context);
    return WhiteCard(
        child: Column(
      children: [
        Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 300, minWidth: 100),
            child: DropdownButtonFormField<GrupoEntity>(
              onChanged: (value) async {
                await produc.calculos();

                await prov.cargarLista(value!.id, produc.aprovisionamientos);
                //producto.product.tipoProdcuto = value!.codRef;
              },
              items: prov.listGrupos.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item.nombre,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      )),
                );
              }).toList(),
              decoration: CustomInputs.formInputDecoration(
                  hint: '',
                  label: 'Seleccione Tipo Producto',
                  icon: Icons.delete_outline),
            ),
          ),
        ),
        // for (var item in prov.listProductos) ...{
        //   Card(
        //     elevation: 10,
        //     child: Container(
        //       child: Row(
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Text("${item.detalle}"),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // },

        Container(
          width: double.infinity,
          child: DataTable(
            columns: <DataColumn>[
              // const DataColumn(
              //   label: Center(child: Text("Id")),
              // ),
              const DataColumn(
                label: Center(child: Text("Producto")),
              ),
              const DataColumn(
                label: Center(child: Text("Stock")),
              ),
              const DataColumn(
                label: Center(child: Text("Pedido")),
              ),
              const DataColumn(
                label: Center(child: Text("Cobertura/Días")),
              ),
              // const DataColumn(
              //   label: Center(child: Text("Precio")),
              // ),
            ],
            rows: prov.listProductos.map<DataRow>((e) {
              return DataRow(
                //key: LocalKey(),
                cells: <DataCell>[
                  // DataCell(
                  //   Text(e.id.toString()),
                  // ),
                  DataCell(
                    Text(e.detalle.toString()),
                  ),
                  DataCell(
                    Text(e.cantidad.toString()),
                  ),
                  DataCell(
                    Text(e.pedido.toString()),
                  ),
                  DataCell(
                    Text(e.dias.toString()),
                  ),
                  // DataCell(
                  //   Text(e.precio.toString()),
                  // ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    ));
  }
}
