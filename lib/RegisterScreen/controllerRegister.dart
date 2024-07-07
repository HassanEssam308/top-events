import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Controllerregister extends GetxController {
  final _auth = FirebaseAuth.instance;
  bool state = false;
  var isscure=true.obs;

  TextEditingController name = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController ID = TextEditingController();
  TextEditingController phone = TextEditingController();

  Future<void> creatacount() async {
    if (Email.text.isEmpty ||
        pass.text.isEmpty ||
        name.text.isEmpty ||
        ID.text.isEmpty ||
        phone.text.isEmpty) {
      print("please enter data");
    } else {
      try {
        await _auth.createUserWithEmailAndPassword(
            email: Email.text, password: pass.text);
        state = true;
        print(
            "iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
      } catch (e) {
        print(e);
      }
    }
  }

  storedata() async {
    if (Email.text.isEmpty ||
        pass.text.isEmpty ||
        name.text.isEmpty ||
        ID.text.isEmpty ||
        phone.text.isEmpty) {
      print("please enter data");
    } else {
      try {
        await FirebaseFirestore.instance.collection('users').add({
          'email': Email.text,
          'name': name.text,
          'personalId': ID.text,
          'phone': phone.text
        });
        state = true;
        print('Document added successfully');
      } on FirebaseException catch (e) {
        print('Error: $e');
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void seenpassword(){
    isscure.value=!isscure.value;
    refresh();


  }
}
