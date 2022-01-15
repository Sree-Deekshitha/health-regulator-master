import 'package:allincluded/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:allincluded/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:dcdg/dcdg.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLoggedIn = (prefs.getBool('isLoggedIn') == null) ? false : prefs.getBool('isLoggedIn');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: isLoggedIn ? MyAppOther() : MyApp(),
  ));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Records',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),

      home: Splashscreen(),
    );
  }
}
class MyAppOther extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Records',
      home: new SplashScreen(
        title: new Text(
          'Welcome',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        seconds: 4,

        navigateAfterSeconds: Homepage(),
        //image: new Image.asset('assets/loading.gif'),
        image: new Image.network('https://firebasestorage.googleapis.com/v0/b/miniproject5717.appspot.com/o/exercises%2Fhealth.png?alt=media&token=1643111f-8744-418c-a9d3-3cabd0e512fe'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 150.0,
        onClick: () => print("Flutter Egypt"),
        loaderColor: Colors.lightGreenAccent,
      ),
    );

  }
}

