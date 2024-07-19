import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? id;
  String? ownerId;
  String? ownerName;
  String? eventTitle;
  String? description;
  int? ticketPrice;
  List<String>? images;
  EventStatus status;
  Timestamp? date;
  EventLocation? eventLocation;
  List<String?>? subscribers;

  EventModel({
    this.id,
    required this.ownerId,
    required this.ownerName,
    required this.eventTitle,
    required this.description,
    required this.ticketPrice,
    required this.images,
    required this.status,
    required this.date,
    required this.eventLocation,
    required this.subscribers,
  });

  factory EventModel.fromFireStoreBySnapshot(
      DocumentSnapshot<Map<String, dynamic>> docSnap) {
    final data = docSnap.data()!;
    return EventModel(
      id: docSnap.id,
      ownerId: data["ownerId"] ?? '',
      ownerName: data["ownerName"] ?? '',
      eventTitle: data["eventTitle"] ?? '',
      description: data["description"] ?? '',
      ticketPrice: data["ticketPrice"] ?? '',
      images: data["images"] is Iterable ? List.from(data['images']) : null,
      status: eventStatusValues.map[data["status"] ?? 'accepted']!,
      date: data["date"] ?? '',
      eventLocation: EventLocation.fromMap(data["eventLocation"] ?? ''),
      subscribers: List<String>.from(data["subscribers"] ?? []),
    );
  }
  static Stream<EventModel> fromFireStoreByStream(
      Stream<DocumentSnapshot<Map<String, dynamic>>> docSnapStream) {
    return docSnapStream.map((docSnap) {
      final data = docSnap.data()!;
      return EventModel(
        id: docSnap.id,
        ownerId: data["ownerId"] ?? '',
        ownerName: data["ownerName"] ?? '',
        eventTitle: data["eventTitle"] ?? '',
        description: data["description"] ?? '',
        ticketPrice: data["ticketPrice"] ?? '',
        images: data["images"] is Iterable ? List.from(data['images']) : null,
        status: eventStatusValues.map[data["status"] ?? 'accepted']!,
        date: data["date"] ?? '',
        eventLocation: EventLocation.fromMap(data["eventLocation"] ?? {}),
        subscribers: List<String>.from(data["subscribers"] ?? []),
      );
    });
  }

  Map<String, dynamic> toFireStoreJson() => {
        "ownerName": ownerName,
        "ownerId": ownerId,
        "eventTitle": eventTitle,
        "description": description,
        "ticketPrice": ticketPrice,
        "images": images,
        "status": eventStatusValues.reverse[status],
        "date": date,
        "eventLocation": eventLocation?.toJson(),
        "subscribers": subscribers,
      };
}

enum EventStatus { accepted, pending, rejected }

final eventStatusValues = EnumValues({
  "accepted": EventStatus.accepted,
  "pending": EventStatus.pending,
  "rejected": EventStatus.rejected,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

class EventLocation {
  String? street;
  String? governorate;
  String? country;
  GeoPoint? latLng;

  EventLocation({
    required this.street,
    required this.governorate,
    required this.country,
    required this.latLng,
  });

  factory EventLocation.fromMap(Map<String, dynamic>? data) {
    return EventLocation(
        country: data?["country"],
        governorate: data?["governorate"],
        street: data?["street"],
        latLng: data?['latLng']);
  }

  Map<String, dynamic> toJson() => {
        "country": country,
        "governorate": governorate,
        "street": street,
        "latLng": latLng,
      };
}