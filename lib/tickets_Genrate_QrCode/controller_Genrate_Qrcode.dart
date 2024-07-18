import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';



class GenrateQrcodeController extends GetxController{
  String eventid;
  GenrateQrcodeController({required this.eventid});

  TextEditingController code = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  late DocumentSnapshot snap;
  String cardNumber = '';
  String expiryDate= '';
  String cardHolderName = '';
  String cvvCode= '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  void onCreditCardModelChange(CreditCardModel creditCardModel){

    cardNumber = creditCardModel.cardNumber;
    expiryDate = creditCardModel.expiryDate;
    cardHolderName = creditCardModel.cardHolderName;
    cvvCode = creditCardModel.cvvCode;
    isCvvFocused = creditCardModel.isCvvFocused;
    update();
  }





  storeTicketdata(BuildContext context) async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    if (name.text.isEmpty ||
        code.text.isEmpty||
        phone.text.isEmpty
    ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter all the data"),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      try {
        await FirebaseFirestore.instance.collection("tickets").doc(code.text).set(
            {
              'userid': uid,
              'name': name.text,
              'qrcode': code.text,
              'phone': phone.text,
              'eventid':eventid,
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
