import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/address_of_users/edit_address/bloc_edit_address.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/address_of_users/edit_address/event_edit_address.dart';

class UpdateDailogBox extends StatefulWidget {
  final String addressId;
  final String address;
  final String country;
  final String states;
  final String city;
  final String pinCode;
  final String isDefault;
  final String mobileNo;

  const UpdateDailogBox(
      {super.key,
      required this.addressId,
      required this.address,
      required this.country,
      required this.states,
      required this.city,
      required this.pinCode,
      required this.isDefault,
      required this.mobileNo});

  @override
  State<UpdateDailogBox> createState() => _UpdateDailogBoxState();
}

class _UpdateDailogBoxState extends State<UpdateDailogBox> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditAddressBloc>(
      create: (context) => EditAddressBloc(),
      child: UpdateDailogBoxPage(
        addressId: widget.addressId,
        address: widget.address,
        country: widget.country,
        states: widget.states,
        city: widget.city,
        pinCode: widget.pinCode,
        isDefault: widget.isDefault,
        mobileNo: widget.mobileNo,
      ),
    );
  }
}

class UpdateDailogBoxPage extends StatefulWidget {
  final String addressId;
  final String address;
  final String country;
  final String states;
  final String city;
  final String pinCode;
  final String isDefault;
  final String mobileNo;

  const UpdateDailogBoxPage({
    super.key,
    required this.addressId,
    required this.address,
    required this.country,
    required this.states,
    required this.city,
    required this.pinCode,
    required this.isDefault,
    required this.mobileNo,
  });

  @override
  State<UpdateDailogBoxPage> createState() => _UpdateDailogBoxPageState();
}

class _UpdateDailogBoxPageState extends State<UpdateDailogBoxPage> {
  final _formKey = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();
  late TextEditingController address ;
  late TextEditingController country;
  late TextEditingController state ;
  late TextEditingController city ;
  late  TextEditingController phone ;
  late TextEditingController postalcode ;
  late TextEditingController isDefault ;

  late ScrollController controller ;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    address = TextEditingController(text: widget.address);
    country = TextEditingController(text: widget.country);
    state =TextEditingController(text: widget.states);
    city = TextEditingController(text: widget.city);
    phone = TextEditingController(text: widget.mobileNo);
    postalcode = TextEditingController(text: widget.pinCode);
    isDefault = TextEditingController(text: widget.isDefault);
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: AlertDialog(
        // buttonPadding: EdgeInsets.all(10),
        insetPadding: EdgeInsets.all(20),
        actionsPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                SizedBox(height: mediaQuery.size.height * 0.013),
                Container(
                  height: mediaQuery.size.height * 0.06,
                  width: mediaQuery.size.width * 0.9,
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
                SizedBox(height: mediaQuery.size.height * 0.013),
                Container(
                  height: mediaQuery.size.height * 0.06,
                  width: mediaQuery.size.width * 0.9,
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
                SizedBox(height: mediaQuery.size.height * 0.013),
                Container(
                  height: mediaQuery.size.height * 0.06,
                  width: mediaQuery.size.width * 0.9,
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
                SizedBox(height: mediaQuery.size.height * 0.013),
                Container(
                  height: mediaQuery.size.height * 0.06,
                  width: mediaQuery.size.width * 0.9,
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
                SizedBox(height: mediaQuery.size.height * 0.013),
                Container(
                  height: mediaQuery.size.height * 0.06,
                  width: mediaQuery.size.width * 0.9,
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
                SizedBox(height: mediaQuery.size.height * 0.013),
                Text("Phone*",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                SizedBox(height: mediaQuery.size.height * 0.013),
                Container(
                  height: mediaQuery.size.height * 0.06,
                  width: mediaQuery.size.width * 0.9,
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
                  height: mediaQuery.size.height * 0.03,
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
                      width: mediaQuery.size.width * 0.03,
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
                        Navigator.of(context).pop(address.text);
                        BlocProvider.of<EditAddressBloc>(context).add(
                          FetchEditAddressEvent(
                            addressId: widget.addressId,
                            address: address.text,
                            country: country.text,
                            states: state.text,
                            city: city.text,
                            pinCode:postalcode.text,
                            isDefault:isDefault.text,
                            mobileNo: phone.text,),
                        );
                        // setState(() {
                        //   if (address.text.isEmpty ||
                        //       country.text.isEmpty ||
                        //       state.text.isEmpty ||
                        //       city.text.isEmpty ||
                        //       postalcode.text.isEmpty ||
                        //       phone.text.isEmpty) {
                        //     Fluttertoast.showToast(
                        //       msg: "Please enter all field ",
                        //       // gravity: ToastGravity.BOTTOM,
                        //       fontSize: 15,
                        //       backgroundColor: Colors.black26,
                        //       textColor: Colors.white,
                        //       toastLength: Toast.LENGTH_LONG,
                        //     );
                        //   } else {
                        //     Exception("not null");
                        //     Fluttertoast.showToast(
                        //       msg: "Address Update Successfully..! ",
                        //       // gravity: ToastGravity.BOTTOM,
                        //       fontSize: 15,
                        //       backgroundColor: Colors.black26,
                        //       textColor: Colors.white,
                        //       toastLength: Toast.LENGTH_LONG,
                        //     );
                        //     Navigator.of(context).pop(_controller.text);
                        //   }
                        // });
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
