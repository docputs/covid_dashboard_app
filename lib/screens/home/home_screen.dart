import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';
import '../../screens/statistics/statistics_screen.dart';
import './widgets/test_container.dart';
import './widgets/select_country.dart';

class HomeScreen extends StatelessWidget {
  Route _buildStatisticsPage() {
    return PageRouteBuilder(
      // transitionDuration: const Duration(seconds: 2),
      pageBuilder: (context, animation, secondaryAnimation) =>
          StatisticsScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          alignment: Alignment.topRight,
          scale: animation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.show_chart),
            onPressed: () => Navigator.of(context).pushNamed(StatisticsScreen.routeName),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {},
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Covid-19',
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                        SelectCountry(),
                      ],
                    ),
                    Spacer(flex: 2),
                    Text(
                      'Está se sentindo doente?',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      'Ligue-nos ou envie um SMS imediatamente se você está doente e apresenta algum sintoma da Covid-19.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: Colors.white70),
                    ),
                    Spacer(flex: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        FlatButton.icon(
                          icon: Icon(Icons.phone),
                          label: Text('Ligar'),
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          textColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          onPressed: () {},
                        ),
                        FlatButton.icon(
                          icon: Icon(Icons.sms),
                          label: Text('Enviar SMS'),
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          textColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Spacer(flex: 1),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      'Prevenção',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        buildPrevention(
                          '004-social distancing.svg',
                          'Evite contato social',
                        ),
                        buildPrevention(
                          '024-washing hands.svg',
                          'Lave suas mãos com frequência',
                        ),
                        buildPrevention(
                          '050-face mask.svg',
                          'Use máscara',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TestContainer(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildPrevention(String asset, String text) {
    return Expanded(
      child: Column(
        children: <Widget>[
          SvgPicture.asset(
            'assets/icons/' + asset,
            width: 80,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
