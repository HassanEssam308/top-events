import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:top_events/add_event/models/event_model.dart';
import 'package:top_events/add_event/views/add_event_screen.dart';
import 'package:top_events/constants.dart';
import 'package:top_events/event_details/controllers/event_details_controller.dart';
import 'package:top_events/tickets_Genrate_QrCode/tickets_Genrate_QrCode.dart';

import '../../service/functions_service.dart';

class EventDetailsScreen extends StatelessWidget {
  final String eventId;

  EventDetailsScreen({required this.eventId, super.key});

  final EventDetailsController detailsController =
      Get.put(EventDetailsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text('Event Details',style: TextStyle(color: Colors.white)),
        ),
        floatingActionButton: drawerFloatingGetTicketAndEditeButton(
            context, eventId, detailsController),
        body: Column(
          children: [
            Expanded(child: drawerEventDetails(eventId, detailsController)

                ),
          ],
        ),
      ),
    );
  }

  Widget drawerFloatingGetTicketAndEditeButton(BuildContext context,
      String eventId, EventDetailsController detailsController) {
    return Obx(
      () => Row(
        mainAxisAlignment: detailsController.isAdmin.value == true
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2.6,
            height: 55,
            margin: const EdgeInsetsDirectional.only(start: 28),
            child: MaterialButton(
              elevation: 2,
              color: Colors.deepPurple,
              onPressed: () {
                Get.to(TicketsGenrateQrcode(eventid: eventId));
              },
              child: const Padding(
                padding: EdgeInsets.all(13.0),
                child: Text('Get Ticket'),
              ),
            ),
          ),
          // Edit Event
          detailsController.isAdmin.value == true
              ? SizedBox(
                  width: MediaQuery.of(context).size.width / 2.6,
                  height: 55,
                  child: MaterialButton(
                    elevation: 2,
                    color: Colors.yellow[700],
                    onPressed: () {
                      Get.to(() => AddEventScreen(eventId: eventId));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.edit),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 13.0),
                          child: Text(
                            'Edit Event',
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const Text(''),
        ],
      ),
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

////////////////////////////
  Widget drawerEventDetails(
      String documentId, EventDetailsController controller) {
    Stream<DocumentSnapshot> eventDetailsStream =
        fireStoreInstance.collection('events').doc(documentId).snapshots();

    return StreamBuilder<DocumentSnapshot>(
      stream: eventDetailsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.purpleAccent,
          ));
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text('Document does not exist');
        }
        var data = snapshot.data!;
        EventModel eventModel = EventModel.fromFireStoreBySnapshot(
            data as DocumentSnapshot<Map<String, dynamic>>);
        // return Text('Document data: ${data.toString()}');
        return SingleChildScrollView(
          child: Column(
            children: [


              /// Slider Images
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                      height: 250.0,
                    autoPlay: true,
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                      enlargeStrategy:CenterPageEnlargeStrategy.height,
                    enableInfiniteScroll: false
                  ),
                  itemCount: eventModel.images?.length ?? 0,
                  itemBuilder: (BuildContext context, int index, int realIndex) {
                    String urlImage= (eventModel.images!=null)? eventModel.images![index]:'';
                    return urlImage!=''? drawerImageInSlider(urlImage,context):const Text('No Image');
                  },
                ),
              ),

              ///title
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 2, top: 15),
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

              /// Organizer
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
                    FunctionsService.formatDateFromTimestamp(eventModel.date),
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
                        '${eventModel.eventLocation?.governorate},${eventModel.eventLocation?.country}',
                      ),
                      // Open Map
                      (eventModel.eventLocation?.latLng != null)
                          ? TextButton(
                              iconAlignment: IconAlignment.start,
                              onPressed: () {
                                controller.goToMap(LatLng(
                                    eventModel.eventLocation!.latLng!.latitude,
                                    eventModel
                                        .eventLocation!.latLng!.longitude));
                              },
                              child: const Text(
                                'Open Map \u{2192}',
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          : const Text('')
                    ],
                  ),
                  leading: const Icon(Icons.location_city_outlined),
                ),
              ),
              // About this event
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 5, end: 5, top: 5, bottom: 80),
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
      },
    );
  }

  Widget drawerImageInSlider(String urlImg , BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(horizontal: 24),
      color: Colors.grey,

      child: Image.network(
        urlImg,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
