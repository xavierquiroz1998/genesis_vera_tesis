import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/egreso/egresoProducto.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:collection/collection.dart';

import '../../../widgets/white_card.dart';

class PieDefault extends StatefulWidget {
  const PieDefault({Key? key}) : super(key: key);

  @override
  _PieDefaultState createState() => _PieDefaultState();
}

class _PieDefaultState extends State<PieDefault> {
  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      title: "Reporte",
      child: Column(
        children: [
          SfCircularChart(
            title: ChartTitle(text: 'Productos'),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CircularSeries>[
              PieSeries<Productos, String>(
                  dataSource: Estaticas.listProductos,
                  xValueMapper: (Productos data, _) => data.descripcion,
                  yValueMapper: (Productos data, _) => data.stock,
                  dataLabelSettings: DataLabelSettings(isVisible: true)),
            ],
          )
        ],
      ),
    );
  }
}

class PieVentas extends StatefulWidget {
  const PieVentas({Key? key}) : super(key: key);

  @override
  State<PieVentas> createState() => _PieVentasState();
}

class _PieVentasState extends State<PieVentas> {
  List<EgresoDetalle> temp = [];

  @override
  void initState() {
    super.initState();

    var asd = Estaticas.listProductosEgreso.groupListsBy(
      (e) => e.idEgreso,
    );

    for (var item in asd.entries) {
      EgresoDetalle t = new EgresoDetalle();
      t.idEgresoDetalle = item.key;
      for (var cabe in item.value) {
        for (var det in cabe.detalle!) {
          t.cantidad += det.cantidad;
        }
      }
      temp.add(t);
    }

    for (var item in temp) {
      item.prd =
          Estaticas.listProductos.firstWhere((e) => e.id == item.idProducto);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      title: "Salida de Productos",
      child: Column(
        children: [
          SfCircularChart(
            title: ChartTitle(text: 'Ventas'),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CircularSeries>[
              PieSeries<EgresoDetalle, String>(
                  dataSource: temp,
                  xValueMapper: (EgresoDetalle data, _) =>
                      data.prd!.descripcion,
                  yValueMapper: (EgresoDetalle data, _) => data.cantidad,
                  dataLabelSettings: DataLabelSettings(isVisible: true)),
            ],
          )
        ],
      ),
    );
  }
}
