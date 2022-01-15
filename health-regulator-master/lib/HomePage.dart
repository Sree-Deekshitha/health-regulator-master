import 'package:allincluded/LogoutPage.dart';
import 'file:///C:/Users/durga/AndroidStudioProjects/allincluded/lib/vitalstabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:allincluded/Vitals.dart';
import 'package:allincluded/Reports.dart';
import 'package:allincluded/UserDetails.dart';
import 'package:dcdg/dcdg.dart';
class Homepage extends StatefulWidget {

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  int _currentIndex=0;
  List<int> _history = [0];
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(

          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text("HealthRecords"),
              actions: [
                IconButton(
                  icon: Icon(Icons.settings,),
                  disabledColor: Colors.white,
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) =>  LogOutPage(),

                    ),);
                  },
                ),
              ],
              bottom:TabBar(

                unselectedLabelColor: Colors.white,
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
               indicatorColor: Colors.white,
               tabs: <Widget>[
                 Tab(
                   text: 'Profile',


                 ),
                 Tab(
                   text: 'Reports',

                 ),
                 Tab(
                   text: 'Vitals',

                 ),
               ],

              ),

            ),
            body: TabBarView(
                children: [
             
                
                    UserDetails(),
                    Reports(),
                    VitalsTabs(0xff228B22),
                ],
              ),
          ),
        ),
    );
  }
}

