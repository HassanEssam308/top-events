import 'package:top_events/constants.dart';

import '../../add_event/models/event_model.dart';

class GetEventRepository {

  Future<List<EventModel>> getAllEvents() async {
    final snapshot = await fireStoreInstance.collection('events').get();
    final eventsData = snapshot.docs
        .map((element) => EventModel.fromFireStoreBySnapshot(element))
        .toList();

    return eventsData;
  }

  Future<List<EventModel>> getEventsByUserId(String userId) async {
    final snapshot = await fireStoreInstance
        .collection('events')
        .where("ownerId", isEqualTo: userId)
        .get();
    final eventData = snapshot.docs
        .map((element) => EventModel.fromFireStoreBySnapshot(element))
        .toList();
    return eventData;
  }


}
