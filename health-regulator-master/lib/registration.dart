import 'package:allincluded/HomePage.dart';
import 'package:allincluded/Verify.dart';
import 'package:allincluded/services/Autherisation.dart';
import 'package:allincluded/services/DatabaseManager.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dcdg/dcdg.dart';
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _key = GlobalKey<FormState>();

  bool _isHidden = true;

  void _toggleVisibility(){
    setState(() {
      _isHidden = !_isHidden;
    });
  }
    

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
                    'Register',
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
                              suffix: InkWell(
                                onTap: _toggleVisibility,
                                child: Icon(
                                  _isHidden
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.white)),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FlatButton(
                              child: Text('Sign Up'),
                              onPressed: () async {
                                if (_key.currentState.validate()) {
                                  //createUser();
                                  bool shouldNavigate = await register(
                                      _emailContoller.text,
                                      _passwordController.text);

                                  if (shouldNavigate) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => VerifyScreen(),

                                      ),
                                    );

                                    //await DatabaseManager().createUserDetails(_emailContoller.text,_nameController.text,_selected,_dateTime,_PhnoController.text,_AddressController.text,uid);

                                  }
                                }
                              },

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

  checkIfDocExists(String uid) {}


}
