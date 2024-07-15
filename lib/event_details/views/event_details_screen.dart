import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:top_events/add_event/models/event_model.dart';
import 'package:top_events/event_details/controllers/event_details_controller.dart';

import '../../tickets_Genrate_QrCode/tickets_Genrate_QrCode.dart';

class EventDetailsScreen extends StatelessWidget {
  final String eventId;

  const EventDetailsScreen({required this.eventId, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Event Details'),
        ),
        floatingActionButton: Align(
            alignment: Alignment.bottomCenter,
            child: drawerFloatingGetTicketButton(context)),
        body: Column(
          children: [
            Expanded(
              child: GetBuilder<EventDetailsController>(
                init: EventDetailsController(eventId: eventId),
                builder: (controller) {
                  if (controller.eventModel.value == null) {
                    return Center(
                        heightFactor: MediaQuery
                            .of(context)
                            .size
                            .height,
                        child: const CircularProgressIndicator());

                  } else {
                    EventModel eventModel = controller.eventModel.value!;
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsetsDirectional.only(top: 20),
                            height: 220,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: eventModel.images!
                                  .map(
                                    (img) =>
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Image.network(
                                        img,
                                        fit: BoxFit.cover,
                                        width: 200,
                                        height: 200,
                                      ),
                                    ),
                              )
                                  .toList(),
                            ),
                          ),
                          //title
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 2, top: 5),
                            child: Text(
                              eventModel.eventTitle ?? "",
                              textAlign: TextAlign.center,
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Organizer
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: ListTile(
                              title: textHeading('Organizer '),
                              subtitle: drawerCustomText(
                                eventModel.ownerName ?? "",
                              ),
                            ),
                          ),
                          // Ticket price
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: ListTile(
                              title: textHeading('Ticket price '),
                              subtitle: drawerCustomText(
                                '${eventModel.ticketPrice}\$',
                              ),
                              leading: const Icon(Icons.price_change_outlined),
                            ),
                          ),
                          // date
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: ListTile(
                              title: textHeading('Date and Time '),
                              subtitle: drawerCustomText(
                                formatDateFromTimestamp(eventModel.date),
                              ),
                              leading: const Icon(Icons.date_range),
                            ),
                          ),
                          // Location
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: ListTile(
                              title: textHeading('Location'),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  drawerCustomText(
                                    '${eventModel.eventLocation?.street},'
                                        '${eventModel.eventLocation
                                        ?.governorate},${eventModel
                                        .eventLocation?.country}',
                                  ),
                                  // Open Map
                                  (eventModel.eventLocation?.latLng != null)
                                      ? TextButton(
                                    iconAlignment: IconAlignment.start,
                                    onPressed: () {
                                      controller.goToMap(LatLng(
                                          eventModel.eventLocation!.latLng!
                                              .latitude,
                                          eventModel.eventLocation!.latLng!
                                              .longitude));
                                    },
                                    child: const Text('Open Map \u{2192}',
                                      style: TextStyle(color: Colors.blue),),)
                                      : const Text('')
                                ],
                              ),
                              leading: const Icon(Icons.location_city_outlined),
                            ),
                          ),
                          // About this event
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: ListTile(
                              title: textHeading('About this event '),
                              subtitle: drawerCustomText(
                                eventModel.description ?? '',
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget drawerGetTicketButton(BuildContext context) {
  //   return Container(
  //     color: Colors.transparent,
  //     margin:
  //     const EdgeInsetsDirectional.symmetric(horizontal: 40, vertical: 20),
  //     width: MediaQuery
  //         .of(context)
  //         .size
  //         .width / 2,
  //     child: MaterialButton(
  //       elevation: 5,
  //       color: Colors.purpleAccent[100],
  //       onPressed: () {
  //
  //       },
  //       child: const Padding(
  //         padding: EdgeInsets.all(15.0),
  //         child: Text(
  //           'Get Ticket',
  //           textAlign: TextAlign.center,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget drawerFloatingGetTicketButton(BuildContext context) {
    return FloatingActionButton.extended(
      tooltip: "Get Ticket",
      backgroundColor: Colors.purpleAccent[100],
      foregroundColor: Colors.white,
      elevation: 5,
      // shape: ,
      splashColor: Colors.black,
      onPressed: () {
        Get.toNamed('/createTicket');

      },
      label: SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width / 2.5,
          child: const Text(
            'Get Ticket',
            textAlign: TextAlign.center,
          )),
    );
  }

  Widget textHeading(String? text) {
    return Text(
      text ?? '',
      softWrap: false,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
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
