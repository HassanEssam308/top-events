import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? ownerId;
  String? ownerName;
  String? title;
  String? description;
  int? priceOfTicket;
  List<String>? images;
  String? status;
  Timestamp? date;
  GeoPoint? location;

  EventModel({
  required this.ownerId,
  required this.ownerName,
  required this.title,
  required this.description,
  required this.priceOfTicket,
  required this.images,
  required this.status,
  required this.date,
  required this.location,
});



}
