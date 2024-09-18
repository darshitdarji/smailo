import 'package:flutter/material.dart';

class ConformedPage extends StatefulWidget {
  const ConformedPage({super.key});

  @override
  State<ConformedPage> createState() => _ConformedPageState();
}

class _ConformedPageState extends State<ConformedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Confirmed Order Are Not avilable",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black45)),
      ),

    );
  }
}
