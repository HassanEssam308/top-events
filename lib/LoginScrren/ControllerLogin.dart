import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controllerlogin extends GetxController{
  final _auth=FirebaseAuth.instance;
  TextEditingController Email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool state =false;
  var isscure=true.obs;


  login() async {
    if (Email.text.isEmpty || pass.text.isEmpty) {
      print("please enter data");
    } else {
      try {
        print(Email.text.toString()+"gggg");
         await _auth.signInWithEmailAndPassword(
          email: Email.text,
          password: pass.text,
        );
        state=true;
      } catch (e) {
        if (e is FirebaseAuthException) {
          switch (e.code) {
            case "invalid-email":
              print("invalid-email");
              break;
            case "user-disabled":
              print("user-disabled");
              break;
            case "user-not-found":
              print("user-not-found");
              break;
            case "wrong-password":
              print("wrong-password");
              break;
            default:
              print("An unknown error occurred.");
              break;
          }
        } else {
          print("An unknown error occurred.");
        }
      }
    }
  }

  resetpassword()async{
    await _auth.sendPasswordResetEmail(email: Email.text);
  }

    void seenpassword(){
     isscure.value=!isscure.value;
     refresh();


  }




}