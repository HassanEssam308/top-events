import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_events/add_event/models/event_model.dart';
import 'package:top_events/constants.dart';
import 'package:top_events/service/functions_service.dart';

class AddEventController extends GetxController {
  final String? eventId;

  AddEventController({required this.eventId});

  TextEditingController ownerNameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  GoogleMapController? googleMapController;
  TextEditingController cityController = TextEditingController();
  DateTime? eventDate;
  Rx<MapType> currentMapType = Rx(MapType.normal);
  List<File?> imagesFile = [];
  List<String> imagesUrlList =[];
  List<String>  removeImagesUrlList =[];
  LatLng? currentLatLng;
  EventStatus  eventStatus= EventStatus.pending ;
  late Set<Marker> markers;
  // RxList<Widget> allImages = RxList([]);

  @override
  void onInit() {
    if (currentLatLng == null) {
      markers = {
        Marker(
            markerId: const MarkerId("1"),
            position: const LatLng(27.179617306030632, 31.186620725534446),
            draggable: true,
            onDragEnd: (LatLng value) {
              // print('addMarker***onDragEnd**********$value');
              addMarker(value);
              setLocationToTextField(value);
              setSelectedLatLng(value);
              // print('addMarker***$currentLatLng**********$value');
            })
      }.obs;
    } else {
      addMarker(currentLatLng!);
    }

    super.onInit();
  }

  @override
  void onReady() {
    if (eventId != null) getEventById();
    super.onReady();
  }

  getEventById() {
    fireStoreInstance.collection('events').doc(eventId).get().then((value) {

      EventModel event = EventModel.fromFireStoreBySnapshot(value);


      setEventInInput(event);
    }).catchError((err) {
      Get.snackbar('Error getEventById', err.masege);
      if (kDebugMode) {
        print('*****getEventById**err=$err');
      }
    });
  }

  setEventInInput(EventModel event) {
    ownerNameController.text = event.ownerName ?? '';
    titleController.text = event.eventTitle ?? '';
    descriptionController.text = event.description ?? "";
    priceController.text = event.ticketPrice.toString() ?? '';
    if (event.eventLocation != null) setLocationToInput(event.eventLocation!);

    dateController.text = FunctionsService.formatDateToInitialValueString(event.date);
    eventDate =  DateTime.fromMillisecondsSinceEpoch(event.date!.seconds * 1000);
    imagesUrlList =List.from(event.images!) ;
    eventStatus =event.status;
  }

  setLocationToInput(EventLocation eventLocation) {
    locationController.text = '${eventLocation.street},'
        '${eventLocation.governorate},${eventLocation.country}';
    googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(
              eventLocation.latLng!.latitude, eventLocation.latLng!.longitude),
          zoom: 12),
    ));
    addMarker(LatLng(
        eventLocation.latLng!.latitude, eventLocation.latLng!.longitude));
    setSelectedLatLng(LatLng(
        eventLocation.latLng!.latitude, eventLocation.latLng!.longitude));
  }

  Future<void> searchCity() async {
    if (cityController.text.isNotEmpty) {
      try {
        List<Location> locations =
            await locationFromAddress(cityController.text);
        if (locations.isNotEmpty) {
          Location location = locations.first;
          googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(location.latitude, location.longitude),
                zoom: 12),
          ));

          addMarker(LatLng(location.latitude, location.longitude));
          setSelectedLatLng(LatLng(location.latitude, location.longitude));
          cityController.text = locationController.text = await getNameOfArea(
                  LatLng(location.latitude, location.longitude)) ??
              cityController.text;
        }
      } catch (e) {
        Get.snackbar('Invalid City Name', e.toString());
        // print('Error_searchCity: $e');
      }
    }
  }

  addMarker(LatLng latLng) {
    markers.clear();
    markers = {
      Marker(
          markerId: const MarkerId("1"),
          position: LatLng(latLng.latitude, latLng.longitude),
          draggable: true,
          onDragEnd: (LatLng value) {
            addMarker(value);
            setLocationToTextField(value);
            setSelectedLatLng(value);
            // print('addMarker***currentLatLng***$currentLatLng*******$value');
          })
    }.obs;
  }

  Future<void> setLocationToTextField(LatLng latLng) async {
    try {
      cityController.text =
          locationController.text = await getNameOfArea(latLng) ?? "";
    } catch (err) {
      Get.snackbar('Invalid City Name', err.toString());
      // print('Error_setLocationToTextField: $err');
    }
  }

  Future<String?> getNameOfArea(LatLng latLng) async {
    try {
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      return '${placeMarks[0].name} ${placeMarks[0].locality},${placeMarks[0].administrativeArea},${placeMarks[0].country}';
    } catch (err) {
      Get.snackbar('Invalid City Name', err.toString());
      if (kDebugMode) {
        print('Error_getNameOfArea: $err');
      }
      return null;
    }
  }

  setSelectedLatLng(LatLng latLng) {
    currentLatLng = LatLng(latLng.latitude, latLng.longitude);
    update();
  }

  removeLocation() {
    currentLatLng = const LatLng(27.179617306030632, 31.186620725534446);
    locationController.clear();
    cityController.clear();
    update();
  }

  Widget iconOfLocation() {
    return currentLatLng == null
        ? const Icon(
            Icons.location_off_outlined,
            color: Colors.grey,
          )
        : const Icon(
            Icons.location_on_outlined,
            color: Colors.redAccent,
          );
  }

  Future<void> getImagePicker() async {
    // print('************* getImagePicker=${imagesFile.length}**************');
    ImagePicker imagePicker = ImagePicker();
    try {
      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        imagesFile.add(File(file.path));
      }
    } catch (err) {
      Get.snackbar('Upload Image ', err.toString());
      if (kDebugMode) {
        print('Error_getImagePicker: $err');
      }
    }
    update();
  }

  void removeImageByIndex(int index) {
    imagesFile.removeAt(index);
    update();
  }

  void removeImageUrlByIndex(int index) {
    imagesUrlList.removeAt(index);
    update();
  }

  Future<void> insertEventToFireStore() async {
    List allLocation = locationController.text.split(',');
    String userId = box.read('uid');
    // print('*********userId=$userId');
    final event = EventModel(
      ownerId: userId,
      ownerName: ownerNameController.text,
      eventTitle: titleController.text,
      description: descriptionController.text,
      ticketPrice: int.parse(priceController.text),
      images: imagesUrlList,
      status:eventStatus,
      date: convertDateToTimestamp(),
      eventLocation: EventLocation(
          street: allLocation[0],
          governorate: allLocation[allLocation.length - 2],
          country: allLocation.last,
          latLng: GeoPoint(currentLatLng!.latitude, currentLatLng!.longitude)),
      subscribers: [],
    ).toFireStoreJson();

    //add
    if (eventId == null) {
    await  fireStoreInstance.collection('events').add(event).then((value) {
        Get.snackbar('published Successfully', '');
      }).catchError((error) {
        if (error is FirebaseException) {
          if (kDebugMode) {
            print("Creation Error=>FirebaseException: ${error.code}");
          }
          Get.snackbar('Creation Error', '${error.message}');
        } else {
          Get.snackbar('Creation Error', error.toString());
          if (kDebugMode) {
            print("Error writing document: $error");
          }
        }
      });
    } else {
      //update
    await  fireStoreInstance
          .collection('events')
          .doc(eventId)
          .update(event)
          .then((onValue) {
        Get.snackbar('Event updated  Successfully', '');
      }).catchError((error) {
        if (error is FirebaseException) {
          if (kDebugMode) {
            print("Creation Error=>FirebaseException: ${error.code}");
          }
          Get.snackbar('Creation Error', '${error.message}');
        } else {
          Get.snackbar('Creation Error', error.toString());
          if (kDebugMode) {
            print("Error writing document: $error");
          }
        }
      });
    }
    _deleteImageFromFireStorage(removeImagesUrlList);
  }

  Future<void> _deleteImageFromFireStorage( List<String> imagesUrl) async {
    for(int i =0; i<imagesUrl.length;i++){

    try {
      await storageInstance.refFromURL(imagesUrl[i]).delete().then((value) {
        // Get.snackbar("image deleted", '');
      });
    } catch (err) {
      if (kDebugMode) {
        print('*******deleteImageFromFireStorage=$err');
      }
    }
    }
  }

  Future<void> uploadImagesToFireStorage() async {
    // List<String> urls=[];

    if (imagesFile.isNotEmpty) {
      for (int i = 0; i < imagesFile.length; i++) {
        String imagePath =
            "${box.read('uid')}/eventImages/${titleController.text}/${imagesFile[i]!.path.split('/').last}";
        try {
          await storageInstance
              .ref()
              .child(imagePath)
              .putFile(imagesFile[i]!)
              .then((TaskSnapshot taskSnapshot) async {
            String downloadImageUrl = await taskSnapshot.ref.getDownloadURL();
            imagesUrlList.add(downloadImageUrl);
          }).catchError((error) {
            if (error is FirebaseException) {
              if (kDebugMode) {
                print("uploadImage=>FirebaseException: ${error.code}");
              }
              Get.snackbar('uploadImage', '${error.message}');
            } else {
              Get.snackbar('upload Image', '${error.message}');
              // print("Error writing document: $error");
            }
            if (kDebugMode) {
              print("_uploadImageToFireStorage:catchError: $error");
            }
          });
        } catch (err) {
          if (kDebugMode) {
            print("_uploadImageToFireStorage:catch :$err");
          }
        }
      }
    }
  }

  bool checkInputs() {
    if (ownerNameController.text.isEmpty) {
      Get.snackbar("Please Enter Name Of Event Owner", '');
      return false;
    } else if (titleController.text.isEmpty) {
      Get.snackbar("Please Enter Title Of Event", '');
      return false;
    } else if (descriptionController.text.isEmpty) {
      Get.snackbar("Please Enter Description Of Event ", '');
      return false;
    } else if (priceController.text.isEmpty) {
      Get.snackbar("Please Enter Ticket price Of Event", '');
      return false;
    } else if (dateController.text.isEmpty) {
      Get.snackbar("Please Enter Date Of Event", '');
      return false;
    } else if (locationController.text.isEmpty) {
      Get.snackbar("Please Enter Location Of Event", '');
      return false;
    } else {
      return true;
    }
  }

  clearInputs() {
    ownerNameController.clear();
    titleController.clear();
    descriptionController.clear();
    priceController.clear();
    priceController.clear();
    dateController.clear();
    dateController.text = '';
    locationController.clear();
    cityController.clear();
    currentLatLng = null;
    imagesFile.clear();
    imagesUrlList.clear();
    update();
  }

  Timestamp convertDateToTimestamp() {
    Timestamp timestamp = Timestamp.fromDate(eventDate!);
    return timestamp;
  }

  void changeMapType() {
    // print('************changeMapType${currentMapType.value}');
    if (currentMapType.value == MapType.normal) {
      currentMapType.value = MapType.satellite;
    } else {
      currentMapType.value = MapType.normal;
    }
  }

  //  drawerAllImages() {
  //   // print('**drawerAllImages***********imagesUrlList*length==${imagesUrlList.length }');
  //     for (int i = 0; i < imagesFile.length; i++) {
  //       allImages.add(Stack(children: [
  //         Padding(
  //             padding: const EdgeInsets.all(2.0),
  //             child: Image.network(imagesUrlList[i])),
  //         Positioned(
  //           top: 2,
  //           right: 3,
  //           child: InkWell(
  //               onTap: () async {
  //                 removeImageUrlByIndex(i);
  //                 await deleteImageFromFireStorage(
  //                     imagesUrlList[i]);
  //               },
  //               child: const Icon(
  //                 Icons.cancel_presentation_sharp,
  //                 size: 28,
  //                 color: Colors.redAccent,
  //               )),
  //         )
  //       ]));
  //     }
  //   // print('**drawerAllImages***********imagesFile*length==${imagesFile.length }');
  //
  //     for (int i = 0; i < imagesFile.length; i++) {
  //       allImages.add(
  //         Stack(children: [
  //           Padding(
  //             padding: const EdgeInsets.all(2.0),
  //             child: Image.file(File(
  //               imagesFile[i]!.path,
  //             )),
  //           ),
  //           Positioned(
  //             top: 2,
  //             right: 3,
  //             child: InkWell(
  //                 onTap: () {
  //                   removeImageByIndex(i);
  //                 },
  //                 child: const Icon(
  //                   Icons.cancel_presentation_sharp,
  //                   size: 28,
  //                   color: Colors.redAccent,
  //                 )),
  //           )
  //         ]),
  //       );
  //     }
  //     update() ;
  // }
}
