
import 'package:dcdg/dcdg.dart';
import 'package:flutter/material.dart';
class CovidCare extends StatefulWidget {
  @override
  _CovidCareState createState() => _CovidCareState();
}

class _CovidCareState extends State<CovidCare> {
  double w;
  @override
  Widget build(BuildContext context) {
    w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/img/best.jpg"),
            fit: BoxFit.cover,
          ),
        ),

        width: MediaQuery.of(context).size.width,
        child: ListView(
          shrinkWrap: true,
          children: [
              new Container(


                  width: MediaQuery.of(context).size.width,

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(

                        mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(

                              child: Center(
                                child: Text("COVID-19\n Connect to Care",style: TextStyle(fontFamily: 'Pacifico',color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,),textAlign: TextAlign.center,),

                              ),
                              padding: const EdgeInsets.fromLTRB(45, 0, 10, 0),
                            ),],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text("Keep yourself and your community healthy\nby practicing these tips"),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Padding(

                          padding: const EdgeInsets.only(
                              left: 0.0, right: 0.0, top: 10.0, bottom: 0.0),
                          child: new Container(
                            width:MediaQuery.of(context).size.width-8,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Color(0xFFffd6d1),
                            ),

                              padding: EdgeInsets.only(
                                  top: 7.0, bottom: 7.0, right: 10.0, left: 7.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Image.asset('lib/img/handwash.png',
                                      height: 130.0, width: MediaQuery.of(context).size.width/6,),
                                  Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: new Text(
                                        "Wash your hands often\nwith soap for at least\n20 seconds ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ))
                                ],
                              ),
                           ),
                        ),
                       SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0,right: 0.0,top:0.0,bottom:0.0),
                          child: new Container(
                            width: MediaQuery.of(context).size.width-8,

                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Color(0xFFffd6d1),
                            ),
                            padding: EdgeInsets.only(
                                top: 7.0, bottom: 7.0, right: 10.0, left: 7.0),
                            child: new Row(
                              children: [

                                Padding(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: new Text(
                                      "Stay home and \navoid touching your eyes,\nnose, and mouth. ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )),
                                new Image.asset("lib/img/stayhome.jpeg",
                                  height: 130.0, width: MediaQuery.of(context).size.width/6),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0,right: 0.0,top:0.0,bottom:0.0),
                          child: new Container(
                            width: MediaQuery.of(context).size.width-8,

                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Color(0xFFffd6d1),
                            ),
                            padding: EdgeInsets.only(
                                top: 7.0, bottom: 7.0, right: 10.0, left: 7.0),
                            child: new Row(
                              children: [
                                new Image.asset("lib/img/sanitize.png",
                                  height: 90.0, width: MediaQuery.of(context).size.width/6),
                                Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: new Text(
                                      "Clean and disinfect \ncommonly used\n surfaces and \nobjects. ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0,right: 0.0,top:0.0,bottom:0.0),
                          child: new Container(
                            width: MediaQuery.of(context).size.width-8,

                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Color(0xFFffd6d1),
                            ),
                            padding: EdgeInsets.only(
                                top: 7.0, bottom: 7.0, right: 10.0, left: 7.0),
                            child: new Row(
                              children: [

                                Padding(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: new Text(
                                      "Avoid close contact\nwith anyone you don’t \ncurrently live with. ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )),
                                new Image.asset("lib/img/avoidcontact.png",
                                  height: 130.0, width: MediaQuery.of(context).size.width/6),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
              ),
                  ),
                ],
        ),
      ),
    );
  }
}
