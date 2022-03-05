import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/estaticas.dart';
import '../../../domain/entities/tipo/tipo_producto.dart';
import '../../../domain/providers/dashboard/dashboard_provider.dart';
import '../../style/custom_inputs.dart';
import '../../widgets/white_card.dart';

class DashboardProducto extends StatelessWidget {
  const DashboardProducto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<DashboardProvider>(context);
    return WhiteCard(
        child: Column(
      children: [
        Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 300, minWidth: 100),
            child: DropdownButtonFormField<TipoProducto>(
              onChanged: (value) {
                prov.cargarLista(value!.codRef);
                //producto.product.tipoProdcuto = value!.codRef;
              },
              items: Estaticas.listTipoProduct.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item.nomPro,
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
        for (var item in prov.listProductos) ...{
          Card(
            elevation: 10,
            child: Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${item.descripcion}"),
                  ),
                ],
              ),
            ),
          ),
        },

        // Container(
        //   width: double.infinity,
        //   child: DataTable(
        //     columns: <DataColumn>[
        //       const DataColumn(
        //         label: Center(child: Text("Id")),
        //       ),
        //       const DataColumn(
        //         label: Center(child: Text("Producto")),
        //       ),
        //       const DataColumn(
        //         label: Center(child: Text("Stock")),
        //       ),
        //       const DataColumn(
        //         label: Center(child: Text("Precio")),
        //       ),
        //     ],
        //     rows: prov.listProductos.map<DataRow>((e) {
        //       return DataRow(
        //         //key: LocalKey(),
        //         cells: <DataCell>[
        //           DataCell(
        //             Text(e.id.toString()),
        //           ),
        //           DataCell(
        //             Text(e.descripcion.toString()),
        //           ),
        //           DataCell(
        //             Text(e.stock!.toString()),
        //           ),
        //           DataCell(
        //             Text(e.precio.toString()),
        //           ),
        //         ],
        //       );
        //     }).toList(),
        //   ),
        // ),
      ],
    ));
  }
}
