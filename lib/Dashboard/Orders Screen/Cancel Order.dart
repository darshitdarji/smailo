import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Cancellorder extends StatefulWidget {
  const Cancellorder({super.key});

  @override
  State<Cancellorder> createState() => _CancellorderState();
}

class _CancellorderState extends State<Cancellorder> {
  String? Reason;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            Text("Reason for cancellation",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            SizedBox(
              height: 10,
            ),
            Text(
                "Please the tell the correct for cancellation. this information is used to improve our service",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w300)),
            Divider(
              color: Colors.black26,
              thickness: 1,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: "Select Reason ",
                      ),
                      TextSpan(text: "*", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
                // Divider(),

                RadioListTile(
                  title: Text("Product Not Required"),
                  value: "Product Not Required",
                  groupValue: Reason,
                  onChanged: (value) {
                    setState(() {
                      Reason = value.toString();
                    });
                  },
                ),

                RadioListTile(
                  title: Text("cash issue"),
                  value: "cash issue",
                  groupValue: Reason,
                  onChanged: (value) {
                    setState(() {
                      Reason = value.toString();
                    });
                  },
                ),

                RadioListTile(
                  title: Text("order by mistake"),
                  value: "order by mistake",
                  groupValue: Reason,
                  onChanged: (value) {
                    setState(() {
                      Reason = value.toString();
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.arrow_back_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                          Text("Cancel",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (Reason == null) {
                        Fluttertoast.showToast(
                            msg: "Please select the Reason",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        Fluttertoast.showToast(
                            msg: "${Reason.toString()}",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text("OK",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
