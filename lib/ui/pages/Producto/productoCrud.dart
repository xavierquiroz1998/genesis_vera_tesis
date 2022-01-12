import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/tipo/tipo_producto.dart';
import 'package:genesis_vera_tesis/domain/entities/unidad_medida/unidadMedida.dart';
import 'package:genesis_vera_tesis/domain/providers/kardex/kardex_provider.dart';
import 'package:genesis_vera_tesis/domain/providers/productosProvider.dart';
import 'package:genesis_vera_tesis/ui/style/custom_inputs.dart';
import 'package:genesis_vera_tesis/ui/widgets/toast_notification.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:provider/provider.dart';

class ProductoCrud extends StatefulWidget {
  ProductoCrud({Key? key}) : super(key: key);

  @override
  _ProductoCrudState createState() => _ProductoCrudState();
}

class _ProductoCrudState extends State<ProductoCrud> {
  @override
  Widget build(BuildContext context) {
    final producto = Provider.of<ProductosProvider>(context);
    final kardex = Provider.of<KardexProvider>(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            WhiteCard(
                title: producto.product.id == null
                    ? "Nuevo Producto"
                    : "Modificar Producto",
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: producto.keyProducto,
                      child: Wrap(
                        children: [
                          Container(
                            constraints:
                                BoxConstraints(maxWidth: 300, minWidth: 100),
                            child: TextFormField(
                              controller: producto.controllerCodigo,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Ingrese Codigo";
                                }
                              },
                              decoration: CustomInputs.formInputDecoration(
                                  hint: 'Codigo',
                                  label: 'Codigo',
                                  icon: Icons.delete_outline),
                            ),
                          ),
                          Container(
                            constraints:
                                BoxConstraints(maxWidth: 300, minWidth: 100),
                            child: TextFormField(
                              onChanged: (value) {
                                // metodo de calcular
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Ingrese Codigo";
                                }
                              },
                              controller: producto.controllerStock,
                              decoration: CustomInputs.formInputDecoration(
                                  hint: 'Stock',
                                  label: 'Stock',
                                  icon: Icons.delete_outline),
                            ),
                          ),
                          Container(
                            constraints:
                                BoxConstraints(maxWidth: 300, minWidth: 100),
                            child: TextFormField(
                              onChanged: (value) {
                                try {
                                  // calcular
                                } catch (e) {}
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Ingrese Codigo";
                                }
                              },
                              controller: producto.controllerPrecio,
                              decoration: CustomInputs.formInputDecoration(
                                  hint: 'Precio',
                                  label: 'Precio',
                                  icon: Icons.delete_outline),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Wrap(
                      children: [
                        Container(
                          constraints:
                              BoxConstraints(maxWidth: 300, minWidth: 100),
                          child: TextFormField(
                            controller: producto.controllerDescripcion,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Ingrese Codigo";
                              }
                            },
                            decoration: CustomInputs.formInputDecoration(
                                hint: 'Descripcion',
                                label: 'Descripcion',
                                icon: Icons.delete_outline),
                          ),
                        ),
                        Container(
                          constraints:
                              BoxConstraints(maxWidth: 300, minWidth: 100),
                          child: DropdownButtonFormField<UnidadMedida>(
                            onChanged: (value) {
                              producto.product.unidadMedida = value!.id;
                            },
                            items: Estaticas.unidades.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item.descripcion!,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    )),
                              );
                            }).toList(),
                            decoration: CustomInputs.formInputDecoration(
                                hint: '',
                                label: 'Seleccion unidad Medida',
                                icon: Icons.delete_outline),
                          ),
                        ),
                        Container(
                          constraints:
                              BoxConstraints(maxWidth: 300, minWidth: 100),
                          child: DropdownButtonFormField<TipoProducto>(
                            onChanged: (value) {
                              producto.product.tipoProdcuto = value!.codRef;
                            },
                            items: Estaticas.listTipoProduct.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item.nomPro,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    )),
                              );
                            }).toList(),
                            decoration: CustomInputs.formInputDecoration(
                                hint: '',
                                label: 'Seleccione Tipo Producto',
                                icon: Icons.delete_outline),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    final otra = Estaticas.listProductos
                        .where((element) =>
                            element.codigo == producto.controllerCodigo.text)
                        .toList();
                    final opt = await producto.guardar();

                    if (opt != null) {
                      kardex.entradas(opt, true);
                      kardex.existencias(opt, true, otra.isEmpty);
                      kardex.impresion();

                      Navigator.pop(context);
                    } else {
                      ToastNotificationView.messageDanger('Error');
                    }
                  },
                  child: Text("Guardar"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancelar"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
