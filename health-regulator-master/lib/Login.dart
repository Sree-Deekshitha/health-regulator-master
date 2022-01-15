import 'package:allincluded/EnterDetails.dart';
import 'package:allincluded/UserDetails.dart';
import 'package:allincluded/registration.dart';
import 'package:allincluded/services/Autherisation.dart';
import 'package:allincluded/services/DatabaseManager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dcdg/dcdg.dart';
import 'package:allincluded/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
class LoginPage extends StatefulWidget {
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = true;

  void _toggleVisibility(){
    setState(() {
      _isHidden = !_isHidden;
    });
  }
  final _key = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;

  User user;

  TextEditingController _emailContoller = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //height: MediaQuery.of(context).size.height,
        body: SingleChildScrollView(

          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          color: Colors.green[400],
            child: Center(
              child: Form(
                  key: _key,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                    'Login',
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
                          SizedBox(height: 30),
                          TextFormField(
                          controller: _emailContoller,
                          validator: (value) {
                          if (value.isEmpty) {
                          return 'Email cannot be empty';
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
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white)),
                          style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _isHidden,

                            validator: (value) {
                            if (value.isEmpty) {
                            return 'Password cannot be empty';
                            } else
                            return null;
                            },
                            decoration: InputDecoration(
                            labelText: 'Password',
                            suffix: InkWell(
                              onTap: _toggleVisibility,
                              child: Icon(
                                _isHidden
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          labelStyle: TextStyle(color: Colors.white)),
                          style: TextStyle(
                          color: Colors.white,
                          ),
                          ),
                          SizedBox(height: 5),
                          FlatButton(
                          child: Text('Not registerd? Sign up'),
                          onPressed: () {
                          Navigator.of(context).push(
                          CupertinoPageRoute(
                          //fullscreenDialog: true, builder: (BuildContext context) {  },
                          builder: (context) => RegisterPage(),
                          ),
                          );
                          },
                          textColor: Colors.white,
                          ),
                          SizedBox(height: 30),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FlatButton(
                              child: Text('Login'),
                                onPressed: () async {
                                  if (_key.currentState.validate()) {
                                    bool shouldNavigate = await signIn(_emailContoller.text, _passwordController.text);
                                    if (shouldNavigate) {
                                        String uid=FirebaseAuth.instance.currentUser.uid.toString();
                                        user = auth.currentUser;
                                        await user.reload();
                                        if (user.emailVerified) {

                                          bool docExists = await DatabaseManager()
                                              .checkIfDocExists(uid);
                                          print("Document exists in Firestore? " +
                                              docExists.toString());
                                          if (docExists) {
                                            SharedPreferences prefs = await SharedPreferences.getInstance();
                                            prefs?.setBool("isLoggedIn", true);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Homepage(),

                                              ),
                                            );

                                          }



                                          else if(!docExists) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EnterDetails(),

                                              ),
                                            );
                                          }
                                        }else if(!user.emailVerified){
                                          Fluttertoast.showToast(
                                              msg: "Please Verify Email Then Login",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 2,
                                              backgroundColor: Colors.black54,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }

                                    }
                                  }
                                },
                            color: Colors.white,
                            ),
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
        ),);
    }
}