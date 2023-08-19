import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'base_page.dart';

class splash_screen extends StatelessWidget {
  const splash_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splashIconSize: 200,
      // splashTransition: SplashTransition.scaleTransition,
        splash: CircleAvatar(
          radius: 150,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          backgroundImage: AssetImage("assets/image/3-01.png"),
        ),
        nextScreen: BasePage());
  }
}
