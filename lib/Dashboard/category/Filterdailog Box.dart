import 'package:flutter/material.dart';

class filterdailogbox extends StatefulWidget {

  const filterdailogbox({super.key});

  @override
  State<filterdailogbox> createState() => _filterdailogboxState();
}

class _filterdailogboxState extends State<filterdailogbox> {
  int select = -1;
  int sortselect = 0;

String filtershortby = '';
String filterprice  = '';
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return AlertDialog(
      contentPadding: EdgeInsets.all(10),

      insetPadding: EdgeInsets.all(20),
      content: Container(
        height: mediaquery.size.height * 0.52,
        width: mediaquery.size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: mediaquery.size.height * 0.035,
                      // height: mediaquery.size.height * 0.035,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue.shade200,
                      ),
                      child: Icon(Icons.close_sharp)),
                )
              ],
            ),
            Center(
                child: Text(
              "Sort and Filter ",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )),
            Divider(color: Colors.black26),
            Text(
              "Price",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(vertical: -4, horizontal: -4),
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 7,
              title: const Text(
                '0-100',
                style: TextStyle(fontSize: 15),
              ),
              leading: Radio(
                value: '1',
                groupValue: filterprice,
                onChanged: (value) {
                  setState(() {
                    filterprice = value.toString();
                  });
                },
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(vertical: -4, horizontal: -4),
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 7,
              title: const Text(
                '100-300',
                style: TextStyle(fontSize: 15),
              ),
              leading: Radio(
                value: '2',
                groupValue: filterprice,
                onChanged: (value) {
                  setState(() {
                    filterprice = value.toString();
                  });
                },
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(vertical: 0, horizontal: -4),
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 7,
              title: const Text(
                '300-500',
                style: TextStyle(fontSize: 15),
              ),
              leading: Radio(
                value: '3',
                groupValue: filterprice,
                onChanged: (value) {
                  setState(() {
                    filterprice = value.toString();
                  });
                },
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(vertical: -4, horizontal: -4),
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 7,
              title: const Text(
                '500 above',
                style: TextStyle(fontSize: 15),
              ),
              leading: Radio(
                value: '4',


                groupValue: filterprice,
                onChanged: (value) {
                  setState(() {
                    filterprice = value.toString();
                  });
                },
              ),
            ),
            Divider(color: Colors.black26),
            Text(
              "Sort by",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            ListTile(
              visualDensity: VisualDensity(vertical: -4, horizontal: -4),
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 7,
              title: const Text(
                'Popularity',
                style: TextStyle(fontSize: 15),
              ),
              leading: Radio(
                value: '1',
                groupValue:filtershortby ,
                onChanged: (values) {
                  setState(() {
                    filtershortby = values.toString();
                  });
                },
              ),
            ),
            ListTile(
              horizontalTitleGap: 7,
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity(vertical: -4, horizontal: -4),
              title: const Text(
                'Newest First',
                style: TextStyle(fontSize: 15),
              ),
              leading: Radio(
                value: '2',
                groupValue: filtershortby,
                onChanged: (values) {
                  setState(() {
                    filtershortby = values.toString();
                  });
                },
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(vertical: -4, horizontal: -4),
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 7,
              title: const Text(
                'Features Product',
                style: TextStyle(fontSize: 15),
              ),
              leading: Radio(
                value: '3s',
                groupValue: filtershortby,
                onChanged: (values) {
                  setState(() {
                   filtershortby = values.toString();
                  });
                },
              ),
            ),
          ],
        ),
      ),
      actionsPadding: EdgeInsets.only(bottom: 20),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              side: BorderSide(
                color: Colors.blue, // Border color
                width: 1, // Border width
              ),
              minimumSize: Size(120, 40),
              // Adjust width and height as needed
              backgroundColor: Colors.white,
              // Set your desired background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text(
              "Clear All",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            )),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(120, 40), // Adjust width and height as needed
              backgroundColor: Colors.blue, // Set your desired background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {

              setState(() {
                Navigator.of(context).pop([filterprice,filtershortby] );

              });
            },
            child: Text(
              "Apply",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )),
      ],
    );
  }
}
