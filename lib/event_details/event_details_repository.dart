import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../add_event/models/event_model.dart';
import '../constants.dart';

class EventDetailsRepository {

  Future<EventModel?> getEventByEventId(String eventId) async {
    EventModel? eventModel;
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await fireStoreInstance.collection('events').doc(eventId).get();
       print('getEventByEventId: ${snapshot.data()}');
      eventModel = EventModel.fromFireStoreBySnapshot(snapshot);
      return eventModel;
    } catch (err) {
      Get.snackbar("getEventByEventId", err.toString());
       print('getEventByEventId :$err');
    }

    return eventModel;
  }


  static  Stream<EventModel> getEventByEventIdStream(String eventId) {
    var snapshots =
        fireStoreInstance.collection('events').doc(eventId).snapshots();
    final eventModel = EventModel.fromFireStoreByStream(
        snapshots );
    // print('getEventByEventIdStream$eventModel');
    return eventModel;
  }

}
