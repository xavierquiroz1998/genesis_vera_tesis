import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../domain/providers/parametros/provider_parametros.dart';
import '../../widgets/white_card.dart';

class ParametrosView extends StatefulWidget {
  const ParametrosView({Key? key}) : super(key: key);

  @override
  State<ParametrosView> createState() => _ParametrosViewState();
}

class _ParametrosViewState extends State<ParametrosView> {
  String numeros = r'^(?:\+|-)?\d+$';

  @override
  void initState() {
    Provider.of<ParametrosPRovider>(context, listen: false).getAllParametros();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provi = Provider.of<ParametrosPRovider>(context);
    return Container(
      child: WhiteCard(
          title: "Categorizaciòn en dìas",
          child: Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      for (var item in provi.listadoParametros) ...{
                        Row(
                          children: [
                            Expanded(
                                child: Center(
                                    child: Text("Tipo ${item.detalle}"))),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                initialValue: item.holgura.toString(),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(numeros))
                                ],
                                onChanged: (value) {
                                  item.holgura = int.tryParse(value) ?? 0;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: 'Tiempo de clasificaciòn (dìas)'),
                              ),
                            ),
                          ],
                        ),
                      },
                      // Row(
                      //   children: [
                      //     Expanded(child: Center(child: Text("Estado B"))),
                      //     Expanded(
                      //       flex: 3,
                      //       child: TextField(
                      //         inputFormatters: [
                      //           FilteringTextInputFormatter.allow(RegExp(numeros))
                      //         ],
                      //         keyboardType: TextInputType.number,
                      //         decoration: InputDecoration(
                      //             hintText: 'Tiempo de clasificacion'),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   children: [
                      //     Expanded(child: Center(child: Text("Estado C"))),
                      //     Expanded(
                      //       flex: 3,
                      //       child: TextField(
                      //         inputFormatters: [
                      //           FilteringTextInputFormatter.allow(RegExp(numeros))
                      //         ],
                      //         decoration: InputDecoration(
                      //             hintText: 'Tiempo de clasificacion'),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await provi.updateParametros();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    "Guardar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          )
          //  ListView(
          //   children: [
          //     Row(
          //       children: [
          //         Text("Estado A"),
          //         TextFormField(
          //           decoration: InputDecoration(hintText: "Tiempo de olgura"),
          //         )
          //       ],
          //     ),
          //     // Row(
          //     //   children: [
          //     //     Text("Estado B"),
          //     //     TextFormField(
          //     //       decoration: InputDecoration(hintText: "Tiempo de olgura"),
          //     //     )
          //     //   ],
          //     // ),
          //     // Row(
          //     //   children: [
          //     //     Text("Estado C"),
          //     //     TextFormField(
          //     //       decoration: InputDecoration(hintText: "Tiempo de olgura"),
          //     //     )
          //     //   ],
          //     // ),
          //   ],
          // ),

          ),
    );
  }
}
