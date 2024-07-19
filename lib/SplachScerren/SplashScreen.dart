import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:top_events/LoginScrren/LoginScreen.dart';

import '../Home/views/home_screen.dart';
import '../bordingScreen/bordingScreen.dart';
import '../constants.dart';


class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});
   Widget drawerWidget() {
    var  userID= box.read('uid');
      bool open=box.read("isFirstOpen")??true;
     return (open)?Onbording():
     (userID==null)?LoginScreen(): HomeScreen() ;
   }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash:
      Column(children: [
            Expanded(
              child: Center(
                child: LottieBuilder.asset("lottie/Animation - 1720253908181.json"),
              ),
            )
      ],),
        nextScreen: drawerWidget(),
    splashIconSize: 250,
    duration:6000,
      backgroundColor: Colors.white,);
  }
}
