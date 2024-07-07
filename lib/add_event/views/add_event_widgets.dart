

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

Widget drawerTextField(
    TextEditingController textEditingController,String label
    ,TextInputType textInputType
    ) {
  return  Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextField(
      controller: textEditingController,
      decoration:  InputDecoration(
        // hintText: label,
        labelText: label,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)
        ),
      ),
      keyboardType:textInputType,
    ),
  );

}

Widget drawerDateTimePicker(TextEditingController textEditingController ){
  DateTime nextYear = DateTime(DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);
  return  Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: DateTimePicker(
        type: DateTimePickerType.dateTime,
        dateMask: 'dd-MMM-yyyy    hh:mm a',
        controller: textEditingController,
        //initialValue: _initialValue,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        decoration:  const InputDecoration(
          hintText: 'Date Time',
          labelText: 'Date Time',
          prefixIcon: Icon(Icons.calendar_month_sharp),
          border: OutlineInputBorder(
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue)
          ),
        ),
        // use24HourFormat: false,
        onChanged:(val) {
          textEditingController.text=val;
          print('onChanged=$val');
        }
    ),
  );

  // return DateTimePicker(
  //    type: DateTimePickerType.dateTimeSeparate,
  //    dateMask: 'd MMM, yyyy',
  //    // initialValue: DateTime.now().toString(),
  //    firstDate: DateTime.now(),
  //    lastDate: nextYear,
  //    icon: Icon(Icons.calendar_month_outlined),
  //    dateLabelText: 'Date',
  //    timeLabelText: "Hour",
  //   decoration:  const InputDecoration(
  //     // hintText: label,
  //       labelText: 'Date',
  //       filled: true,
  //       prefixIcon: Icon(Icons.calendar_month_sharp),
  //       enabledBorder: OutlineInputBorder(
  //           borderSide: BorderSide.none
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: Colors.blue)
  //       )),
  //
  //    onChanged: (val) => print(val),
  //    // validator: (val) {
  //    //   print(val);
  //    //   return null;
  //    // },
  //    onSaved: (val) => print(val),
  //
  //  );
}