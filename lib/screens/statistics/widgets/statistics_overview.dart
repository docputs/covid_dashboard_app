import 'package:flutter/material.dart';

import './global_stats.dart';
import './country_stats.dart';

class StatisticsOverview extends StatelessWidget {
  StatisticsOverview(this.data, this.controller, this.tabController, {Key key})
      : slide = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0)).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeOutQuart)),
        super(key: key);

  final Map data;
  final TabController tabController;
  final AnimationController controller;
  final Animation<Offset> slide;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SlideTransition(
          position: slide,
          child: Container(
            width: double.infinity,
            child: Text(
              'Estatísticas',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.symmetric(vertical: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TabBar(
            controller: tabController,
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            labelColor: Colors.black,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(child: Text('Brasil')),
              Tab(child: Text('Mundo')),
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: TabBarView(
            controller: tabController,
            children: <Widget>[
              CountryStats(data),
              GlobalStats(data),
            ],
          ),
        ),
      ],
    );
  }
}
