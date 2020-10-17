import 'package:flutter/material.dart';

import '../../constants.dart';
import './widgets/statistics_overview.dart';
import './widgets/covid_chart.dart';
import '../../helpers/reports.dart';

class StatisticsScreen extends StatefulWidget {
  static const routeName = '/statistics';

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen>
    with TickerProviderStateMixin {
  TabController _tabController;
  AnimationController _animationController;
  Animation<double> _height;
  Animation<double> _opacity;
  Animation<double> _initOpacity;
  Animation<double> _initHeight;
  var _isInit = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _tabController = TabController(length: 2, vsync: this);
    _height =
        Tween<double>(begin: .33, end: 0).animate(_tabController.animation);
    _opacity = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
        parent: _tabController.animation, curve: Interval(0.0, 0.5)));
    _initOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Interval(0.5, 1.0)));
    _initHeight = Tween<double>(begin: 0, end: .33).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
      ),
      body: FutureBuilder(
        future: Reports.getReports(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          } else {
            if (snapshot.hasError)
              return Center(child: Text('Um erro ocorreu'));

            _animationController.forward().whenComplete(() => _isInit = false);
            return AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) => Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: StatisticsOverview(
                        snapshot.data['overview'],
                        _animationController.view,
                        _tabController,
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _isInit
                        ? _animationController
                        : _tabController.animation,
                    builder: (context, child) => Container(
                      padding: const EdgeInsets.all(20),
                      height: _isInit
                          ? size.height * _initHeight.value
                          : size.height * _height.value,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Opacity(
                        opacity: _isInit ? _initOpacity.value : _opacity.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              'Novos casos por dia',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                            ),
                            Spacer(),
                            Expanded(
                              child: CovidChart(snapshot.data['chart']),
                              flex: 7,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _tabController.dispose();
  }
}
