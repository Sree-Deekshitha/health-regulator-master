import 'package:allincluded/Reports.dart';
import 'package:allincluded/UserDetails.dart';
import 'package:flutter/material.dart';
import 'package:allincluded/AddVitals.dart';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dcdg/dcdg.dart';
class Vitals extends StatefulWidget {
  @override
  _VitalsState createState() => _VitalsState();
}

class _VitalsState extends State<Vitals> {
  Map document;
  String uid=FirebaseAuth.instance.currentUser.uid.toString();
  var height = AppBar().preferredSize.height;
  navigateToDetail(DocumentSnapshot post){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>VitalDetail(post:post,)));
  }
  @override
  Widget build(BuildContext context) {
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _height = logicalSize.height;
    
    CollectionReference users = FirebaseFirestore.instance.collection('profileInfo');
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Click + button at the bottom right to add values",style: TextStyle(color: Colors.grey,fontSize: 13) ,),
      ),
      body: new StreamBuilder(

        stream: FirebaseFirestore.instance.collection('profileInfo').doc(uid).collection("Health").snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData?Center(
            child: CircularProgressIndicator(),
          )
              :   ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {


              return _buildList(context, snapshot.data.docs[index]);


            },

          );
        },
      ),

          floatingActionButton: FloatingActionButton(
          //padding: new EdgeInsets.only(top: (_height - 450.0)),
          //margin: new EdgeInsets.only(bottom: 16.0),
          backgroundColor:  Color(0xff006400),
            child: new Icon(Icons.add),
            onPressed: (){
            Navigator.push(context, MaterialPageRoute( builder: (context) => AddVitals(),));
            }
    ),
    );
  }

  Widget _buildList(BuildContext context, DocumentSnapshot document) {

    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(colors: [
          Color(0xff83D475),  Color(0xff57C84D
          )
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: [
          BoxShadow(
            color: Color(0xffC5E8B7),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),


      margin: EdgeInsets.fromLTRB(3, 5, 3, 5),
      padding: EdgeInsets.fromLTRB(3, 5, 3, 5),
     // color: Colors.green[100],
      child: ListTile(
        //selectedTileColor: Colors.green[100],
        leading: Icon(Icons.date_range,color: Colors.white,),
        title: Text(document.data()['CreatedOn'].split(' ')[0],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),

        onTap: ()=>navigateToDetail(document),
        //subtitle: Text(document.data()['bio']),
      ),

    );

  }



}


class VitalDetail extends StatefulWidget {
  final DocumentSnapshot post;
  VitalDetail({this.post});
  @override
  _VitalDetailState createState() => _VitalDetailState();
}

class _VitalDetailState extends State<VitalDetail> {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Scaffold(

        appBar: AppBar(

          backgroundColor: Colors.green,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,  // add custom icons also
            ),
          ),
          title:Text("Values"),
        ),
        body: Card(
          child: new Container(
            width: MediaQuery.of(context).size.width,
            //olor: Colors.white,

              child: new ListView(
              children: <Widget>[
                Column(
                children: <Widget>[
                  new Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("lib/img/best.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    //color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 0.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 0.0),
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  
                                  Row(
                                    children: [
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Created On : ',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(widget.post.data()["CreatedOn"].split(' ')[0]),

                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Row(
                                    children: [
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Body Temperature in °F: ',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(widget.post.data()["Temperature"]),

                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Text(
                                    'Bp Input Details: (In mmHg)',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Systolic: ',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(widget.post.data()["Systolic"]),

                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Diastolic: ',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(widget.post.data()["Diastolic"]),

                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Text(
                                    'Sugar Details: ',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Before Breakfast: ',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(widget.post.data()["Breakfast before"]),

                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'After Breakfast: ',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(widget.post.data()["Breakfast after"]),

                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Before Lunch: ',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(widget.post.data()["Lunch before"]),

                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'After Lunch: ',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(widget.post.data()["Lunch after"]),

                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Before Dinner: ',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(widget.post.data()["Dinner before"]),

                                        ],
                                      ),
                                    ],
                                    ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'After Dinner: ',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(widget.post.data()["Dinner after"]),

                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Row(
                                    children: [
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Insulin: ',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(widget.post.data()["Insulinone"]),

                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[

                                          Text("M :"+widget.post.data()["Mone"]+"\n"+
                                              "A :"+widget.post.data()["Aone"]+"\n"+
                                              "E :"+widget.post.data()["Eone"]+"\n"),

                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Row(
                                    children: [
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Insulin 2: ',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(widget.post.data()["Insulintwo"]),

                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[

                                          Text("M :"+widget.post.data()["Mtwo"]+"\n"+
                                              "A :"+widget.post.data()["Atwo"]+"\n"+
                                              "E :"+widget.post.data()["Etwo"]+"\n"),

                                        ],
                                      ),
                                    ],
                                  ),
                                  ],
                                )),

                          ],
                        ),),),
                    ],
                    ),
                  ],
                  ),
              ),

        ),
        ),

    );
  }
}

