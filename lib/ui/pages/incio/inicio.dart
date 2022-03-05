import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/ui/pages/dashboard/Report/graficos_productos.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';

class Inicio extends StatelessWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      title: "Inicio",
      child: Row(
        children: [
          if (Estaticas.listProductos.length > 0) ...{
            PieDefault(),
          },
          if (Estaticas.listProductosEgreso.length > 0) ...{
            PieVentas(),
          }
        ],
      ),
    );
  }
}
