import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_events/widgets/cards_events_widget.dart';
import 'package:top_events/widgets/custom_outline_button.dart';

import '../../constants.dart';
import '../controllers/all_events_controller.dart';

class AllEventsScreen extends StatelessWidget {
  AllEventsScreen({super.key});

  final AllEventsController allEventsController =
      Get.put(AllEventsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('All Events'),
      ),
      floatingActionButton: drawerCreateEventFloatingActionButton(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:allEventsController.isAdmin.value==true? Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomOutlineButton(
                      text: "accepted", allEventsController: allEventsController),
                ),
                Expanded(
                  flex: 1,
                  child: CustomOutlineButton(
                      text: "pending", allEventsController: allEventsController),
                ),
                Expanded(
                  flex: 1,
                  child: CustomOutlineButton(
                      text: "rejected", allEventsController: allEventsController),
                ),
              ],
            ):Container(),
          ),
          Expanded(
            child: Obx(
                ()=> CardsEventsWidget(
                  eventStream: fireStoreInstance
                      .collection('events')
                      .where('status', isEqualTo: allEventsController.viewState.value)
                      .orderBy('date')
                      .snapshots(),isDisplayStatus: false,),
            ),
          ),
        ],
      ),
    ));
  }


  Widget drawerCreateEventFloatingActionButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0, right: 8),
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

}
