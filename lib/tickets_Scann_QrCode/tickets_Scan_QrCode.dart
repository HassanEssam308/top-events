import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_events/tickets_Scann_QrCode/controller_Scan_Qrcode.dart';

class TicketsScannQrcode extends StatelessWidget {
  const TicketsScannQrcode({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Padding(
                          padding: EdgeInsets.only(top: 40, right: 15, left: 15),
                          child: SingleChildScrollView(
                            child: Column(children: [
                              GetBuilder<ScannerQrcodeController>(
                                init: ScannerQrcodeController(),
                                builder: (controller) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child:Column(
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(controller.qrstr,style: TextStyle(color: Colors.blue,fontSize: 30),),
                                        ElevatedButton(onPressed:controller.scanQr, child:
                                        Text(('Scanner'))),
                                        SizedBox(height: 100,)
                                      ],
                                    ),
                                  );
                                },
                              )
                            ]),
                          )),
    ]))
    );
  }
}
