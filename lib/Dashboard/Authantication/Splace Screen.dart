import 'dart:async';

import 'package:flutter/material.dart';

import '../Pageview Builder/Pageview builder.dart';

class Splacescreen extends StatefulWidget {
  const Splacescreen({super.key});

  @override
  State<Splacescreen> createState() => _SplacescreenState();
}

class _SplacescreenState extends State<Splacescreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wheretogo();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white.withOpacity(0.94),
      body: Center(
        child: SizedBox(
          child: Image(image: AssetImage("assets/img_2.png")),
          height: 200,
          width: 200,
        ),
      ),
    );
  }
  void wheretogo() async {
    Timer(
      Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Pages(),));
    },
    );
  }
}
