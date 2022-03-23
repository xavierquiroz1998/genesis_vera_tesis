import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/white_card.dart';

class ParametrosView extends StatefulWidget {
  const ParametrosView({Key? key}) : super(key: key);

  @override
  State<ParametrosView> createState() => _ParametrosViewState();
}

class _ParametrosViewState extends State<ParametrosView> {
  String numeros = r'^(?:\+|-)?\d+$';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: WhiteCard(
          title: "Parametros",
          child: Container(
            child: Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Center(child: Text("Estado A"))),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(numeros))
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Tiempo de clasificacion'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Center(child: Text("Estado B"))),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(numeros))
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Tiempo de clasificacion'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Center(child: Text("Estado C"))),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(numeros))
                          ],
                          decoration: InputDecoration(
                              hintText: 'Tiempo de clasificacion'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
