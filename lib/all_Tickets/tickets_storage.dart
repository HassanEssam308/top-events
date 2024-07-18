import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:top_events/add_event/models/event_model.dart';

class TicketsStorage extends StatelessWidget {
  TicketsStorage({super.key});

  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:Text(" all tikestes",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(
          children: [
            SizedBox(height: 20,),
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
                      String userId=docs1[index].get('userid');


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
                            print('***********eventSnapshot=${eventModel.eventTitle}');
                            return Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              margin: EdgeInsets.only(
                                  top: 10, right: 10, left: 10, bottom: 5),
                              child: ExpansionTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                backgroundColor: Colors.white,
                                title: Text('${eventModel.eventTitle}'), // Display event name as title
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TicketWidget(
                                      color: Colors.deepPurple,
                                      width: 350,
                                      height: 500,
                                      isCornerRounded: true,
                                      padding: EdgeInsets.all(20),
                                      child: Stack(children: [
                                        Center(
                                          child: Column(
                                            children: [
                                              BarcodeWidget(
                                                data: text+"/"+eventId+"/"+userId,
                                                barcode: Barcode.qrCode(),
                                                color: Colors.white,
                                                height: 150,
                                                width: 150,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                eventModel.eventTitle??"no Data",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              ListTile(
                                                title: drawerCustomText(
                                                 '${eventModel.eventLocation?.street},'
                                                     '${eventModel.eventLocation
                                                     ?.governorate},${eventModel
                                                     .eventLocation?.country}',

                                               ), titleTextStyle: TextStyle(color: Colors.deepPurple,fontSize: 15),
                                                leading: const Icon(Icons.location_city_outlined,color: Colors.white,),
                                              ),
                                              SizedBox(height: 15,),

                                              ListTile(

                                                title: Text(
                                                  formatDateFromTimestamp(eventModel.date),
                                                  style: TextStyle(
                                                    color: Colors.white, // Specify the text color here
                                                  ),


                                                ),
                                                leading: const Icon(Icons.date_range,color: Colors.white,),
                                              ),
                                              SizedBox(height: 15,),

                                              SizedBox(height: 15,),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.monetization_on_sharp,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                  Text(
                                                    eventModel.ticketPrice.toString()??"",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                  )
                                                ],
                                              )
                                              // Add additional widgets as needed
                                            ],
                                          ),
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


  Widget drawerCustomText(String? data,
      {double? fontSize, FontWeight? fontWeight, FontStyle? fontStyle}) {
    return Text(
      data ?? '',
      style: const TextStyle(
        color: Colors.black87,
      ),
    );
  }
  String formatDateFromTimestamp(Timestamp? timestamp) {
    if (timestamp == null) {
      return '';
    } else {
      DateTime dateFromTimestamp =
      DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
      return DateFormat('EEE,dd-MMM-yyyy hh:mm a').format(dateFromTimestamp);
    }
  }

}
