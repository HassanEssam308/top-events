import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:top_events/add_event/controllers/add_event_controller.dart';

class LocationScreen extends StatelessWidget {
  final AddEventController addEventController;

  const LocationScreen({required this.addEventController, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      color: Colors.grey[300],
                      padding: const EdgeInsets.all(1),
                      child: drawerGoogleMaps(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 15),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: addEventController.cityController,
                        decoration: InputDecoration(
                          hintText: 'Search Of City',
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: InkWell(
                            onTap: () {
                              addEventController.searchCity();
                              },
                            child: const Icon(Icons.search),
                          ),
                          border: InputBorder.none,
                          // border: const OutlineInputBorder(),
                          // focusedBorder: const OutlineInputBorder(
                          //     borderSide: BorderSide(color: Colors.blue),),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Save')),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      addEventController.removeLocation();
                      Navigator.pop(context);
                    },
                    child: const Text('Remove Location')),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerGoogleMaps() {
    CameraPosition initialCameraPosition = CameraPosition(
        target: addEventController.currentLatLng ??
            const LatLng(27.179617306030632, 31.186620725534446),
        zoom: 12);

    return Stack(
      children: [
        Obx(
          () => GoogleMap(
            mapType: addEventController.currentMapType.value,
            markers: addEventController.markers.toSet(),
            onMapCreated: (controller) {
              addEventController.googleMapController = controller;
            },

            onTap: (LatLng latLng) async {
              addEventController.addMarker(latLng);
              addEventController.setLocationToTextField(latLng);
              addEventController.setSelectedLatLng(latLng);
            },
            initialCameraPosition: initialCameraPosition,
          ),
        ),
              Positioned(
                bottom: 35,
                left:2 ,
                child:IconButton.outlined(
                  color: Colors.black,
                  onPressed: () {
                    addEventController.changeMapType();
                  },
                  icon: Obx(
                    () => Icon(
                      Icons.map,
                      size: 30,
                      color: addEventController.currentMapType.value ==
                              MapType.normal
                          ? Colors.green
                          : Colors.grey[500],
                    ),
                  ),
                ),
              ),
            ],
    );
  }
}
