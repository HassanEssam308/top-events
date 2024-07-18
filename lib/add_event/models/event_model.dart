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
//////////////////////////////////////////////////////////////////////////////////////////////////////
//  class Xxx {
//    // To parse this JSON data, do
// //
// //     final eventModel = eventModelFromJson(jsonString);
//
//
//
//    List<EventModel> eventModelFromJson(String str) => List<EventModel>.from(json.decode(str).map((x) => EventModel.fromJson(x)));
//
//    String eventModelToJson(List<EventModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
//    class EventModel {
//    Date date;
//    List<Image> images;
//    String ownerName;
//    int ticketPrice;
//    EventLocation eventLocation;
//    String description;
//    String ownerId;
//    String title;
//    String status;
//
//    EventModel({
//    required this.date,
//    required this.images,
//    required this.ownerName,
//    required this.ticketPrice,
//    required this.eventLocation,
//    required this.description,
//    required this.ownerId,
//    required this.title,
//    required this.status,
//    });
//
//    factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
//    date: Date.fromJson(json["date"]),
//    images: List<Image>.from(json["images"].map((x) => imageValues.map[x]!)),
//    ownerName: json["ownerName"],
//    ticketPrice: json["ticketPrice"],
//    eventLocation: EventLocation.fromJson(json["eventLocation"]),
//    description: json["description"],
//    ownerId: json["ownerId"],
//    title: json["title"],
//    status: json["status"],
//    );
//
//    Map<String, dynamic> toJson() => {
//    "date": date.toJson(),
//    "images": List<dynamic>.from(images.map((x) => imageValues.reverse[x])),
//    "ownerName": ownerName,
//    "ticketPrice": ticketPrice,
//    "eventLocation": eventLocation.toJson(),
//    "description": description,
//    "ownerId": ownerId,
//    "title": title,
//    "status": status,
//    };
//    }
//
//    class Date {
//    int seconds;
//    int nanoseconds;
//
//    Date({
//    required this.seconds,
//    required this.nanoseconds,
//    });
//
//    factory Date.fromJson(Map<String, dynamic> json) => Date(
//    seconds: json["seconds"],
//    nanoseconds: json["nanoseconds"],
//    );
//
//    Map<String, dynamic> toJson() => {
//    "seconds": seconds,
//    "nanoseconds": nanoseconds,
//    };
//    }
//
//    class EventLocation {
//    String country;
//    String governorate;
//    String street;
//    List<double> latLng;
//
//    EventLocation({
//    required this.country,
//    required this.governorate,
//    required this.street,
//    required this.latLng,
//    });
//
//    factory EventLocation.fromJson(Map<String, dynamic> json) => EventLocation(
//    country: json["country"],
//    governorate: json["governorate"],
//    street: json["street"],
//    latLng: List<double>.from(json["latLng"].map((x) => x?.toDouble())),
//    );
//
//    Map<String, dynamic> toJson() => {
//    "country": country,
//    "governorate": governorate,
//    "street": street,
//    "latLng": List<dynamic>.from(latLng.map((x) => x)),
//    };
//    }
//
//    enum Image {
//    FFFFFFFFF,
//    HHHHHHHH
//    }
//
//    final imageValues = EnumValues({
//    "fffffffff": Image.FFFFFFFFF,
//    "hhhhhhhh": Image.HHHHHHHH
//    });
//
//    class EnumValues<T> {
//    Map<String, T> map;
//    late Map<T, String> reverseMap;
//
//    EnumValues(this.map);
//
//    Map<T, String> get reverse {
//    reverseMap = map.map((k, v) => MapEntry(v, k));
//    return reverseMap;
//    }
//    }
//
//  }
