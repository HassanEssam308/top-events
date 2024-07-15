
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_events/add_event/controllers/add_event_controller.dart';
import 'add_event_widgets.dart';

class AddEventScreen extends StatelessWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Add Event'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<AddEventController>(
            init: AddEventController(),
            builder: (addEventController) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    drawerTextField(addEventController.ownerNameController,
                        'Owner Name', TextInputType.text),
                    drawerTextField(addEventController.titleController,
                        'Event Title', TextInputType.text),
                    drawerTextField(addEventController.descriptionController,
                        'Event Description', TextInputType.multiline ,maxLines:5 ,minLines: 3),
                    drawerTextField(addEventController.priceController,
                        'Ticket Price', TextInputType.number),
                    drawerLocationTextField(
                        addEventController.locationController,
                        addEventController),

                    //Date picker
                    drawerDateTimePicker(addEventController.dateController , addEventController ),
                    //images
                    drawerImagesTextField(addEventController),
                    drawerButtonSaveDataToFirebase(addEventController),
                  ],
                ),
              );
            },
          ),
        ),
        // bottomSheet:const LocationScreen() ,
      ),
    );
  }



  // void _openLocationInBottomSheet(BuildContext context ) {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //       context: context,
  //       builder: (context)=> LocationScreen(),
  //   );
  // }

}
