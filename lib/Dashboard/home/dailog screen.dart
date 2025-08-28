import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dailogscreen extends StatefulWidget {
  final String images;

  const Dailogscreen({super.key, required this.images});

  @override
  State<Dailogscreen> createState() => Imagedailog();
}

class Imagedailog extends State<Dailogscreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Stack(children: [
          Container(
            height: mediaquery.size.height * 0.65,
            width: mediaquery.size.width * 0.83,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, top: 20, bottom: 20, right: 10),
              child: InteractiveViewer(
                  minScale: 1,
                  maxScale: 10,
                  panEnabled: true,
                  boundaryMargin: EdgeInsets.all(double.infinity),
                  child: Image.network("${widget.images}",
                      width: 100, height: 100)),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                if (index == index) {
                  Navigator.of(context).pop(context);
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 296),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black12),
                child: Center(
                    child: Icon(
                  Icons.close,
                  size: 25,
                )),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
