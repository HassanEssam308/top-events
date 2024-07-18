import 'package:flutter/material.dart';
import 'package:top_events/constants.dart';
import 'package:top_events/widgets/cards_events_widget.dart';

class MyPostedEventsScreen extends StatelessWidget {
  const MyPostedEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Posted Events"),
        ),
        body: Padding(
          padding: const EdgeInsetsDirectional.symmetric (vertical:  8.0),
          child: CardsEventsWidget(
              eventStream: fireStoreInstance
                  .collection('events')
                  .where('ownerId', isEqualTo: box.read('uid'))
                  .where('status', isEqualTo: 'accepted')
                  .orderBy('date')
                  .snapshots(),isDisplayStatus: true,),
        ),
      ),
    );
  }
}
