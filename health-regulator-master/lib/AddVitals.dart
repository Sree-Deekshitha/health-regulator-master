import 'package:allincluded/Vitals.dart';
import 'package:allincluded/services/DatabaseManager.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:dcdg/dcdg.dart';
class AddVitals extends StatefulWidget {
  @override
  _AddVitalsState createState() => _AddVitalsState();
}

class _AddVitalsState extends State<AddVitals> {
  final auth = FirebaseAuth.instance;

  User user;

  final _key = GlobalKey<FormState>();
  final SystolicController= TextEditingController();
  final DiastolicController= TextEditingController();
  TextEditingController _parentController = TextEditingController();
  TextEditingController _bbeforeController = TextEditingController();
  TextEditingController _bafterController = TextEditingController();
  TextEditingController _lbeforeController = TextEditingController();
  TextEditingController _lafterController = TextEditingController();
  TextEditingController _dbeforeController = TextEditingController();
  TextEditingController _dafterController = TextEditingController();
  TextEditingController _foodController = TextEditingController();
  TextEditingController _insulinoneController = TextEditingController();
  TextEditingController _minsulinoneController = TextEditingController();
  TextEditingController _ainsulinoneController = TextEditingController();
  TextEditingController _einsulinoneController = TextEditingController();
  TextEditingController _insulintwoController = TextEditingController();
  TextEditingController _minsulintwoController = TextEditingController();
  TextEditingController _ainsulintwoController = TextEditingController();
  TextEditingController _einsulintwoController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  TextEditingController _bodyTemperatureController = TextEditingController();
  TextEditingController _recipientController = TextEditingController();
  double width;

  DateTime _dateTime;
  String d;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,  // add custom icons also
          ),
        ),
      ),

      body: Container(


        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Center(

            child:Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/img/best.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Form(
                            key: _key,
                            child: Column(
                              children: [
                                SizedBox(height: 30),
                                Row(
                                  children: [

                                    Text("Created On :    ",style:TextStyle(fontSize: 17,color: Colors.green,fontWeight: FontWeight.bold),),
                                    Text(_dateTime==null?'Enter Date':_dateTime.toLocal().toString().split(' ')[0],style:TextStyle(color: Colors.green),),
                                    IconButton(
                                        color: Colors.green,
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
                                //Text("Parents MailID :    ",style:TextStyle(fontSize: 17,color: Colors.green,fontWeight: FontWeight.bold),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    Container(
                                      width: MediaQuery.of(context).size.width/4,
                                      child :Text("Parent EmailId :",style: TextStyle(fontSize: 16,color: Colors.green,fontWeight: FontWeight.bold),),
                                    ),
                                    SizedBox(width: 5,),
                                    Container(
                                      width: MediaQuery.of(context).size.width/2,
                                      child: TextFormField(
                                        controller: _parentController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Parent Email cannot be empty';
                                          }
                                          if (!RegExp(
                                              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                              .hasMatch(value)) {
                                            return 'Please enter a valid email Address';
                                          }
                                          else
                                            return null;
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Parent Email ID',
                                          alignLabelWithHint:true,
                                          counterText: "",
                                          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
                                          labelStyle: TextStyle(color: Colors.grey.shade600,),
                                        ),

                                        style: TextStyle(
                                            fontSize: 12.0,
                                            //height: 2.0,
                                            color: Colors.black
                                        ),

                                      ),
                                    ),


                                  ],
                                ),

                                SizedBox(height: 30),
                                Text("Blood Pressure Details:",style: TextStyle(fontSize: 20,color: Colors.green,fontWeight: FontWeight.bold),),
                                SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    Container(
                                      width: MediaQuery.of(context).size.width/4,
                                      child :Text("BP Input :",style: TextStyle(fontSize: 16,color: Colors.green,fontWeight: FontWeight.bold),),
                                    ),
                                    SizedBox(width: 5,),
                                    Container(
                                      width: MediaQuery.of(context).size.width/4,
                                      child: TextFormField(
                                        controller: SystolicController,
                                        validator: (value) {
                                          int s = int.tryParse(value);
                                          if (s == null || s <= 0) {
                                            return 'must be > 0';
                                          }
                                          if (value.isEmpty) {
                                            return 'BP Systolic cannot be empty';
                                          } else
                                            return null;
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Systolic',
                                          alignLabelWithHint:true,
                                          counterText: "",
                                          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
                                          labelStyle: TextStyle(color: Colors.grey.shade600,),
                                        ),

                                        style: TextStyle(
                                            fontSize: 12.0,
                                            //height: 2.0,
                                            color: Colors.black
                                        ),

                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width/4,
                                      child: TextFormField(
                                        controller: DiastolicController,
                                        validator: (value) {
                                          int s = int.tryParse(value);
                                          if (s == null || s <= 0) {
                                            return 'must be > 0';
                                          }
                                          if (value.isEmpty) {
                                            return 'Diastolic cannot be empty';
                                          } else
                                            return null;
                                        },
                                        textAlign:TextAlign.center,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
                                          labelText: '/Diastolic',
                                          alignLabelWithHint:true,
                                          labelStyle: TextStyle(color: Colors.grey.shade600,),
                                        ),

                                        style: TextStyle(
                                            fontSize: 12.0,

                                            //height: 2.0,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                                SizedBox(height: 30,),
                                Text("Sugar / Food Details:",style: TextStyle(fontSize: 20,color: Colors.green,fontWeight: FontWeight.bold),),
                                SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    Container(
                                      width: MediaQuery.of(context).size.width/4,
                                      child :Text("BreakFast :",style: TextStyle(fontSize: 16,color: Colors.green,fontWeight: FontWeight.bold),),
                                    ),
                                    SizedBox(width: 5,),
                                    Container(

                                      width: MediaQuery.of(context).size.width/4,
                                      child: TextFormField(
                                        controller: _bbeforeController,
                                        validator: (value) {
                                          int s = int.tryParse(value);
                                          if (s == null || s <= 0) {
                                            return 'must be > 0';
                                          }
                                          if (value.isEmpty) {
                                            return 'This field cannot be empty';
                                          } else
                                            return null;
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,//this has no effect
                                            ),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          labelText: 'Before',
                                          alignLabelWithHint:true,
                                          counterText: "",
                                          contentPadding: EdgeInsets.fromLTRB(8.0, 10.0, 5.0, 10.0),
                                          labelStyle: TextStyle(color: Colors.grey.shade600,),

                                        ),

                                        style: TextStyle(
                                            fontSize: 12.0,
                                            //height: 2.0,
                                            color: Colors.black
                                        ),

                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width/4,
                                      child: TextFormField(
                                        controller: _bafterController,
                                        validator: (value) {
                                          int s = int.tryParse(value);
                                          if (s == null || s <= 0) {
                                            return 'must be > 0';
                                          }
                                          if (value.isEmpty) {
                                            return 'This field cannot be empty';
                                          } else
                                            return null;
                                        },
                                        textAlign:TextAlign.center,
                                        decoration: InputDecoration(
                                          fillColor: Colors.greenAccent,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,//this has no effect
                                            ),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),

                                          counterText: "",
                                          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
                                          labelText: 'After',
                                          alignLabelWithHint:true,
                                          labelStyle: TextStyle(color: Colors.grey.shade600,),
                                        ),

                                        style: TextStyle(
                                            fontSize: 12.0,

                                            //height: 2.0,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    Container(
                                      width: MediaQuery.of(context).size.width/4,
                                      child :Text("Lunch :",style: TextStyle(fontSize: 16,color: Colors.green,fontWeight: FontWeight.bold),),
                                    ),
                                    SizedBox(width: 5,),
                                    Container(
                                      width: MediaQuery.of(context).size.width/4,
                                      child: TextFormField(
                                        controller: _lbeforeController,

                                        validator: (value) {
                                          int s = int.tryParse(value);
                                          if (s == null || s <= 0) {
                                            return 'must be > 0';
                                          }
                                          if (value.isEmpty) {
                                            return 'This field cannot be empty';
                                          } else
                                            return null;
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,//this has no effect
                                            ),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          labelText: 'Before',
                                          alignLabelWithHint:true,
                                          counterText: "",
                                          contentPadding: EdgeInsets.fromLTRB(8.0, 10.0, 5.0, 10.0),
                                          labelStyle: TextStyle(color: Colors.grey.shade600,),

                                        ),

                                        style: TextStyle(
                                            fontSize: 12.0,
                                            //height: 2.0,
                                            color: Colors.black
                                        ),

                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width/4,
                                      child: TextFormField(
                                        controller: _lafterController,
                                        validator: (value) {
                                          int s = int.tryParse(value);
                                          if (s == null || s <= 0) {
                                            return 'must be > 0';
                                          }
                                          if (value.isEmpty) {
                                            return 'This field cannot be empty';
                                          } else
                                            return null;
                                        },
                                        textAlign:TextAlign.center,
                                        decoration: InputDecoration(
                                          fillColor: Colors.greenAccent,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,//this has no effect
                                            ),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),

                                          counterText: "",
                                          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
                                          labelText: 'After',
                                          alignLabelWithHint:true,
                                          labelStyle: TextStyle(color: Colors.grey.shade600,),
                                        ),

                                        style: TextStyle(
                                            fontSize: 12.0,

                                            //height: 2.0,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    Container(
                                      width: MediaQuery.of(context).size.width/4,
                                      child :Text("Dinner :",style: TextStyle(fontSize: 16,color: Colors.green,fontWeight: FontWeight.bold),),
                                    ),
                                    SizedBox(width: 5,),
                                    Container(
                                      width: MediaQuery.of(context).size.width/4,
                                      child: TextFormField(
                                        controller: _dbeforeController,
                                        validator: (value) {
                                          int s = int.tryParse(value);
                                          if (s == null || s <= 0) {
                                            return 'must be > 0';
                                          }
                                          if (value.isEmpty) {
                                            return 'This field cannot be empty';
                                          } else
                                            return null;
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,//this has no effect
                                            ),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          labelText: 'Before',
                                          alignLabelWithHint:true,
                                          counterText: "",
                                          contentPadding: EdgeInsets.fromLTRB(8.0, 10.0, 5.0, 10.0),
                                          labelStyle: TextStyle(color: Colors.grey.shade600,),

                                        ),

                                        style: TextStyle(
                                            fontSize: 12.0,
                                            //height: 2.0,
                                            color: Colors.black
                                        ),

                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width/4,
                                      child: TextFormField(
                                        controller: _dafterController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            int s = int.tryParse(value);
                                            if (s == null || s <= 0) {
                                              return 'must be > 0';
                                            }
                                            return 'This field cannot be empty';
                                          } else
                                            return null;
                                        },
                                        textAlign:TextAlign.center,
                                        decoration: InputDecoration(
                                          fillColor: Colors.greenAccent,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,//this has no effect
                                            ),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),

                                          counterText: "",
                                          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
                                          labelText: 'After',
                                          alignLabelWithHint:true,
                                          labelStyle: TextStyle(color: Colors.grey.shade600,),
                                        ),

                                        style: TextStyle(
                                            fontSize: 12.0,

                                            //height: 2.0,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    Container(
                                      width: MediaQuery.of(context).size.width/4,
                                      child :Text("Food Intake & Water Intake:",style: TextStyle(fontSize: 16,color: Colors.green,fontWeight: FontWeight.bold),),
                                    ),
                                    SizedBox(width: 5,),
                                    Expanded(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width/2,

                                        child: TextFormField(
                                          controller: _foodController,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'This field cannot be empty';
                                            } else
                                              return null;
                                          },
                                          keyboardType: TextInputType.multiline,
                                          minLines: 1,//Normal textInputField will be displayed
                                          maxLines: 5,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.black,//this has no effect
                                              ),
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            hintText: "Enter your food intake details",
                                            alignLabelWithHint:true,
                                            counterText: "",
                                            contentPadding: EdgeInsets.fromLTRB(8.0, 10.0, 5.0, 10.0),
                                            labelStyle: TextStyle(color: Colors.grey.shade600,),

                                          ),

                                          style: TextStyle(
                                              fontSize: 12.0,
                                              //height: 2.0,
                                              color: Colors.black
                                          ),

                                        ),
                                      ),
                                    ),


                                  ],
                                ),

                                SizedBox(height: 30,),


                                Text("Insulin Details:",style: TextStyle(fontSize: 20,color: Colors.green,fontWeight: FontWeight.bold),),
                                SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    Container(
                                      width: MediaQuery.of(context).size.width/4,
                                      child :Text("Insulin 1 :",style: TextStyle(fontSize: 16,color: Colors.green,fontWeight: FontWeight.bold),),
                                    ),
                                    SizedBox(width: 5,),
                                    Container(
                                      width: MediaQuery.of(context).size.width/2,
                                      child: TextFormField(
                                        controller: _insulinoneController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,//this has no effect
                                            ),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          labelText: 'Type Insulin Brand',
                                          alignLabelWithHint:true,
                                          counterText: "",
                                          contentPadding: EdgeInsets.fromLTRB(8.0, 10.0, 5.0, 10.0),
                                          labelStyle: TextStyle(color: Colors.grey.shade600,),

                                        ),

                                        style: TextStyle(
                                            fontSize: 12.0,
                                            //height: 2.0,
                                            color: Colors.black
                                        ),

                                      ),
                                    ),

                                  ],
                                ),
                                SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    Container(
                                      width: MediaQuery.of(context).size.width/4,
                                      child :Text("Dosage :",style: TextStyle(fontSize: 16,color: Colors.green,fontWeight: FontWeight.bold),),
                                    ),
                                    // SizedBox(width: 5,),
                                    Container(
                                      color: Colors.green[100],
                                      width: MediaQuery.of(context).size.width/5,
                                      child: TextFormField(
                                        controller: _minsulinoneController,
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          hintText: 'M',
                                          alignLabelWithHint:true,
                                          counterText: "",
                                          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
                                          labelStyle: TextStyle(color: Colors.grey.shade600,),
                                        ),

                                        style: TextStyle(
                                            fontSize: 12.0,
                                            //height: 2.0,
                                            color: Colors.black
                                        ),

                                      ),
                                    ),
                                    Container(

                                      width: MediaQuery.of(context).size.width/5,
                                      child: TextFormField(
                                        controller: _ainsulinoneController,
                                        textAlign:TextAlign.center,
                                        decoration: InputDecoration(

                                          counterText: "",
                                          contentPadding: EdgeInsets.fromLTRB(0, 10.0, 5.0, 10.0),
                                          hintText: 'A',
                                          alignLabelWithHint:true,
                                          labelStyle: TextStyle(color: Colors.grey.shade600,),
                                        ),

                                        style: TextStyle(
                                            fontSize: 12.0,

                                            //height: 2.0,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.green[100],
                                      width: MediaQuery.of(context).size.width/5,
                                      child: TextFormField(
                                        controller: _einsulinoneController,
                                        textAlign:TextAlign.center,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),

                                          hintText: 'E',
                                          alignLabelWithHint:true,
                                          labelStyle: TextStyle(color: Colors.grey.shade600,),
                                        ),

                                        style: TextStyle(
                                            fontSize: 12.0,

                                            //height: 2.0,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                                SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    Container(
                                      width: MediaQuery.of(context).size.width/4,
                                      child :Text("Insulin 2 :",style: TextStyle(fontSize: 16,color: Colors.green,fontWeight: FontWeight.bold),),
                                    ),
                                    SizedBox(width: 5,),
                                    Container(
                                      width: MediaQuery.of(context).size.width/2,
                                      child: TextFormField(
                                        controller: _insulintwoController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,//this has no effect
                                            ),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          labelText: 'Type Insulin Brand',
                                          alignLabelWithHint:true,
                                          counterText: "",
                                          contentPadding: EdgeInsets.fromLTRB(8.0, 10.0, 5.0, 10.0),
                                          labelStyle: TextStyle(color: Colors.grey.shade600,),

                                        ),

                                        style: TextStyle(
                                            fontSize: 12.0,
                                            //height: 2.0,
                                            color: Colors.black
                                        ),

                                      ),
                                    ),

                                  ],
                                ),
                                SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    Container(
                                      width: MediaQuery.of(context).size.width/4,
                                      child :Text("Dosage :",style: TextStyle(fontSize: 16,color: Colors.green,fontWeight: FontWeight.bold),),
                                    ),
                                    // SizedBox(width: 5,),
                                    Container(
                                      color: Colors.green[100],
                                      width: MediaQuery.of(context).size.width/5,
                                      child: TextFormField(
                                        controller: _minsulintwoController,
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          hintText: 'M',
                                          alignLabelWithHint:true,
                                          counterText: "",
                                          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
                                          labelStyle: TextStyle(color: Colors.grey.shade600,),
                                        ),

                                        style: TextStyle(
                                            fontSize: 12.0,
                                            //height: 2.0,
                                            color: Colors.black
                                        ),

                                      ),
                                    ),
                                    Container(

                                      width: MediaQuery.of(context).size.width/5,
                                      child: TextFormField(
                                        controller: _ainsulintwoController,
                                        textAlign:TextAlign.center,
                                        decoration: InputDecoration(

                                          counterText: "",
                                          contentPadding: EdgeInsets.fromLTRB(0, 10.0, 5.0, 10.0),
                                          hintText: 'A',
                                          alignLabelWithHint:true,
                                          labelStyle: TextStyle(color: Colors.grey.shade600,),
                                        ),

                                        style: TextStyle(
                                            fontSize: 12.0,

                                            //height: 2.0,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.green[100],
                                      width: MediaQuery.of(context).size.width/5,
                                      child: TextFormField(
                                        controller: _einsulintwoController,
                                        textAlign:TextAlign.center,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),

                                          hintText: 'E',
                                          alignLabelWithHint:true,
                                          labelStyle: TextStyle(color: Colors.grey.shade600,),
                                        ),

                                        style: TextStyle(
                                            fontSize: 12.0,

                                            //height: 2.0,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    Container(
                                      width: MediaQuery.of(context).size.width/3,
                                      child :Text("Body Temperature :",style: TextStyle(fontSize: 16,color: Colors.green,fontWeight: FontWeight.bold),),
                                    ),
                                    SizedBox(width: 5,),
                                    Container(
                                      width: MediaQuery.of(context).size.width/3,
                                      child: TextFormField(
                                        controller: _bodyTemperatureController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            int s = int.tryParse(value);
                                            if (s == null || s <= 0) {
                                              return 'must be > 0';
                                            }
                                            return 'This field cannot be empty';
                                          } else
                                            return null;
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'in °F',
                                          alignLabelWithHint:true,
                                          counterText: "",
                                          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
                                          labelStyle: TextStyle(color: Colors.grey.shade600,),
                                        ),

                                        style: TextStyle(
                                            fontSize: 12.0,
                                            //height: 2.0,
                                            color: Colors.black
                                        ),

                                      ),
                                    ),


                                  ],
                                ),
                                SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FlatButton(
                                      minWidth: MediaQuery.of(context).size.width/3,
                                      child:new Text("Discard",style: TextStyle(
                                          fontSize: 20.0,

                                          //height: 2.0,
                                          color: Colors.white),),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },


                                      color: Colors.green,
                                    ),
                                    FlatButton(
                                      minWidth: MediaQuery.of(context).size.width/3,
                                      child:new Text("Save",style: TextStyle(
                                          fontSize: 20.0,

                                          //height: 2.0,
                                          color: Colors.white),),
                                      onPressed: () async{

                                        String uid=FirebaseAuth.instance.currentUser.uid.toString();
                                        d=_dateTime.toString();
                                        if (_key.currentState.validate()) {
                                          // ignore: unrelated_type_equality_checks
                                          if(_dateTime!=null){
                                            await DatabaseManager().createHealthRecords(_dateTime.toString(),SystolicController.text,DiastolicController.text,_bodyTemperatureController.text,
                                                _bbeforeController.text,_bafterController.text,_lbeforeController.text,_lafterController.text,_dbeforeController.text,
                                                _dafterController.text,_foodController.text,_insulinoneController.text,
                                                _minsulinoneController.text,_ainsulinoneController.text,_einsulinoneController.text,
                                                _insulintwoController.text,
                                                _minsulintwoController.text,_ainsulintwoController.text,_einsulintwoController.text);
                                            //TO SEND MAIL
                                            user = auth.currentUser;
                                            _recipientController.text=user.email;
                                            _subjectController.text="Your Ward Normal Routine CheckUp Results: ";
                                            _bodyController.text=
                                                "BP Sytolic/Diastolic = "+SystolicController.text+"/"+DiastolicController.text+
                                                    "\nSugar/Food Details\n"
                                                        "Break Fast:Before"+_bbeforeController.text+" After"+_bafterController.text+
                                                    "\nLunch:Before"+_lbeforeController.text+" After"+_lafterController.text+
                                                    "\nDinner:Before"+_dbeforeController.text+" After"+_dafterController.text+
                                                    "\nInsulin 1 Brand: "+_insulinoneController.text+
                                                    "\n  M:"+_minsulinoneController.text+"  A:"+_ainsulinoneController.text+"  E:"+_einsulinoneController.text+
                                                    "\nInsulin 2 Brand: "+_insulintwoController.text+
                                                    "\n  M:"+_minsulintwoController.text+"  A:"+_ainsulintwoController.text+"  E:"+_einsulintwoController.text;
                                            await send();



                                            Navigator.of(context).pop();
                                          }
                                          if(_dateTime==null){
                                            Fluttertoast.showToast(
                                                msg: "Pick The Date.",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 2,
                                                backgroundColor: Colors.black54,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }



                                        }
                                        //Upload TO FIREBASE
                                        ///Map <String,dynamic> data={"DateTime ":_dateTime,"Systolic":SystolicController.text,"Diastolic":DiastolicController.text};
                                        //FirebaseFirestore.instance.collection("profileInfo").doc(uid).collection("Health").add(data);




                                      },
                                      color: Colors.green,
                                    )
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ],

                      ),

                    ),

                  ]
              ),
            ),
        ),
      ),
    );

  }
  Future<void> send() async {

    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: [_recipientController.text,_parentController.text],
      //attachmentPaths: attachments,
      isHTML: false,
    );
    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
      Fluttertoast.showToast(
          msg: "Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } catch (error) {
      platformResponse = error.toString();
    }
  }

}

