import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_events/add_event/controllers/add_event_controller.dart';

import 'add_event_widgets.dart';
import 'location_screen.dart';

class AddEventScreen extends StatelessWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child:
    Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title: const Text('Add Event'),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<AddEventController>(
          init: AddEventController(),
          builder: ( addEventController) {
        return    SingleChildScrollView(
          child: Column(
                children: [
                  drawerTextField(
                      addEventController.ownerNameController, 'Owner Name',TextInputType.text),
                  drawerTextField(
                      addEventController.titleController, 'Event Title',TextInputType.text),
                  drawerTextField(
                      addEventController.descriptionController, 'Event Description',TextInputType.multiline),
                  drawerTextField(
                      addEventController.priceController, 'Ticket Price',TextInputType.number),
                  drawerLocationTextField(addEventController.locationController , context),
                  // drawerTextField(
                  //     addEventController.locationController, 'Event Location',TextInputType.streetAddress),

                  //Date picker
                  drawerDateTimePicker(addEventController.dateController)
                ],
              ),
        );
          },

        ),
      ),
      // bottomSheet:const LocationScreen() ,
    ),);
  }
  Widget drawerLocationTextField(
      TextEditingController textEditingController, BuildContext context) {

    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        onTap:()=>_openLocationInBottomSheet(context),
        controller: textEditingController,
        decoration:  const InputDecoration(
          labelText: 'location',
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue)
          ),
        ),
        readOnly: true,
        keyboardType:TextInputType.text,
      ),
    );

  }

  void _openLocationInBottomSheet(BuildContext context ) {
    showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        builder: (context)=>const LocationScreen(),
    );
  }

}
