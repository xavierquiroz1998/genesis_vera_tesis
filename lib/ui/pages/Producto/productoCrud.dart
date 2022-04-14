import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesis_vera_tesis/data/services/Navigation/NavigationService.dart';
import 'package:genesis_vera_tesis/domain/entities/tipo/grupo.dart';
import 'package:genesis_vera_tesis/domain/entities/unidad_medida/unidadMedida.dart';
import 'package:genesis_vera_tesis/domain/providers/kardex/kardex_provider.dart';
import 'package:genesis_vera_tesis/domain/providers/productosProvider.dart';
import 'package:genesis_vera_tesis/ui/style/custom_inputs.dart';
import 'package:genesis_vera_tesis/ui/widgets/toast_notification.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/Proveedores/Proveedores.dart';
import '../../../domain/entities/productos.dart';
import '../../../domain/services/codRef.dart';

class ProductoCrud extends StatefulWidget {
  ProductoCrud({Key? key}) : super(key: key);

  @override
  _ProductoCrudState createState() => _ProductoCrudState();
}

class _ProductoCrudState extends State<ProductoCrud> {
  List<String> tipoDev = ["A", "B", "C"];
  DateTime selectedDate = new DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  final keyProducto = GlobalKey<FormState>();
  @override
  void initState() {
    final cargaPRd = Provider.of<ProductosProvider>(context, listen: false);
    cargaPRd.cargarUnidades();
    cargaPRd.cargarGrupo();
    cargaPRd.cargarProveedores();
    if (cargaPRd.product.id != 0) {
      var asd = DateTime.tryParse(cargaPRd.product.fecha);
      if (asd != null) {
        selectedDate = asd;
      }
      cargaPRd.cargarDetalle();
      cargaPRd.generar(int.parse(cargaPRd.product.referencia));
    } else {
      cargaPRd.generar();
    }
    super.initState();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        //_dateController.text = DateFormat.yMd().format(selectedDate);
      });
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
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Fecha"),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await _selectDate(context);
                          },
                          child: Container(
                            child: Text("${formatter.format(selectedDate)}"),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
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
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(Helper.soloNumeros))
                              ],
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
                                  return "Ingrese Precio Unitario";
                                }
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(Helper.decimales))
                              ],
                              controller: producto.controllerPrecio,
                              decoration: CustomInputs.formInputDecoration(
                                  hint: 'Costo',
                                  label: 'Costo',
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
                if (producto.product.id == 0) ...{
                  TextButton(
                    onPressed: () async {
                      // final opt = await producto
                      //     .guardar(otra.isNotEmpty ? otra.first : null);

                      if (int.parse(producto.controllerStock.text == ""
                                  ? "0"
                                  : producto.controllerStock.text) >
                              0 &&
                          int.parse(producto.controllerPrecio.text == ""
                                  ? "0"
                                  : producto.controllerPrecio.text) >
                              0) {
                        Productos? opt;
                        print("...........${producto.product.lote}");

                        producto.product.fecha = formatter.format(selectedDate);
                        print("Fecha ${producto.product.fecha}");
                        if (producto.product.id == 0) {
                          opt = await producto.guardar(producto.product);
                        } else {
                          print("----------ipdate ");
                          opt = await producto.actualizar(producto.product);
                        }

                        if (opt != null) {
                          // AwesomeDialog(
                          //   context: context,
                          //   dialogType: DialogType.SUCCES,
                          //   animType: AnimType.BOTTOMSLIDE,
                          //   title: 'Guardado Correctamente',
                          //   desc: '',
                          //   btnOkOnPress: () {},
                          // )..show();
                          try {
                            await kardex.entradas(
                                opt, false, true, selectedDate);

                            kardex.impresion();
                          } catch (ex) {
                            print(
                                "Erro en guardar entrada kardex ${ex.toString()}");
                          }

                          NavigationService.replaceTo("/ingresos");
                        } else {
                          ToastNotificationView.messageDanger('Error');
                        }
                      } else {
                        print('Cantidad o costo no pueden ser menor a 1');
                      }
                    },
                    child: Text("Guardar"),
                  ),
                },
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
