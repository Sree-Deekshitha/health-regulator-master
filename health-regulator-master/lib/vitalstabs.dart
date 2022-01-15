import 'package:allincluded/Exercises.dart';
import 'package:allincluded/Nutrition.dart';
import 'package:allincluded/Vitals.dart';
import 'package:allincluded/covid.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dcdg/dcdg.dart';

class VitalsTabs extends StatefulWidget {

  VitalsTabs(this.colorVal);
  int colorVal=0xff228B22;

  _VitalsTabsState createState() => _VitalsTabsState();
}

class _VitalsTabsState extends State<VitalsTabs> with SingleTickerProviderStateMixin{
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 4);
    _tabController.addListener(_handleTabSelection);
  }
  void _handleTabSelection() {
    setState(() {
      widget.colorVal=0xff228B22;
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: Colors.white,
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorWeight: 4.0,
              indicatorColor:Color(0xff228B22),
              unselectedLabelColor: Colors.grey,
              tabs: <Widget>[
                Tab(
                  icon:Icon(FontAwesomeIcons.heartbeat, color: _tabController.index == 0
                      ? Color( widget.colorVal)
                      : Colors.grey),
                  child:Text('Your Health',style: TextStyle( color: _tabController.index == 0
                      ?  Color( widget.colorVal)
                      : Colors.grey)),
                ),
                Tab(
                  icon: Icon(FontAwesomeIcons.chartBar, color: _tabController.index == 1
                      ? Color( widget.colorVal)
                      : Colors.grey),
                  child: Text('Covid 19',style: TextStyle( color: _tabController.index == 1
                      ?  Color( widget.colorVal)
                      : Colors.grey)),
                ),
                Tab(
                  icon: Icon(FontAwesomeIcons.plusSquare, color: _tabController.index == 2
                      ? Color( widget.colorVal)
                      : Colors.grey),
                  child: Text('Nutrition',style: TextStyle( color: _tabController.index == 2
                      ?  Color( widget.colorVal)
                      : Colors.grey)),
                ),
                Tab(
                  icon: Icon(FontAwesomeIcons.child, color: _tabController.index == 3
                      ? Color( widget.colorVal)
                      : Colors.grey),
                  child: Text('Exercises',style: TextStyle( color: _tabController.index == 3
                      ?  Color( widget.colorVal)
                      : Colors.grey)),
                ),



              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Vitals(),
            CovidCare(),
            Nutrition(),
            Exercises(),

          ],
        ),
      ),
    );


  }

}