import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:top_events/add_event/models/event_model.dart';
import 'package:top_events/event_details/event_details_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsController extends GetxController {
  // final String eventId;
  //
  // EventDetailsController({required this.eventId});
  //
  // Rx<EventModel?> eventModel = Rx(null);
  //
  // @override
  // void onReady() {
  //   loadEvent();
  //   super.onReady();
  // }
  //
  // void loadEvent() async {
  //   eventModel.value =
  //       await EventDetailsRepository().getEventByEventId(eventId);
  //   update();
  // }


  goToMap(LatLng latLng) async {
    print("${latLng.latitude},${latLng.longitude}");
    String mapUrl =
        "https://www.google.com/maps/search/?api=1&query=${latLng.latitude},${latLng.longitude}";

    final Uri parseUrl = Uri.parse(mapUrl);
    if (!await launchUrl(parseUrl)) {
      throw Exception('**********Could not launch $mapUrl');
    }
  }
}
