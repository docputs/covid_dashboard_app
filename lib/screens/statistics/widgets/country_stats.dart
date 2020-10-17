import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';

class CountryStats extends StatelessWidget {
  const CountryStats(this.reportsData);

  final Map reportsData;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 3,
      child: Column(
        children: <Widget>[
          SizedBox(
            width: size.width * .7,
            height: 50,
            child: TabBar(
              indicatorColor: Colors.transparent,
              tabs: [
                Tab(text: 'Total'),
                Tab(text: 'Hoje'),
                Tab(text: 'Ontem'),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: TabBarView(
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.8,
                  children: <Widget>[
                    buildInfoTile(
                      title: 'Infectados',
                      value: reportsData['confirmados']['total'],
                      color: kAffectedColor,
                    ),
                    buildInfoTile(
                      title: 'Mortes',
                      value: reportsData['obitos']['total'],
                      color: kDeathColor,
                    ),
                    buildInfoTile(
                      title: 'Recuperados',
                      value: reportsData['confirmados']['recuperados'],
                      color: kRecoveredColor,
                    ),
                    buildInfoTile(
                      title: 'Acompanhamento',
                      value: reportsData['confirmados']['acompanhamento'],
                      color: kActiveColor,
                    ),
                  ],
                ),
                ListView(
                  children: <Widget>[
                    buildInfoTile(
                      title: 'Novos casos',
                      value: reportsData['hoje'] == null ? '0' : reportsData['hoje']['casosNovos'].toString(),
                      color: kAffectedColor,
                    ),
                    buildInfoTile(
                      title: 'Novas mortes',
                      value: reportsData['hoje'] == null ? '0' : reportsData['hoje']['obitosNovos'].toString(),
                      color: kDeathColor,
                    ),
                  ],
                ),
                ListView(
                  children: <Widget>[
                    buildInfoTile(
                      title: 'Novos casos',
                      value: reportsData['ontem']['casosNovos'].toString() ?? '0',
                      color: kAffectedColor,
                    ),
                    buildInfoTile(
                      title: 'Novas mortes',
                      value: reportsData['ontem']['obitosNovos'].toString() ?? '0',
                      color: kDeathColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildInfoTile({String title, String value, Color color}) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          FittedBox(
            child: Text(
              NumberFormat.decimalPattern('pt-BR').format(int.parse(value)),
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontSize: 26,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
