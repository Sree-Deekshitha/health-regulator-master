import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:allincluded/services/DatabaseManager.dart';

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    return true;
  } catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      Fluttertoast.showToast(
          msg: "No user found for that email.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      Fluttertoast.showToast(
          msg: "Wrong password provided for that user.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else if (e.code == 'invalid-email') {
      print('Wrong password provided for that user.');
      Fluttertoast.showToast(
          msg: "Wrong password provided for that user.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    print(e);
    return false;
  }
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
      Fluttertoast.showToast(
          msg: "The password provided is too weak.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
      Fluttertoast.showToast(
          msg: "The account already exists for that email.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}