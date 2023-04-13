import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final double maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;
  const MyBarGraph(
      {Key? key,
      required this.maxY,
      required this.sunAmount,
      required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thuAmount,
      required this.friAmount,
      required this.satAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sunAmount: sunAmount,
      monAmount: monAmount,
      tueAmount: tueAmount,
      wedAmount: wedAmount,
      thuAmount: thuAmount,
      friAmount: friAmount,
      satAmount: satAmount,
    );
    myBarData.insertBarData();
    return BarChart(BarChartData(
        maxY: maxY,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(

          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,
              getTitlesWidget: getBottomTitles ))
        ),
        barGroups: myBarData.barData
            .map((data) => BarChartGroupData(
                x: data.x.toInt(),
            barRods: [BarChartRodData(toY: data.y,
              color: Colors.grey[800],
              width: 20,
              borderRadius: BorderRadius.circular(5),
              backDrawRodData: BackgroundBarChartRodData(
                color: Colors.grey[500],
                show: true,
                toY: maxY,
              )
        )]))
            .toList()));
  }
}

Widget getBottomTitles(double value , TitleMeta meta){
  var style = TextStyle(
    color: Colors.grey.shade600,
    fontWeight: FontWeight.bold,
    fontSize: 14
  );
  Widget text;
  switch(value.toInt()){
    case(0):
     text = Text('S',style: style);
     break;
    case(1):
      text = Text('M',style:style);
      break;
    case(2):
      text = Text('T',style:style);
      break;
    case(3):
      text = Text('W',style:style);
      break;
    case(4):
      text = Text('T',style:style);
      break;
    case(5):
      text = Text('F',style:style);
      break;
    case(6):
      text = Text('S',style:style);
      break;
    default:
      text = Text('');
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}