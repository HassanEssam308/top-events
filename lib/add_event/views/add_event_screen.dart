
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_events/add_event/controllers/add_event_controller.dart';
import 'package:top_events/widgets/custom_dropdown_button_widget.dart';
import 'add_event_widgets.dart';

class AddEventScreen extends StatelessWidget {
  final String? eventId;
   const AddEventScreen({super.key,this.eventId});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(

          title:  Text(eventId==null?'Add Event':'Update Event',style: const TextStyle(color: Colors.white),),
          backgroundColor: Colors.deepPurple,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<AddEventController>(
            init: AddEventController(eventId: eventId),
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

                    ///DropdownButton to Event Status
                    eventId!=null?
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: CustomDropdownButtonWidget( addEventController: addEventController),
                        )
                   : const Text(''),

                    ///Date picker
                    drawerDateTimePicker(addEventController.dateController , addEventController ),
                    ///images
                    drawerImagesTextField(addEventController),
                    // eventId!=null?
                    // drawerButtonUpdateDataToFirebase(addEventController):
                    drawerButtonSaveDataToFirebase(addEventController ,context)

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



}
