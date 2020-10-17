import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './screens/statistics/statistics_screen.dart';
import './screens/home/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('pt', 'BR'),
        const Locale('de', 'DE'),
      ],
      title: 'Covid Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.muliTextTheme(),
        primaryColorBrightness: Brightness.dark,
      ),
      home: HomeScreen(),
      routes: {
        StatisticsScreen.routeName: (ctx) => StatisticsScreen(),
      },
    );
  }
}
