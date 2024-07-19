import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../add_event/models/event_model.dart';
import '../event_details/event_details_repository.dart';

class AllTicketsController extends GetxController{
  Rx<EventModel?> eventModel = Rx(null);


}