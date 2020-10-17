import 'package:flutter/material.dart';

import '../../../helpers/reports.dart';

class GlobalStats extends StatelessWidget {
  const GlobalStats(this.reportsData);

  final Map reportsData;

  final List<Map> ranking = const [
    {'country': 'EUA', 'code': 'us'},
    {'country': 'Brasil', 'code': 'br'},
    {'country': 'Índia', 'code': 'in'},
    {'country': 'Rússia', 'code': 'ru'},
    {'country': 'África do Sul', 'code': 'za'},
    {'country': 'Peru', 'code': 'pe'},
    {'country': 'México', 'code': 'mx'},
    {'country': 'Colômbia', 'code': 'co'},
    {'country': 'Chile', 'code': 'cl'},
    {'country': 'Espanha', 'code': 'es'},
    {'country': 'Irã', 'code': 'ir'},
    {'country': 'Reino Unido', 'code': 'gs'},
    {'country': 'Arábia Saudita', 'code': 'sa'},
    {'country': 'Paquistão', 'code': 'pk'},
    {'country': 'Argentina', 'code': 'ar'},
    {'country': 'Bangladesh', 'code': 'bd'},
    {'country': 'Itália', 'code': 'it'},
    {'country': 'Turquia', 'code': 'tr'},
    {'country': 'Alemanha', 'code': 'de'},
    {'country': 'França', 'code': 'fr'},
    {'country': 'Iraque', 'code': 'iq'},
    {'country': 'Filipinas', 'code': 'ph'},
    {'country': 'Indonésia', 'code': 'id'},
    {'country': 'Canadá', 'code': 'ca'},
  ];

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle =
        Theme.of(context).textTheme.headline6.copyWith(color: Colors.white);

    return FutureBuilder(
      future: Reports.getGlobalRanking(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('País', style: textStyle),
                  Text('Nº de infectados', style: textStyle),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ranking.length * 2,
                itemBuilder: (context, index) {
                  if (index.isOdd) return Divider(color: Colors.white);
                  final i = index ~/ 2;
                  return ListTile(
                    leading: Image.asset(
                      'icons/flags/png/${ranking[i]["code"]}.png',
                      package: 'country_icons',
                      width: 60,
                    ),
                    title: Text(
                      ranking[i]['country'],
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.white),
                    ),
                    trailing: Text(
                      '${snapshot.data[i+1]['cases']}',
                      style: textStyle,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
