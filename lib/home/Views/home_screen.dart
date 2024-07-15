import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_events/all_events/views/all_events_screen.dart';
import 'package:top_events/my_posted_events/views/my_posted_events_screen.dart';

import '../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

 final HomeController homeController = Get.put(HomeController());
  final screens = [
    const AllEventsScreen(),
    const MyPostedEventsScreen(),
  ];
final icons=<Widget>[
 const Icon(Icons.home,size: 25,),
 const Icon(Icons.event_available_sharp,size: 25,)
];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(()=>screens[homeController.selectedIndex.value]),
        bottomNavigationBar: CurvedNavigationBar(
          animationCurve: Curves.ease,
          animationDuration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
          color: Colors.purple,
          buttonBackgroundColor: Colors.green,
          height: 56,

          items:icons,
          onTap: (index){
            homeController.changeScreen(index);
          },
        ),
      ),
    );
  }
}
