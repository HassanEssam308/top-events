import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:top_events/add_event/controllers/add_event_controller.dart';

import '../add_event/models/event_model.dart';

class CustomDropdownButtonWidget extends StatelessWidget {
final  AddEventController addEventController ;
   const CustomDropdownButtonWidget({super.key , required this.addEventController});


  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<EventStatus>(
      value: addEventController.eventStatus,
      hint: Text('Select Event Status'),
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.grey[900] ,fontSize: 15,fontWeight: FontWeight.w400 ,letterSpacing: .7),
      decoration: const InputDecoration(
        labelText: 'Event Status',
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)),

      ),
      onChanged: (EventStatus? newValue) {
        addEventController.eventStatus=newValue??EventStatus.pending;

      },
      items: EventStatus.values.map<DropdownMenuItem<EventStatus>>((EventStatus value) {
        // print("***EventStatus ** value= ${value.toString()}");

        return DropdownMenuItem<EventStatus>(
          value: value,
          child: Text(value.toString().split('.').last),
        );
      }).toList(),
    );
  }
}
