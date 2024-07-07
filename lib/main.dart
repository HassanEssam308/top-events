import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:top_events/add_event/views/add_event_screen.dart';
import 'package:top_events/LoginScrren/LoginScreen.dart';
import 'package:top_events/RegisterScreen/RegisterScreen.dart';
import 'package:top_events/SplachScerren/SplashScreen.dart';


import 'Home/views/home_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      initialRoute: '/',
      getPages: [
         GetPage(name: '/', page: () => const SplashScreen() ),
        GetPage(name: '/home', page: () => const HomeScreen() ),
        GetPage(name: '/addEvent', page: () => const AddEventScreen()),
      // Add more routes as needed
      ],
    );
  }

  );

}

