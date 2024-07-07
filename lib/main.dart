import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:top_events/LoginScrren/LoginScreen.dart';
import 'package:top_events/RegisterScreen/RegisterScreen.dart';
import 'package:top_events/SplachScerren/SplashScreen.dart';

import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );
  runApp(GetMaterialApp(home: SplashScreen(),));
}

