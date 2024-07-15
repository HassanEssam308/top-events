import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';



class GenrateQrcodeController extends GetxController{
  TextEditingController code = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  storeTicketdata() async {
    if (name.text.isEmpty ||
        code.text.isEmpty
    ) {
      print("please enter data");
    } else {
      try {
        await FirebaseFirestore.instance.collection("tickets").doc(code.text).set({
          'name': name.text,
          'qrcode': code.text,
          'phone': phone.text,
        });

        print('Document added successfully');
      } on FirebaseException catch (e) {
        print('Error: $e');
      } catch (e) {
        print('Error: $e');
      }

    }
  }
}