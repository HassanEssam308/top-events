import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:top_events/Home/views/home_screen.dart';



class GenrateQrcodeController extends GetxController{
  String eventid;
  GenrateQrcodeController({required this.eventid});
  bool stat=false;

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
    }
    else if(code.text.length != 14 && phone.text.length != 12 ){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Enter right Personal Id or phone"),
          duration: Duration(seconds: 2),
        ),
      );
    }
    else {

      try {
        stat=true;
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

  void showAlertDialog(BuildContext context) {
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(),
          ),

        ); // Close the dialog
      },
    );

    AlertDialog alert = AlertDialog(


      content:Container(
        height: 160,
        child: Column(
          children: [
            LottieBuilder.asset("lottie/Verified.json",width: 120,height: 120,),
            SizedBox(height: 10,),
            Text("Paid Succses",style: TextStyle(fontSize: 18),),
          ],
        ),
      ),


      actions: [continueButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


}
