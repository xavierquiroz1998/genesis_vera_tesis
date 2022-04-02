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

  @override
  void initState() {
    final cargaPRd = Provider.of<ProductosProvider>(context, listen: false);
    cargaPRd.cargarUnidades();
    cargaPRd.cargarGrupo();
    cargaPRd.cargarProveedores();
    if (cargaPRd.product.id != 0) {}
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
                                hint: '',
                                label: 'Seleccion unidad Medida',
                                icon: Icons.delete_outline),
                          ),
                        ),
                        Container(
                          constraints:
                              BoxConstraints(maxWidth: 300, minWidth: 100),
                          child: DropdownButtonFormField<GrupoEntity>(
                            onChanged: (value) {
                              producto.product.idGrupo = value!.id;
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
                                hint: '',
                                label: 'Seleccione Tipo Producto',
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
                                hint: '',
                                label: 'Seleccione Proveedor',
                                icon: Icons.delete_outline),
                          ),
                        ),
                        Container(
                          constraints:
                              BoxConstraints(maxWidth: 300, minWidth: 100),
                          child: TextFormField(
                            controller: producto.controllerHolgura,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Ingrese Holgura";
                              }
                            },
                            decoration: CustomInputs.formInputDecoration(
                                hint: 'Holgura',
                                label: 'Tiempo de Holgura',
                                icon: Icons.info),
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

                      await kardex.entradas(opt, otra.isNotEmpty, true);
                      /* kardex.existencias(opt, true, otra.isEmpty); */
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
