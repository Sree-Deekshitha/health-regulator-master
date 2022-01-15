import 'package:allincluded/HomePage.dart';
import 'package:allincluded/services/DatabaseManager.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:dcdg/dcdg.dart';
class EnterDetails extends StatefulWidget {
  @override
  _EnterDetailsState createState() => _EnterDetailsState();
}

class _EnterDetailsState extends State<EnterDetails> {
  final auth = FirebaseAuth.instance;
  User user;
  final _key = GlobalKey<FormState>();
  DateTime _dateTime;
  int _selected=0;
  void onChanged(int value){
    setState((){
      _selected=value;
    });
  }
  List<Widget> makeRadios(){
    List<Widget> list =new List<Widget>();
    list.add(new Row(
      children: [
        new Text('Male',style:TextStyle(color: Colors.white),),
        new Radio(value:0, groupValue: _selected,activeColor: Colors.white,onChanged: (int value){onChanged(value);})
      ],
    ),);
    list.add(new Row(
      children: [
        new Text('Female',style:TextStyle(color: Colors.white),),
        new Radio(value:1, groupValue: _selected,activeColor: Colors.white,onChanged: (int value){onChanged(value);})
      ],
    ),);
    return list;

  }
  String gender;

  int charLength = 0;
  textOnChanged(String value){
    setState(() {
      charLength = value.length;
    });
  }
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _fnameController = TextEditingController();
  TextEditingController _mnameController = TextEditingController();
  TextEditingController _WeightController = TextEditingController();
  TextEditingController _HeightController = TextEditingController();
  TextEditingController _AddressController = TextEditingController();
  TextEditingController _PhnoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 22, 0, 5),
          width: MediaQuery.of(context).size.width,
          color: Colors.green[400],
          child: Center(
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ADD DETAILS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: [

                        TextFormField(
                          controller: _nameController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Name cannot be empty';
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              )),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          controller: _fnameController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Father Name cannot be empty';
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Father Name',
                              hintText: 'FatherName',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              )),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          controller: _mnameController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Mother Name cannot be empty';
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Mother Name',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              )),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top:30),
                          child: Row(

                            children: makeRadios(),

                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Text("     DOB:    ",style:TextStyle(color: Colors.white),),
                            Text(_dateTime==null?'Enter DOB':_dateTime.toString().split(' ')[0],style:TextStyle(color: Colors.white),),
                            IconButton(
                              color: Colors.white,
                              icon: const Icon(Icons.date_range),
                              onPressed: (){
                                showDatePicker(context: context,
                                    initialDate: _dateTime==null? DateTime.now():_dateTime,
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2022)).
                                then((value) => setState((){
                                  _dateTime=value;
                                }));
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          controller: _PhnoController,

                          onChanged: textOnChanged,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'PhoneNumber cannot be empty';
                            }
                            else if(charLength>=11&& value.length<=9){
                              return 'Phone Number cannot be >= or <= 10 Digits';

                            }
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'PhoneNumber',
                              labelStyle: TextStyle(color: Colors.white)),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          controller: _AddressController,

                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Address cannot be empty';
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Address ',
                              labelStyle: TextStyle(color: Colors.white)),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          controller: _WeightController,

                          validator: (String value) {
                            int weight = int.tryParse(value);

                            if (weight == null || weight <= 0) {
                              return 'WEIGHT must be greater than 0';
                            }
                            if (value.isEmpty) {
                              return 'Weight cannot be empty';
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Weight',
                              hintText: 'enter in KGs',
                              labelStyle: TextStyle(color: Colors.white)),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          controller: _HeightController,

                          validator: (String value) {
                          int height = int.tryParse(value);
                          if (height == null || height <= 0) {
                            return 'HEIGHT must be greater than 0';
                          }
                            if (value.isEmpty) {
                              return 'Height cannot be empty';
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Height',
                              hintText: "enter in centimeters",
                              labelStyle: TextStyle(color: Colors.white)),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FlatButton(
                              child: Text('SAVE'),
                              onPressed: () async {
                                if (_key.currentState.validate()) {
                                user = auth.currentUser;
                                String uid=FirebaseAuth.instance.currentUser.uid.toString();
                                await DatabaseManager().createUserDetails(user.email,_nameController.text,_fnameController.text,_mnameController.text,_selected,_dateTime,_PhnoController.text,_AddressController.text,_WeightController.text,_HeightController.text,uid);
                                Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context) => Homepage(),

                                ),);


                              }},

                              color: Colors.white,
                            ),
                            FlatButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              color: Colors.white,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
