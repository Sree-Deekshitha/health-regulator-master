
import 'dart:math';
import 'package:dcdg/dcdg.dart';
import 'package:intl/intl.dart';
import 'package:allincluded/services/DatabaseManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  Timestamp timestamp;
  DateTime dateTime;
  double height;
  double _bmi;
  int h,w;
  String bodyheight, bodyweight,print,des;

  @override
  Widget build(BuildContext context) {
    var gname, gmail;
    height = MediaQuery
        .of(context)
        .size
        .height;
    String uid = FirebaseAuth.instance.currentUser.uid.toString();
    //return new StreamBuilder<QuerySnapshot>(
    //stream: FirebaseFirestore.instance.collection('profileInfo').document(uid).get(),
    CollectionReference users = FirebaseFirestore.instance.collection(
        'profileInfo');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(uid).get(),
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot> snapshot) {
        //timestamp = snapshot.data[''] as Timestamp;
        // dateTime = timestamp.toDate();


        if (!snapshot.hasData) return new Text('Loading...');

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          timestamp = data['Date Of Birth'] as Timestamp;
          dateTime = timestamp.toDate();
          bodyheight = data['Height'];
          bodyweight = data['Weight'];
          h = int.parse(bodyheight);
          w = int.parse(bodyweight);
          _bmi = w / pow(h / 100, 2);
          if (_bmi >= 25) {
            print = 'Overweight';
            des = 'Try to exercise more.';
          } else if (_bmi >= 18.5) {
            print = 'Normal';
            des = 'Good job!';
          } else {
            print = 'Underweight';
            des = 'You can eat a bit more.';
          }

          return new Scaffold(

            body: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/img/best.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: new ListView(children: [
                Container(

                  child: Column(
                    children: [
                      Center(
                          child: Column(
                            children: [
                              Text(
                                'Account Info',
                                style: TextStyle(fontSize: 25,
                                    fontFamily: 'EB',
                                    fontWeight: FontWeight.bold),

                              ),
                            ],
                          )),

                      Container(
                        //
                        child: DataTable(

                          dataRowHeight: height / 10,
                          columns: [
                            DataColumn(label: Text("${data['Email']}",
                                style: TextStyle(fontSize: 18,
                                    fontFamily: 'EB',
                                    fontWeight: FontWeight.bold)
                            )),

                          ],
                          rows: [
                            DataRow(cells: [

                              DataCell(

                                Container(
                                  padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  height: height / 10,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '   Name:',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'EB',),
                                          ),

                                          Text("    ${data['Name']}",
                                            style: TextStyle(fontFamily: 'EB',
                                                color: Colors.black54),),
                                        ],
                                      ),

                                    ],
                                  ),

                                ),

                              ),


                            ],),

                            DataRow(cells: [
                              DataCell(Container(
                                padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                height: height / 8,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '   Father Name: ',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'EB',),
                                        ),
                                        Text("    ${data['Fname']}",
                                          style: TextStyle(fontFamily: 'EB',
                                              color: Colors.black54),),
                                      ],
                                    ),


                                  ],
                                ),

                              ),),


                            ],),
                            DataRow(cells: [
                              DataCell(Container(
                                padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                height: height / 10,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '   Mother Name: ',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'EB',),
                                        ),
                                        Text("    ${data['Mname']}",
                                          style: TextStyle(fontFamily: 'EB',
                                              color: Colors.black54),),
                                      ],
                                    ),

                                  ],
                                ),

                              ),),


                            ],),
                            DataRow(cells: [
                              DataCell(Container(
                                padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                height: height / 10,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '   Date Of Birth: ',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'EB',),
                                        ),
                                        Text("    " +
                                            dateTime.toString().split(' ')[0],
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontFamily: 'EB',),),
                                      ],
                                    ),


                                  ],
                                ),

                              ),),


                            ],),
                            DataRow(cells: [
                              DataCell(Container(
                                padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                height: height / 10,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '   Phone Number: ',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'EB',),
                                        ),
                                        Text("    ${data['PhNumber']}",
                                          style: TextStyle(fontFamily: 'EB',
                                              color: Colors.black54),),
                                      ],
                                    ),


                                  ],
                                ),

                              ),),


                            ],),
                            DataRow(cells: [
                              DataCell(Container(
                                padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                height: height / 10,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '   BMI: ',
                                          style: TextStyle(fontFamily: 'EB',
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold),
                                        ),

                                        Column(
                                          children: [
                                            Text("    " + print,
                                                style: TextStyle(
                                                    fontFamily: 'EB',
                                                    color: Colors.black54)),
                                            Text("    " + des,
                                                style: TextStyle(
                                                    fontFamily: 'EB',
                                                    color: Colors.black54)),
                                          ],
                                        ),
                                      ],
                                    ),


                                  ],
                                ),

                              ),),


                            ],),
                            DataRow(cells: [
                              DataCell(Container(
                                padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                height: height / 10,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '   Height in cm: ',
                                          style: TextStyle(fontFamily: 'EB',
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),

                                        Text("    ${data['Height']}",
                                            style: TextStyle(fontFamily: 'EB',
                                                color: Colors.black54)),
                                      ],
                                    ),


                                  ],
                                ),

                              ),),


                            ],),
                            DataRow(cells: [
                              DataCell(Container(
                                padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                height: height / 10,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '   Weight in KGs: ',
                                          style: TextStyle(fontFamily: 'EB',
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text("    ${data['Weight']}",
                                            style: TextStyle(fontFamily: 'EB',
                                                color: Colors.black54)),
                                      ],
                                    ),


                                  ],
                                ),

                              ),),


                            ],),
                            DataRow(cells: [
                              DataCell(Container(
                                padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                height: 90,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [

                                        Column(
                                          children: [
                                            Text(
                                              '   Address: ',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'EB',),
                                            ),
                                          ],
                                        ),


                                        Expanded(

                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                11, 2, 2, 0),
                                            child: Text(
                                                '''${data['Address']}''',
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontFamily: 'EB',
                                                    color: Colors.black54)),
                                          ),
                                        ),


                                      ],

                                    ),
                                  ],
                                ),


                              ),),


                            ],),


                          ],
                        ),

                      ),
                    ],
                  ),
                ),
              ],
              ),
            ),
          );
          //Text("Full Name: ${data['Name']} ${data['Email']}"),);
        }
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        return Text("loading");
      },
    );
  }
}


