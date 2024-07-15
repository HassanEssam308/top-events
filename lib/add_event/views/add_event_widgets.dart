import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_events/add_event/controllers/add_event_controller.dart';

import 'location_screen.dart';

Widget drawerTextField(TextEditingController textEditingController,
    String label, TextInputType textInputType ,
    {int maxLines = 1, int minLines = 1}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextField(
      controller: textEditingController,
      maxLines:maxLines,
      minLines: minLines,
      decoration: InputDecoration(
        // hintText: label,
        labelText: label,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)),
      ),
      keyboardType: textInputType,
    ),
  );
}

Widget drawerDateTimePicker(TextEditingController textEditingController,
    AddEventController addEventController) {
  DateTime nextYear = DateTime(
      DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: DateTimePicker(
        type: DateTimePickerType.dateTime,
        dateMask: 'EEEE-dd-MMM-yyyy    hh:mm a',
        controller: textEditingController,
        //initialValue: _initialValue,
        firstDate: DateTime.now(),
        lastDate: nextYear,
        decoration: const InputDecoration(
          hintText: 'Date Time',
          labelText: 'Date Time',
          prefixIcon: Icon(Icons.calendar_month_sharp),
          border: OutlineInputBorder(),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
        ),
        // use24HourFormat: false,
        onChanged: (val) {
          textEditingController.text = val;
          addEventController.eventDate = DateTime.parse(val);
        }),
  );
}

Widget drawerImagesTextField(AddEventController addEventController) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Images:"),
            IconButton(
              onPressed: () {
                addEventController.getImagePicker();
              },
              icon: const Icon(
                Icons.add_photo_alternate_outlined,
                color: Colors.greenAccent,
              ),
              tooltip: 'Add Event image',
            )
          ],
        ),
        //ListImages
        if (addEventController.imagesFile.isNotEmpty)
          SizedBox(
            width: double.infinity,
            height: 150,
            child: ListView.builder(
              itemCount: addEventController.imagesFile.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.file(File(
                      addEventController.imagesFile[index]!.path,
                    )),
                  ),
                  Positioned(
                    top: 2,
                    right: 3,
                    child: InkWell(
                        onTap: () {
                          addEventController.removeImageByIndex(index);
                        },
                        child: const Icon(
                          Icons.cancel_presentation_sharp,
                          size: 28,
                          color: Colors.redAccent,
                        )),
                  )
                ]);
              },
              scrollDirection: Axis.horizontal,
            ),
          )
      ],
    ),
  );
}

  Widget drawerButtonSaveDataToFirebase(AddEventController addEventController) {
  return Container(
    padding: const EdgeInsets.all(20),

    child: ElevatedButton(
      onPressed: () async {
       if (addEventController.checkInputs()){

        await addEventController.uploadImagesToFireStorage();
          addEventController.insertEventToFireStore();
         addEventController.clearInputs();
       }
      },
      child: const Text('Publish Event'),
    ),
  );

}

Widget drawerLocationTextField(TextEditingController textEditingController,
    AddEventController addEventController) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        labelText: 'location',
        suffixIcon: IconButton(
            color: Colors.grey[300],
            onPressed: () => Get.to(LocationScreen(
              addEventController: addEventController,
            )),
            icon: addEventController.iconOfLocation()),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)),
      ),
      keyboardType: TextInputType.text,
    ),
  );
}