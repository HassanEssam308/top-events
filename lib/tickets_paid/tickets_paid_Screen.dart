import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:top_events/tickets_paid/paid_controller.dart';


import '../all_Tickets/tickets_storage.dart';

class TicketsPaidScreen extends StatelessWidget {
  const TicketsPaidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<paidController>(
          init: paidController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  CreditCardWidget(
                    cardNumber: controller.cardNumber,
                    expiryDate: controller.expiryDate,
                    cardHolderName: controller.cardHolderName,
                    cvvCode: controller.cvvCode,
                    showBackView: controller.isCvvFocused,
                    obscureCardNumber: true,
                    obscureCardCvv: true,
                    onCreditCardWidgetChange: (CreditCardBrand) {},
                  ),
                  SizedBox(height: 20), // Adjust spacing as needed
                  CreditCardForm(
                    cardNumber: controller.cardNumber,
                    expiryDate: controller.expiryDate,
                    cardHolderName: controller.cardHolderName,
                    cvvCode: controller.cvvCode,
                    onCreditCardModelChange: controller.onCreditCardModelChange,
                    formKey: controller.formKey,
                  ),
                  SizedBox(height: 20), // Adjust spacing as needed
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor: Color(0xff1b447b),
                    ),
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      child: Text(
                        'Paid',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'halter',
                          fontSize: 14,
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        print('valid');
                        Get.to(TicketsStorage());
                        // Add further actions here like sending the data to the server or saving it
                      } else {
                        print('inValid');
                      }
                    },
                  ),
                  SizedBox(height: 20), // Adjust spacing as needed
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
