import 'package:flutter/material.dart';

class Conformed extends StatefulWidget {
  const Conformed({super.key});

  @override
  State<Conformed> createState() => _ConformedState();
}

class _ConformedState extends State<Conformed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Confirmed Order Are Not avilable",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black45)),
      ),

    );
  }
}
