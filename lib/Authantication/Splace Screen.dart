import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smailo/Dashboard/Pageview%20Builder/Pageview%20builder.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wheretogo();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: Image(
                image: AssetImage("assets/img_2.png"),
                fit: BoxFit.cover,
              ),
              height: 250,
              width: 250,
            ),
          ),
        ],
      ),
      nextScreen: Pages(),
      splashTransition: SplashTransition.fadeTransition,
  duration: 3000,

      backgroundColor: Colors.white.withOpacity(0.95),
    );
    //   Scaffold(
    //   backgroundColor: Colors.white.withOpacity(0.94),
    //   body: Center(
    //     child: SizedBox(
    //       child: Image(
    //         image: AssetImage("assets/img_2.png"),
    //         fit: BoxFit.cover,
    //       ),
    //       height: 250,
    //       width: 250,
    //     ),
    //   ),
    // );
  }

  void wheretogo() async {
    Timer(
      Duration(seconds: 3),
      () {
        if (mounted) { // Check if the widget is still mounted before navigating
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Pages(),
            ),
          );
        }
      },
    );
  }
  }

