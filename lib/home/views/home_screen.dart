import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_events/all_events/views/all_events_screen.dart';
import 'package:top_events/my_posted_events/views/my_posted_events_screen.dart';
import 'package:top_events/profileScreen/profileScreen.dart';
import 'package:top_events/tickets_Scann_QrCode/tickets_Scan_QrCode.dart';

import '../../all_Tickets/tickets_storage.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController homeController = Get.put(HomeController());



  @override
  Widget build(BuildContext context) {
    // final screens = [
    //   AllEventsScreen(),
    //   const MyPostedEventsScreen(),
    //   TicketsStorage(),
    //   homeController.isAdmin.value==true? TicketsScannQrcode():Container(),
    //   ProfileScreen(),
    // ];
    // final icons = <Widget>[
    //   ///Home
    //   const SizedBox(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       mainAxisAlignment:MainAxisAlignment.end,
    //       children: [Icon(Icons.home, size: 22), Text("Home",style: TextStyle(
    //         fontSize: 10,
    //       ),),],
    //     ),
    //   ),
    //   ///Events
    //
    //   const SizedBox(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       mainAxisAlignment:MainAxisAlignment.end,
    //       children: [Icon(Icons.event_available_sharp, size: 22), Text("Events",style: TextStyle(
    //         fontSize: 10,
    //       ))],
    //     ),
    //   ),
    //   ///Tickets
    //   const SizedBox(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       mainAxisAlignment:MainAxisAlignment.end,
    //       children: [Icon(Icons.ballot_sharp, size: 22), Text("Tickets",style: TextStyle(
    //         fontSize: 10,
    //       ))],
    //     ),
    //   ),
    //   ///Scanner
    //   homeController.isAdmin.value==true?  const SizedBox(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       mainAxisAlignment:MainAxisAlignment.end,
    //       children: [Icon(Icons.qr_code_scanner_outlined, size: 22), Text("Scanner",style: TextStyle(
    //         fontSize: 10,
    //       ))],
    //     ),
    //   ):Container(),
    //   ///Profile
    //   const SizedBox(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       mainAxisAlignment:MainAxisAlignment.end,
    //       children: [Icon(Icons.person, size: 20), Text("Profile",style: TextStyle(
    //         fontSize: 8,
    //       ))],
    //     ),
    //   ),
    // ];
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        // body: Obx(() => screens[homeController.selectedIndex.value]),
        body: drawerScreens(homeController),
        bottomNavigationBar: CurvedNavigationBar(
          animationCurve: Curves.ease,
          // animationDuration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
          color: Colors.purple,
          buttonBackgroundColor: Colors.green,
          height: 56,
          items:  drawerBottomNavigationListItems(homeController),
          onTap: (index) {
            homeController.changeScreen(index);
          },
        ),
      ),
    );
  }
  List<Widget> drawerBottomNavigationListItems(HomeController homeController){
    return <Widget>[
      ///Home
      drawerItemBottomNavigation( "Home" ,Icons.home),
      ///Events
      drawerItemBottomNavigation( "Events" ,Icons.event_available_sharp),
      ///Tickets
      drawerItemBottomNavigation( "Tickets" ,Icons.ballot_sharp),
      ///Scanner
    //   Obx(
    // ()=> homeController.isAdmin.value==true? drawerItemBottomNavigation( "Home" ,Icons.home)
    //     :Container(),
    //   ),
      if (homeController.isAdmin.value)  drawerItemBottomNavigation( "Scanner" ,Icons.qr_code_scanner_outlined),


      ///Profile
      drawerItemBottomNavigation( "Profile" ,Icons.person),

    ];
   }

  Widget drawerItemBottomNavigation(String label ,IconData icon){
    return  SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:MainAxisAlignment.end,
        children: [  Icon(icon, size: 22), Text(label,style: const TextStyle(
          fontSize: 10,
        ))],
      ),
    );
  }

   Widget drawerScreens(HomeController homeController){
     final screens = [
       AllEventsScreen(),
       const MyPostedEventsScreen(),
       TicketsStorage(),
       if (homeController.isAdmin.value) TicketsScannQrcode(),
     ProfileScreen(),
     ];
    return Obx(() => screens[homeController.selectedIndex.value]) ;
   }
}
