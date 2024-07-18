// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:top_events/tickets_Scann_QrCode/controller_Scan_Qrcode.dart';
//
// class TicketsScannQrcode extends StatelessWidget {
//    TicketsScannQrcode({super.key});
//   final _firestore = FirebaseFirestore.instance;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//               Padding(
//                           padding: EdgeInsets.only(top: 40, right: 15, left: 15),
//                           child: SingleChildScrollView(
//                             child: Column(children: [
//                               GetBuilder<ScannerQrcodeController>(
//                                 init: ScannerQrcodeController(),
//                                 builder: (controller) {
//                                   return Padding(
//                                     padding: const EdgeInsets.all(10),
//                                     child:Column(
//                                       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                       // crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         Text(controller.qrstr,style: TextStyle(color: Colors.blue,fontSize: 30),),
//                                         ElevatedButton(onPressed:controller.scanQr, child:
//                                         Text(('Scanner'))),
//                                         SizedBox(height: 50,),
//                                         ElevatedButton(
//                                             onPressed:(){controller.splitcode();}, child:
//                                         Text(('search'))),
//
//                                         StreamBuilder(
//                                             stream: _firestore.collection('tickets')
//                                                 .where('qrcode', isEqualTo: controller.oneid).
//                                             where('eventid', isEqualTo: controller.twoid).snapshots(),
//                                             builder: (context, snapshot) {
//                                               if (!snapshot.hasData) {
//                                                 return Center(
//                                                     child: CircularProgressIndicator());
//                                               }
//
//                                               List<DocumentSnapshot> docs1 = snapshot.data!.docs;
//
//                                               return ListView.builder(
//                                                   itemCount: docs1.length,
//                                                   itemBuilder: (context, index) {
//                                                     String text = docs1[index].get('qrcode');
//                                                     String name = docs1[index].get('name');
//                                                     String eventId = docs1[index].get('eventid');
//                                                     String userId = docs1[index].get('userid');
//
//                                                     return SingleChildScrollView(
//                                                       child: Card(
//                                                         child: Column(
//                                                           children: [
//                                                             Text(name),
//                                                             SizedBox(height: 20,),
//                                                             Text(text)
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     );
//
//                                                   });
//                                             })
//
//
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               )
//                             ]),
//                           )),
//     ]))
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_events/tickets_Scann_QrCode/controller_Scan_Qrcode.dart';

class TicketsScannQrcode extends StatelessWidget {
  TicketsScannQrcode({super.key});
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Scan qr"),
        backgroundColor: Colors.deepPurple,),
        body: Padding(
          padding: EdgeInsets.only(top: 40, right: 15, left: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GetBuilder<ScannerQrcodeController>(
                  init: ScannerQrcodeController(),
                  builder: (controller) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [

                          ElevatedButton(
                            onPressed: controller.scanQr,
                            child: Text('Scanner'),
                          ),
                          SizedBox(height: 50),
                          ElevatedButton(
                            onPressed: controller.splitcode,
                            child: Text('Search'),
                          ),
                          StreamBuilder(
                            stream: _firestore
                                .collection('tickets')
                                .where('qrcode', isEqualTo: controller.oneid)
                                .where('eventid', isEqualTo: controller.twoid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              List<DocumentSnapshot> docs1 = snapshot.data!.docs;

                              return Container(
                                height: 300, // or another fixed height
                                child: ListView.builder(
                                  itemCount: docs1.length,
                                  itemBuilder: (context, index) {
                                    String text = docs1[index].get('qrcode');
                                    String name = docs1[index].get('name');
                                    String eventId = docs1[index].get('eventid');
                                    String userId = docs1[index].get('userid');

                                    return Card(
                                      child: Column(
                                        children: [
                                          Text(name),
                                          SizedBox(height: 20),
                                          Text(text),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

