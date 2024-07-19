import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:top_events/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsController extends GetxController {

  Rx<bool>  isAdmin=Rx(false);

  @override
  onReady(){
    super.onReady();
    isAdmin.value=(box.read("isAdmin"))??false;
  }

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
