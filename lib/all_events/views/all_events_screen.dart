import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:top_events/add_event/models/event_model.dart';
import 'package:top_events/event_details/views/event_details_screen.dart';

import '../../constants.dart';

class AllEventsScreen extends StatelessWidget {
  const AllEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('All Events'),
      ),
      floatingActionButton: drawerFloatingActionButton(),
      body: Column(
        children: [


          Expanded(
            child: drawerCardOfEvents(),
          ),
        ],
      ),
    ));
  }

  Widget drawerCardOfEvents() {
    final Stream<QuerySnapshot> eventsStream = fireStoreInstance
        .collection('events')
        .orderBy('date', descending: true)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: eventsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          Get.snackbar('Error', snapshot.error.toString());
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.purpleAccent,),
          );
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            // Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            EventModel eventModel = EventModel.fromFireStoreBySnapshot(
                document as DocumentSnapshot<Map<String, dynamic>>);

            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 1.5),
              child: Card(
                elevation: 20,
                shadowColor: Colors.purple,
                shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.zero),
                child: InkWell(
                  onTap: () {
                    Get.to(()=>EventDetailsScreen(eventId: document.id));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //   width: double.infinity,
                      //   height: 200,
                      //   child: Image.network(
                      //     eventModel.images == null ? '' : eventModel.images![0],
                      //     fit: BoxFit.cover,
                      //     width: double.infinity,
                      //     height: double.infinity,),
                      // ),

                      // title
                      Padding(
                        padding: const EdgeInsets.all(7.5),
                        child: drawerCustomText(
                          eventModel.eventTitle,
                            fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic
                        ),
                      ),
                      //date
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,),
                        child: drawerCustomText(
                            formatDateFromTimestamp(eventModel.date),
                            fontSize: 16.0,
                        ),
                      ),
                      //price
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,  bottom: 17),
                        child: drawerCustomText(
                         'Price : ${eventModel.ticketPrice.toString()}\$',
                            fontSize: 16.0,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget drawerFloatingActionButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0,right: 8),
      child: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed('/addEvent');
        },
        tooltip: 'Create Event',
        label: const Text('Create Event'),
        splashColor: Colors.black,
        backgroundColor: Colors.purpleAccent[100],
        foregroundColor: Colors.white,
        elevation: 5,
      ),
    );
  }

  Widget drawerCustomText( String? data,
      {double? fontSize,
       FontWeight? fontWeight,
       FontStyle? fontStyle}
      ) {
    return Text(
      data ?? '',
      maxLines: 1,
      style:  TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle:fontStyle,
          color: Colors.black,
          overflow: TextOverflow.ellipsis,
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
