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
  const HomeScreen({super.key});





  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: drawerScreens(homeController),
        bottomNavigationBar: CurvedNavigationBar(
          animationCurve: Curves.ease,
          index:homeController.selectedIndex.value ,
          backgroundColor: Colors.amberAccent.shade100,
          color: Colors.deepPurple,
          buttonBackgroundColor: Colors.white,
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

    List<Widget> itemsBottomForAdmin = <Widget>[
      ///Home
      drawerItemBottomNavigation( "Home" ,Icons.home),
      ///Events
      drawerItemBottomNavigation( "Events" ,Icons.event_available_sharp),
      ///Tickets
      drawerItemBottomNavigation( "Tickets" ,Icons.ballot_sharp),
      ///Scanner
      drawerItemBottomNavigation( "Scanner" ,Icons.qr_code_scanner_outlined),
      ///Profile
      drawerItemBottomNavigation( "Profile" ,Icons.person),

    ];
    List<Widget> itemsBottomForUser = <Widget>[
      ///Home
      drawerItemBottomNavigation( "Home" ,Icons.home),
      ///Events
      drawerItemBottomNavigation( "Events" ,Icons.event_available_sharp),
      ///Tickets
      drawerItemBottomNavigation( "Tickets" ,Icons.ballot_sharp),

      ///Profile
      drawerItemBottomNavigation( "Profile" ,Icons.person),

    ];

    return  (homeController.isAdmin.value==true) ? itemsBottomForAdmin: itemsBottomForUser;
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
       AllEventsScreen(isAdmin: homeController.isAdmin.value,),
       const MyPostedEventsScreen(),
       TicketsStorage(),
       if (homeController.isAdmin.value) TicketsScannQrcode(),
     ProfileScreen(),
     ];
    return Obx(() => screens[homeController.selectedIndex.value]) ;
   }
}
