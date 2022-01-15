import 'package:allincluded/Login.dart';
import 'package:allincluded/services/DatabaseManager.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dcdg/dcdg.dart';
class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  Widget build(BuildContext context) {

    return new SplashScreen(
      title: new Text(
        'Welcome',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      seconds: 4,

        navigateAfterSeconds: LoginPage(),
      //image: new Image.asset('assets/loading.gif'),
      image: new Image.network('https://firebasestorage.googleapis.com/v0/b/miniproject5717.appspot.com/o/exercises%2Fhealth.png?alt=media&token=1643111f-8744-418c-a9d3-3cabd0e512fe'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 150.0,
      onClick: () => print("Flutter Egypt"),
      loaderColor: Colors.lightGreenAccent,
    );

  }

}