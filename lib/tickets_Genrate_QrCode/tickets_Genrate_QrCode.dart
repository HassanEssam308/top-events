import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_events/tickets_Genrate_QrCode/controller_Genrate_Qrcode.dart';
import 'package:top_events/tickets_paid/tickets_paid_Screen.dart';

class TicketsGenrateQrcode extends StatelessWidget {
  const TicketsGenrateQrcode({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                    Colors.deepPurple.shade400,
                    Colors.deepPurple.shade600,
                  ])),
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Login Your Account",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),

                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(60),
                                topRight: Radius.circular(60))),
                        child: Padding(
                            padding: EdgeInsets.only(top: 40, right: 15, left: 15),
                            child: SingleChildScrollView(
                              child: Column(children: [
                                GetBuilder<GenrateQrcodeController>(
                                  init: GenrateQrcodeController(),
                                  builder: (controller) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10),
                                      child:Column(children: [
                                        Container(
                                          alignment: Alignment.center,
                                          child: TextField(
                                            controller:controller.name,
                                            decoration: InputDecoration(
                                                hintText: 'Enter your name',
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.blue, width: 2))),
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                        Container(
                                          alignment: Alignment.center,
                                          child: TextField(
                                            controller: controller.code,
                                            decoration: InputDecoration(
                                                hintText: 'Enter personal id',
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.blue, width: 2))),
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                        Container(
                                          alignment: Alignment.center,
                                          child: TextField(
                                            controller: controller.phone,
                                            decoration: InputDecoration(
                                                hintText: 'Enter phone',
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.blue, width: 2))),
                                          ),
                                        ),


                                        ElevatedButton(
                                            onPressed: () async {
                                               await controller.storeTicketdata();
                                                Get.to(TicketsPaidScreen());
                                            },
                                            child: Text("Go To paid")),
                                        // ElevatedButton(onPressed: _ca
                                      ],)
                                    );
                                  },
                                )
                              ]),
                            ))))
              ]),
            )));
  }
}
