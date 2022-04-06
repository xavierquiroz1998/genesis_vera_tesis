import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/tipo/grupo.dart';
import 'package:genesis_vera_tesis/domain/entities/unidad_medida/unidadMedida.dart';
import 'package:genesis_vera_tesis/domain/providers/kardex/kardex_provider.dart';
import 'package:genesis_vera_tesis/domain/providers/productosProvider.dart';
import 'package:genesis_vera_tesis/ui/style/custom_inputs.dart';
import 'package:genesis_vera_tesis/ui/widgets/toast_notification.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/Proveedores/Proveedores.dart';
import '../../../domain/entities/productos.dart';

class ProductoCrud extends StatefulWidget {
  ProductoCrud({Key? key}) : super(key: key);

  @override
  _ProductoCrudState createState() => _ProductoCrudState();
}

class _ProductoCrudState extends State<ProductoCrud> {
  List<String> tipoDev = ["A", "B", "C"];
  final keyProducto = GlobalKey<FormState>();
  @override
  void initState() {
    final cargaPRd = Provider.of<ProductosProvider>(context, listen: false);
    cargaPRd.cargarUnidades();
    cargaPRd.cargarGrupo();
    cargaPRd.cargarProveedores();
    if (cargaPRd.product.id != 0) {
      cargaPRd.cargarDetalle();
    } else {
      cargaPRd.generar();
    }
    super.initState();
  }

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
                title: producto.product.id == 0
                    ? "Nuevo Producto"
                    : "Modificar Producto",
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text("Codigo Ref"),
                        SizedBox(
                          width: 20,
                        ),
                        Text("INP-${producto.codRef}"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Lote"),
                        SizedBox(
                          width: 20,
                        ),
                        Text("${producto.product.lote}"),
                      ],
                    ),
                    Form(
                      key: keyProducto,
                      child: Wrap(
                        children: [
                          // Container(
                          //   constraints:
                          //       BoxConstraints(maxWidth: 300, minWidth: 100),
                          //   child: TextFormField(
                          //     controller: producto.controllerCodigo,
                          //     validator: (value) {
                          //       if (value!.isEmpty) {
                          //         return "Ingrese Código";
                          //       }
                          //     },
                          //     decoration: CustomInputs.formInputDecoration(
                          //         hint: 'Código',
                          //         label: 'Código',
                          //         icon: Icons.delete_outline),
                          //   ),
                          // ),
                          Container(
                            constraints:
                                BoxConstraints(maxWidth: 300, minWidth: 100),
                            child: TextFormField(
                              onChanged: (value) {
                                // metodo de calcular
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Ingrese Cantidad";
                                }
                              },
                              controller: producto.controllerStock,
                              decoration: CustomInputs.formInputDecoration(
                                  hint: 'Cantidad a ingresar',
                                  label: 'Cantidad a ingresar',
                                  icon: Icons.delete_outline),
                            ),
                          ),
                          // Container(
                          //   constraints:
                          //       BoxConstraints(maxWidth: 300, minWidth: 100),
                          //   child: TextFormField(
                          //     onChanged: (value) {
                          //       producto.pedid = int.parse(value);
                          //     },
                          //     validator: (value) {
                          //       if (value!.isEmpty) {
                          //         return "Ingrese Maximo";
                          //       }
                          //     },
                          //     controller: producto.controllerStock,
                          //     decoration: CustomInputs.formInputDecoration(
                          //         hint: 'Maximo',
                          //         label: 'Maximo',
                          //         icon: Icons.delete_outline),
                          //   ),
                          // ),
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
                                  return "Ingrese Precio";
                                }
                              },
                              controller: producto.controllerPrecio,
                              decoration: CustomInputs.formInputDecoration(
                                  hint: 'Precio',
                                  label: 'Precio',
                                  icon: Icons.monetization_on),
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
                                return "Ingrese Descripción";
                              }
                            },
                            decoration: CustomInputs.formInputDecoration(
                                hint: 'Descripción',
                                label: 'Descripción',
                                icon: Icons.delete_outline),
                          ),
                        ),
                        Container(
                          constraints:
                              BoxConstraints(maxWidth: 300, minWidth: 100),
                          child: DropdownButtonFormField<UnidadMedidaEntity>(
                            onChanged: (value) {
                              producto.product.idUnidad = value!.id;
                            },
                            items: producto.listUnidades.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item.detalle,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    )),
                              );
                            }).toList(),
                            decoration: CustomInputs.formInputDecoration(
                                hint: producto.product.unidad != null
                                    ? "${producto.product.unidad!.detalle}"
                                    : '',
                                label: producto.product.unidad != null
                                    ? "${producto.product.unidad!.detalle}"
                                    : 'Seleccione unidad de Medida',
                                icon: Icons.delete_outline),
                          ),
                        ),
                        Container(
                          constraints:
                              BoxConstraints(maxWidth: 300, minWidth: 100),
                          child: DropdownButtonFormField<GrupoEntity>(
                            onChanged: (value) {
                              producto.product.idGrupo = value!.id;
                              producto.product.grupo = value;
                            },
                            items: producto.listGrupos.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item.nombre,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    )),
                              );
                            }).toList(),
                            decoration: CustomInputs.formInputDecoration(
                                hint: producto.product.grupo != null
                                    ? "${producto.product.grupo!.nombre}"
                                    : "",
                                label: producto.product.grupo != null
                                    ? "${producto.product.grupo!.nombre}"
                                    : 'Seleccione Tipo Producto',
                                icon: Icons.delete_outline),
                          ),
                        ),

                        // proveedor
                        Container(
                          constraints:
                              BoxConstraints(maxWidth: 300, minWidth: 100),
                          child: DropdownButtonFormField<ProveedoresEntity>(
                            onChanged: (value) {
                              producto.product.idProveedor = value!.id;
                            },
                            items: producto.listaProveedores.map((item) {
                              return DropdownMenuItem<ProveedoresEntity>(
                                value: item,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    item.nombre,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              );
                            }).toList(),
                            decoration: CustomInputs.formInputDecoration(
                                hint: producto.product.proveedor != null
                                    ? "${producto.product.proveedor!.nombre}"
                                    : '',
                                label: producto.product.proveedor != null
                                    ? "${producto.product.proveedor!.nombre}"
                                    : 'Seleccione Proveedor',
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
                    final otra = producto.listado
                        .where((element) =>
                            element.referencia ==
                            producto.controllerCodigo.text)
                        .toList();

                    // final opt = await producto
                    //     .guardar(otra.isNotEmpty ? otra.first : null);
                    Productos? opt;
                    if (producto.product.id == 0) {
                      opt = await producto.guardar(producto.product);
                    } else {
                      opt = await producto.actualizar(producto.product);
                    }

                    if (opt != null) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.SUCCES,
                        animType: AnimType.BOTTOMSLIDE,
                        title: 'Guardado Correctamente',
                        desc: '',
                        btnOkOnPress: () {},
                      )..show();
                      await kardex.entradas(opt!, true, true);

                      kardex.impresion();

                      NavigationService.replaceTo("/ingresos");
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
