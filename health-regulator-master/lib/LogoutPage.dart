import 'package:allincluded/HomePage.dart';
import 'package:allincluded/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dcdg/dcdg.dart';
class LogOutPage extends StatelessWidget {

  final auth = FirebaseAuth.instance;
  User user;

  @override
  Widget build(BuildContext context) {
    user = auth.currentUser;
    return MaterialApp (
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Homepage()));
            },
            child: Icon(
              Icons.arrow_back,  // add custom icons also
            ),
          ),

        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/img/best.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(

                  child:Text("Present Account:  \n"+"      "+user.email, style: TextStyle(fontSize: 25, fontFamily: 'EB',fontWeight: FontWeight.bold),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0,130.0,8.0,40.0),
                child: Container(
                  child: Center(
                    child: InkWell(
                      onTap: () async{
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs?.clear();
                        auth.signOut();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      child: Container(
                        //padding: const EdgeInsets.all(10.0),

                        width : 160,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                            offset:Offset(0.0,20.0),blurRadius: 30.0,color:Colors.black12,
                          ),],color: Colors.white,borderRadius: BorderRadius.circular(22.0)

                        ),
                        child:Row(
                          children: [Container(
                            height: 50.0,
                            width: 110.0,
                          padding: EdgeInsets.symmetric(vertical: 14.0,horizontal: 4.0),
                          child: Text("  LOGOUT",style: Theme.of(context).textTheme.button.apply(color:Colors.white,),),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                              bottomLeft:Radius.circular(98.0),
                              topLeft:Radius.circular(98.0),
                              bottomRight:Radius.circular(200.0)
                            ),
                          ),
                        ),

                            Icon(Icons.logout,size: 30.0,color: Colors.green,),

                        ]
                      ),
                  ),
                    ),
       ),
                ),
              ),
            ],
          ),
        ),
     ),
    );
  }
}
