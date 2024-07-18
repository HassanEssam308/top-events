import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:top_events/add_event/models/event_model.dart';

class TicketsStorage extends StatelessWidget {
  TicketsStorage({super.key});

  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _firestore.collection('tickets').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  List<DocumentSnapshot> docs1 = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: docs1.length,
                    itemBuilder: (context, index) {
                      String text = docs1[index].get('qrcode');
                      String name = docs1[index].get('name');
                      String eventId = docs1[index].get('eventid');

                      return StreamBuilder(
                          stream: _firestore.collection('events').doc(eventId).snapshots(),
                          builder: (context, eventSnapshot) {
                            if (eventSnapshot.hasError) {
                              Get.snackbar('Error', eventSnapshot.error.toString());
                              return const Text('Something went wrong');
                            }

                            if (eventSnapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(color: Colors.purpleAccent,
                                ),
                              );
                            }

                            var doc2= eventSnapshot.data!;
                            EventModel eventModel= EventModel.fromFireStoreBySnapshot(doc2);
                            print('*********** eventSnapshot=${eventModel.eventTitle}');
                            return Card(
                              child: ExpansionTile(
                                collapsedBackgroundColor: Colors.white,
                                backgroundColor: Colors.deepPurple,

                                title: Text(eventModel.eventTitle??"no Data"),
                                // Display event name as title
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TicketWidget(
                                      color: Colors.white,
                                      width: 300,
                                      height: 300,
                                      isCornerRounded: true,
                                      padding: EdgeInsets.all(10),
                                      child: Stack(children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            BarcodeWidget(
                                              data: text,
                                              barcode: Barcode.qrCode(),
                                              color: Colors.black,
                                              height: 150,
                                              width: 150,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              text,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            // Add additional widgets as needed
                                          ],
                                        ),
                                      ]),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
