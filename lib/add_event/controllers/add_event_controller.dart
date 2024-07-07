
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddEventController extends GetxController{
  TextEditingController ownerNameController =TextEditingController();
  TextEditingController titleController =TextEditingController();
  TextEditingController descriptionController =TextEditingController();
  TextEditingController priceController =TextEditingController();
  TextEditingController dateController =TextEditingController();
  TextEditingController locationController =TextEditingController();
  File? imageFile;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> _addDateTimeToFirestore(DateTime dateTime) async {
    final formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);

    // await FirebaseFirestore.instance.collection('yourCollectionName').add({
    //   'dateTime': dateTime,
    //   'formattedDate': formattedDate,
    // });
  }
  Future<String> formatDateFromTimestamp(Timestamp timestamp ) async {
    DateTime dateFromTimestamp=
    DateTime.fromMillisecondsSinceEpoch(timestamp.seconds *1000);
    return DateFormat('dd-MM-yyyy hh:mm a').format(dateFromTimestamp);
  }



}