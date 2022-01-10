import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/ui/widgets/white_card.dart';

class KardexLayout extends StatelessWidget {
  const KardexLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: "Kardex",
            child: Column(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
