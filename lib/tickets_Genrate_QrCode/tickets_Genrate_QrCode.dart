import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:top_events/tickets_Genrate_QrCode/controller_Genrate_Qrcode.dart';
import 'package:top_events/tickets_paid/tickets_paid_Screen.dart';
import '../all_Tickets/tickets_storage.dart';


class TicketsGenrateQrcode extends StatelessWidget {
  String eventid;
   TicketsGenrateQrcode({super.key,required this.eventid});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Get Tickets",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GetBuilder<GenrateQrcodeController>(
                init: GenrateQrcodeController(eventid:eventid),
                builder: (controller) {
                  return Column(
                    children: [
                      SizedBox(height: 20),
                      CreditCardWidget(
                        customCardTypeIcons: [
                          CustomCardTypeIcon(cardType: CardType.otherBrand
                              , cardImage: Image.asset("image/master.png",
                              height: 50,
                              width: 50,))
                        ],
                        cardBgColor: Colors.black,
                        cardNumber: controller.cardNumber,
                        expiryDate: controller.expiryDate,
                        cardHolderName: controller.cardHolderName,
                        cvvCode: controller.cvvCode,
                        showBackView: controller.isCvvFocused,
                        obscureCardNumber: true,
                        obscureCardCvv: true,
                        onCreditCardWidgetChange: (CreditCardBrand) {},
                      ),


                      CreditCardForm(
                        cardNumber: controller.cardNumber,
                        expiryDate: controller.expiryDate,
                        cardHolderName: controller.cardHolderName,
                        cvvCode: controller.cvvCode,
                        onCreditCardModelChange:
                        controller.onCreditCardModelChange,
                        formKey: controller.formKey,
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 17),
                        alignment: Alignment.center,
                        child: TextField(
                          controller: controller.name,
                          decoration: InputDecoration(
                            labelText: 'Enter your name',
                            hintText: 'Enter your name',

                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 17),
                        alignment: Alignment.center,
                        child: TextField(
                          controller: controller.code,
                          decoration: InputDecoration(
                            hintText: 'Enter personal ID',
                            labelText: 'personal Id',

                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 17),
                        alignment: Alignment.center,
                        child: TextField(
                          controller: controller.phone,
                          decoration: InputDecoration(
                            hintText: 'Enter phone',
                            labelText: 'phone',

                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: Colors.deepPurple,
                        ),
                        onPressed: () async {
                          await controller.storeTicketdata(context);
                          if (controller.formKey.currentState!.validate()) {

                            Get.to(TicketsStorage(),transition:Transition.zoom);

                          } else {
                            print('Invalid');
                          }
                        },
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
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
