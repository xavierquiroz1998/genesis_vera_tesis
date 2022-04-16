import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../domain/providers/productosProvider.dart';
import '../../widgets/white_card.dart';

class DashboardClasificacion extends StatefulWidget {
  DashboardClasificacion({Key? key}) : super(key: key);

  @override
  State<DashboardClasificacion> createState() => _DashboardClasificacionState();
}

class _DashboardClasificacionState extends State<DashboardClasificacion> {
  @override
  void initState() {
    Provider.of<ProductosProvider>(context, listen: false).calculos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final producto = Provider.of<ProductosProvider>(context);
    return producto.aprovisionamientos.length > 0
        ? WhiteCard(
            // title: "C",
            child: Column(
              children: [
                SfCircularChart(
                  title: ChartTitle(
                    text: 'Clasificación de los Productos',
                    alignment: ChartAlignment.near,
                  ),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CircularSeries>[
                    PieSeries<Aprovisionar, String>(
                        dataSource: producto.clasificaciones,
                        xValueMapper: (Aprovisionar data, _) =>
                            data.clasificacion,
                        yValueMapper: (Aprovisionar data, _) => data.total,
                        dataLabelSettings: DataLabelSettings(isVisible: true)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text("A"),
                        SizedBox(
                          height: 15,
                        ),
                        for (var item in producto.aprovisionamientos
                            .where((e) => e.clasificacion == "A")) ...{
                          SizedBox(
                            height: 10,
                          ),
                          Text("${item.detalle}")
                        }
                      ],
                    ),
                    Column(
                      children: [
                        Text("B"),
                        SizedBox(
                          height: 15,
                        ),
                        for (var item in producto.aprovisionamientos
                            .where((e) => e.clasificacion == "B")) ...{
                          SizedBox(
                            height: 10,
                          ),
                          Text("${item.detalle}")
                        }
                      ],
                    ),
                    Column(
                      children: [
                        Text("C"),
                        SizedBox(
                          height: 15,
                        ),
                        for (var item in producto.aprovisionamientos
                            .where((e) => e.clasificacion == "C")) ...{
                          SizedBox(
                            height: 10,
                          ),
                          Text("${item.detalle}")
                        }
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        : Container();
  }
}
