import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:top_events/LoginScrren/LoginScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
        nextScreen: LoginScreen(),
    splashIconSize: 250,
    duration:6000,
      backgroundColor: Colors.white,);
  }
}
