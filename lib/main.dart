import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:top_events/Home/views/home_screen.dart';
import 'package:top_events/add_event/views/add_event_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:top_events/LoginScrren/LoginScreen.dart';
import 'package:top_events/SplachScerren/SplashScreen.dart';
import 'package:top_events/all_events/views/all_events_screen.dart';
import 'package:top_events/profileScreen/EditeProfileScreen.dart';
import 'package:top_events/profileScreen/profileScreen.dart';
import 'package:top_events/tickets_Genrate_QrCode/tickets_Genrate_QrCode.dart';
import 'package:top_events/tickets_Scann_QrCode/tickets_Scan_QrCode.dart';
import 'all_Tickets/tickets_storage.dart';
import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:HomeScreen(),
      initialRoute: '/',
      getPages: [
         GetPage(name: '/', page: () =>  SplashScreen() ),
         GetPage(name: '/loginScreen', page: () =>  LoginScreen() ),
       GetPage(name: '/home', page: () =>  HomeScreen() ),
        GetPage(name: '/allEvents', page: () => const AllEventsScreen() ),
        GetPage(name: '/addEvent', page: () =>  const AddEventScreen()),
        //GetPage(name: '/createTicket', page: () =>  const TicketsGenrateQrcode()),
      ],
    );
  }

}

