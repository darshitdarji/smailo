import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Upadatedailogbpox extends StatefulWidget {




  const Upadatedailogbpox({super.key,  });

  @override
  State<Upadatedailogbpox> createState() => _UpadatedailogbpoxState();
}

class _UpadatedailogbpoxState extends State<Upadatedailogbpox> {
  final _formKey = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();
  TextEditingController address = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController postalcode = TextEditingController();
  ScrollController controller = ScrollController();
 
    // Close the dialog or perform other actions if needed
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: AlertDialog(
        // buttonPadding: EdgeInsets.all(10),
        insetPadding: EdgeInsets.all(20),
        actionsPadding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        actions: [
          Form(
            key: _formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text("Adreess*",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                SizedBox(height: mediaquery.size.height * 0.013),
                Container(
                  height: mediaquery.size.height * 0.06,
                  width: mediaquery.size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    controller: address,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10),
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                        hintText: "Enter Full Adress",
                        hintStyle: TextStyle(color: Colors.black26)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Country*",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                SizedBox(height: mediaquery.size.height * 0.013),
                Container(
                  height: mediaquery.size.height * 0.06,
                  width: mediaquery.size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    controller: country,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10),
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                        hintText: "Enter Country",
                        hintStyle: TextStyle(color: Colors.black26)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("State*",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                SizedBox(height: mediaquery.size.height * 0.013),
                Container(
                  height: mediaquery.size.height * 0.06,
                  width: mediaquery.size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    controller: state,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10),
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                        hintText: "Enter State ",
                        hintStyle: TextStyle(color: Colors.black26)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("City*",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                SizedBox(height: mediaquery.size.height * 0.013),
                Container(
                  height: mediaquery.size.height * 0.06,
                  width: mediaquery.size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    controller: city,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10),
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                        hintText: "Enter City",
                        hintStyle: TextStyle(color: Colors.black26)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Postal Code*",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                SizedBox(height: mediaquery.size.height * 0.013),
                Container(
                  height: mediaquery.size.height * 0.06,
                  width: mediaquery.size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(3)),
                  child: TextFormField(
                    controller: postalcode,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10),
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                        hintText: "Enter Postal Code",
                        hintStyle: TextStyle(color: Colors.black26)),
                  ),
                ),
                SizedBox(height: mediaquery.size.height * 0.013),
                Text("Phone*",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                SizedBox(height: mediaquery.size.height * 0.013),
                Container(
                  height: mediaquery.size.height * 0.06,
                  width: mediaquery.size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(3)),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: phone,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10),
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                        hintText: "Enter Phone",
                        hintStyle: TextStyle(color: Colors.black26)),
                  ),
                ),
                SizedBox(
                  height: mediaquery.size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          color: Colors.blue, // Border color
                          width: 1, // Border width
                        ),
                        minimumSize: Size(70, 35),
                        // Adjust width and height as needed
                        backgroundColor: Colors.white,
                        // Set your desired background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                          child: Text(
                        "Close",
                        style: TextStyle(color: Colors.blue),
                      )),
                    ),
                    SizedBox(
                      width: mediaquery.size.width * 0.03,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          color: Colors.blue, // Border color
                          width: 1, // Border width
                        ),
                        minimumSize: Size(70, 35),
                        // Adjust width and height as needed
                        backgroundColor: Colors.blue,
                        // Set your desired background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onPressed: () {

                        setState(() {
                          if (address.text.isEmpty ||
                              country.text.isEmpty ||
                              state.text.isEmpty ||
                              city.text.isEmpty ||
                              postalcode.text.isEmpty ||
                              phone.text.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "Please enter all field ",
                              // gravity: ToastGravity.BOTTOM,
                              fontSize: 15,
                              backgroundColor: Colors.black26,
                              textColor: Colors.white,
                              toastLength: Toast.LENGTH_LONG,
                            );

                          } else {
                            Exception("not null");
                            Fluttertoast.showToast(
                              msg: "Address Update Successfully..! ",
                              // gravity: ToastGravity.BOTTOM,
                              fontSize: 15,
                              backgroundColor: Colors.black26,
                              textColor: Colors.white,
                              toastLength: Toast.LENGTH_LONG,
                            );
                            Navigator.of(context).pop(address.text);
                         }
                        });
                      },
                      child: Center(
                          child: Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
