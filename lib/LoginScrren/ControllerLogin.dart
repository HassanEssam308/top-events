import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class Controllerlogin extends GetxController{
  final _auth=FirebaseAuth.instance;
  TextEditingController Email = TextEditingController();
  TextEditingController pass = TextEditingController();
  Rx<bool> state =Rx(false);
  var isscure=true.obs;

  @override
  onReady(){
    box.write("isFirstOpen", false);
  }

 Future<void> login(BuildContext context) async {
    if (Email.text.isEmpty || pass.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter all the data"),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      try {
        print(Email.text.toString()+"gggg");
         await _auth.signInWithEmailAndPassword(
          email: Email.text,
          password: pass.text,
        );
        state.value=true;
        refresh();
      } catch (e) {
        if (e is FirebaseAuthException) {
          Get.snackbar('Login Error',e.code );
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

  void saveUserIdInGetStorage() {

    if(_auth.currentUser!=null){
      box.write('uid',_auth.currentUser?.uid);
    }
  }

 Future<void>saveIsAdminUseInGetStorage() async {
    try{
  await fireStoreInstance.collection('users')
    .doc(_auth.currentUser?.uid)
      .get()
      .then(( DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    if (documentSnapshot.exists) {

      bool isAdmin=  documentSnapshot.data()?['isAdmin'];
      box.write('isAdmin',isAdmin);
      if (kDebugMode) {
        print('**saveIsAdminUseInGetStorage***Login***Document data: ${documentSnapshot.data()}');
        print('**saveIsAdminUseInGetStorage**Login**isAdmin: ${isAdmin}');

      }


    } else {
      if (kDebugMode) {
        print('*********Document does not exist on the database');
      }
      box.write('isAdmin',false);

    }
  }).catchError((err){
    if (kDebugMode) {
      print('saveIsAdminUseInGetStorage ********* Error =$err');
    }
  });

    }catch(error){
      if (kDebugMode) {
        print('saveIsAdminUseInGetStorage *********catch Error =$error');
      }
    }
  }




}