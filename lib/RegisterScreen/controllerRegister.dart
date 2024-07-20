import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controllerregister extends GetxController {
  final auth = FirebaseAuth.instance;
  bool state = false;
  var isscure=true.obs;

  TextEditingController name = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController ID = TextEditingController();
  TextEditingController phone = TextEditingController();
  String image ='';

  Future<void> creatacount() async {

    if (Email.text.isEmpty ||
        pass.text.isEmpty ||
        name.text.isEmpty ||
        ID.text.isEmpty ||
        phone.text.isEmpty) {
      if (kDebugMode) {
        print("please enter data");
      }
    } else {
      try {
        await auth.createUserWithEmailAndPassword(
            email: Email.text, password: pass.text);
        state = true;
        if (kDebugMode) {
          print(
            "iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  storedata(BuildContext context) async {


    if (Email.text.isEmpty ||
        pass.text.isEmpty ||
        name.text.isEmpty ||
        ID.text.isEmpty ||
        phone.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter all the data"),
          duration: Duration(seconds: 2),
        ),
      );
    }
    else if(ID.text.length != 14 && phone.text.length != 12 ){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter right Personal Id or phone"),
          duration: Duration(seconds: 2),
        ),
      );
    }
    else {
      try {
        final User? user = auth.currentUser;
        final uid = user!.uid;
        await FirebaseFirestore.instance.collection("users").doc(uid).set({
          'email': Email.text,
          'name': name.text,
          'personalId': ID.text,
          'phone': phone.text,
          'isAdmin':false,
          'image':image
        });
        state = true;
        if (kDebugMode) {
          print('Document added successfully');
        }
      } on FirebaseException catch (e) {
        if (kDebugMode) {
          print('Error: $e');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error: $e');
        }
      }
    }
  }

  void seenpassword(){
    isscure.value=!isscure.value;
    refresh();


  }
}
