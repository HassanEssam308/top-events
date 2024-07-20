import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_events/service/functions_service.dart';
import 'package:top_events/widgets/custom_text_widget.dart';

import '../add_event/models/event_model.dart';
import '../event_details/views/event_details_screen.dart';

class CardsEventsWidget extends StatelessWidget {
  final Stream<QuerySnapshot> eventStream;

  final bool isDisplayStatus;

  const CardsEventsWidget(
      {required this.eventStream, this.isDisplayStatus = false, super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: eventStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          Get.snackbar('Error', snapshot.error.toString());
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.purpleAccent,
            ),
          );
        }

        if (snapshot.data!.docs.isNotEmpty) {
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
                      Get.to(() => EventDetailsScreen(eventId: document.id));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: eventModel.images!.isNotEmpty
                              ? Image.network(
                                  eventModel.images![0],
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: double.infinity,
                                )
                              : const Center(
                                  child: Text(
                                  "No Image",
                                )),
                        ),

                        // title
                        Padding(
                          padding: const EdgeInsets.all(7.5),
                          child: CustomTextWidget(eventModel.eventTitle,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                        //date
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                          ),
                          child: CustomTextWidget(
                            FunctionsService.formatDateFromTimestamp(
                                eventModel.date),
                            fontSize: 16.0,
                          ),
                        ),
                        //price
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 17),
                                child: CustomTextWidget(
                                  'Price : ${eventModel.ticketPrice.toString()}\$',
                                  fontSize: 16.0,
                                ),
                              ),
                              isDisplayStatus == true
                                  ? Material(
                                elevation: 1.5,
                                color: Colors.grey[300],
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    eventModel.status.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: (eventModel.status ==
                                            EventStatus.accepted)
                                            ? Colors.green
                                            : (eventModel.status ==
                                            EventStatus.pending)
                                            ? Colors.grey
                                            : Colors.red),
                                  ),
                                ),
                              )
                                  : const Text(''),
                            ],
                          ),
                        ),
                        //State,

                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "You have not posted any event",
              style: TextStyle(fontSize: 18),
            ),
            Image.asset('assets/images/no_data_found.png'),
          ],
        );
      },
    );
  }
}
