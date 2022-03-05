import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';

class NoPageFoundView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      child: Center(
        child: Text(
          '404 - Página no encontrada',
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
