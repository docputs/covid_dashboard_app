import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../constants.dart';

class CovidChart extends StatelessWidget {
  const CovidChart(
    this.data, {
      Animation controller,
    Key key,
  }) : super(key: key);

  final List data;

  List get generateWeek {
    initializeDateFormatting('pt_BR');
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        return DateFormat('dd/MM', 'pt_BR').format(weekDay);
      },
    ).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: 60001,
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: true, horizontalInterval: 15000),
        titlesData: FlTitlesData(
          rightTitles: SideTitles(
            showTitles: true,
            reservedSize: 20.0,
            getTitles: (value) => null,
          ),
          bottomTitles: SideTitles(
            textStyle: TextStyle(color: Colors.black54, fontSize: 10),
            showTitles: true,
            getTitles: (value) => generateWeek[value.toInt()],
            rotateAngle: -20.0,
          ),
          leftTitles: SideTitles(
            textStyle: TextStyle(color: Colors.black54, fontSize: 10),
            showTitles: true,
            getTitles: (value) {
              if (value == 15000) {
                return '15K';
              } else if (value == 30000) {
                return '30K';
              } else if (value == 45000) {
                return '45K';
              } else if (value == 60000) {
                return '60K';
              }
              return '';
            },
            reservedSize: 20.0,
          ),
        ),
        barGroups: List.generate(
          7,
          (index) => BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                y: data.reversed.toList()[index]['casosNovos'].toDouble(),
                color: kAffectedColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
