import 'package:flutter/cupertino.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class paidController extends GetxController{
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



}