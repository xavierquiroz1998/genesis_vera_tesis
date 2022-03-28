import 'package:flutter/material.dart';
import 'package:genesis_vera_tesis/domain/entities/egreso/egresoProducto.dart';
import 'package:genesis_vera_tesis/domain/entities/estaticas.dart';
import 'package:genesis_vera_tesis/domain/entities/productos.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:collection/collection.dart';

import '../../../../domain/providers/egreso/e_productoProvider.dart';
import '../../../../domain/providers/productosProvider.dart';
import '../../../widgets/white_card.dart';

class PieDefault extends StatefulWidget {
  const PieDefault({Key? key}) : super(key: key);

  @override
  _PieDefaultState createState() => _PieDefaultState();
}

class _PieDefaultState extends State<PieDefault> {
  @override
  void initState() {
    Provider.of<ProductosProvider>(context, listen: false).cargarPrd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final producto = Provider.of<ProductosProvider>(context);
    return producto.listado.length > 0
        ? WhiteCard(
            title: "Reporte",
            child: Column(
              children: [
                SfCircularChart(
                  title: ChartTitle(text: 'Productos'),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CircularSeries>[
                    PieSeries<Productos, String>(
                        dataSource: producto.listado.length > 5
                            ? producto.listado.sublist(0, 5)
                            : producto.listado,
                        xValueMapper: (Productos data, _) =>
                            data.detalle.length > 10
                                ? data.detalle.substring(0, 9)
                                : data.detalle,
                        yValueMapper: (Productos data, _) => data.cantidad,
                        dataLabelSettings: DataLabelSettings(isVisible: true)),
                  ],
                )
              ],
            ),
          )
        : Container();
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
    final egreso = Provider.of<EProductoProvider>(context, listen: false);
    egreso.getRegistrosDev();
    super.initState();

    var asd = egreso.listTableRegistrosDev.groupListsBy(
      (e) => e.id,
    );

    for (var item in asd.entries) {
      EgresoDetalle t = new EgresoDetalle();
      t.idEgresoDetalle = item.key;
      for (var cabe in item.value) {
        //t.cantidad += det.cantidad;
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
                  xValueMapper: (EgresoDetalle data, _) => data.prd!.detalle,
                  yValueMapper: (EgresoDetalle data, _) => data.cantidad,
                  dataLabelSettings: DataLabelSettings(isVisible: true)),
            ],
          )
        ],
      ),
    );
  }
}

class ReporteAprovicionar extends StatefulWidget {
  const ReporteAprovicionar({Key? key}) : super(key: key);

  @override
  State<ReporteAprovicionar> createState() => _ReporteAprovicionarState();
}

class _ReporteAprovicionarState extends State<ReporteAprovicionar> {
  @override
  void initState() {
    Provider.of<ProductosProvider>(context, listen: false).calculos();
    super.initState();
  }

  DateTime fechaActu = DateTime.now();
  //DateTime ultimoDia = DateTime(fecha.year, fecha.month, 1, 0, 0);

  @override
  Widget build(BuildContext context) {
    final prd = Provider.of<ProductosProvider>(context);
    return WhiteCard(
      title: 'Aprovisionar',
      child: Container(
        color: Colors.blue,
        width: 250,
        height: 250,
        child: Column(
          children: [
            for (var item in prd.aprovisionamientos
                .where((e) => e.clasificacion == "A")) ...{
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    item.detalle.length > 15
                        ? Text("${item.detalle.substring(0, 15)}")
                        : Text("${item.detalle}"),
                    Text("${item.stockSeguridad.toString()}"),
                  ],
                ),
              ),
            }
          ],
        ),
      ),
    );
  }
}
