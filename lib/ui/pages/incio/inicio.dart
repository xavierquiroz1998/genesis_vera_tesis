import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';

class Inicio extends StatelessWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      title: "Inicio",
      child: Container(
        child: Center(
          child: Text("-------------------------"),
        ),
      ),
    );
  }
}
