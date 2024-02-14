import 'package:flutter/material.dart';
import 'package:smailo/Dashboard/Profile%20Screen/Cart.dart';
import 'package:smailo/Dashboard/Profile%20Screen/Edit%20Profile.dart';
import 'package:smailo/Dashboard/home/Favourite%20Screen.dart';
import 'package:smailo/Dashboard/Orders%20Screen/Order%20Screen.dart';

import '../Pageview Builder/Pageview builder.dart';
import 'orders of user/Address of Users.dart';

class Profilescreen extends StatefulWidget {
  // final VoidCallback onTap;

  Profilescreen({
    super.key,
    // required this.onTap,
  });

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  var image;

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: mediaquery.size.width * 0.95,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                    Colors.lightBlue,
                    Colors.blue.shade600,
                    Colors.blue.shade800,
                  ])),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 20, top: 50),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Editprofile(),
                                ));
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                child: ClipOval(
                                  child: Image(
                                    image: AssetImage("assets/img_2.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: mediaquery.size.width * 0.013,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Darshit",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "darjidarshit2103@gmail.com",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Pages(),
                                  ));
                            },
                            child: InkWell(
                              onTap: Dailogboox,
                              child: Container(
                                height: mediaquery.size.height * 0.04,
                                width: mediaquery.size.width * 0.2,
                                child: Center(
                                    child: Text(
                                  "Log out",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                )),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.white)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartScreen(

                                  ),
                                ));
                          },
                          child: Container(
                            height: mediaquery.size.height * 0.055,
                            width: mediaquery.size.width * 0.24,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "00",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("In your cart",
                                    style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FavouritePage(),
                                ));
                          },
                          child: Container(
                            height: mediaquery.size.height * 0.055,
                            width: mediaquery.size.width * 0.28,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "00",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("In your wishlist",
                                    style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Orderscreen(),
                                ));
                          },
                          child: Container(
                            height: mediaquery.size.height * 0.055,
                            width: mediaquery.size.width * 0.25,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "00",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("your ordered",
                                    style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: mediaquery.size.height * 0.18,
                      width: mediaquery.size.width * 1,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: mediaquery.size.height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Editprofile(),
                                      ));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.edit_calendar_outlined,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Edit Profile",
                                        style: TextStyle(fontSize: 13))
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Address(
                                          country: '',
                                          state: '',
                                          city: '',
                                          postal_code: '',
                                          phone: '',
                                          updatedData: '',
                                          address: '',
                                        ),
                                      ));
                                },
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Adress",
                                      style: TextStyle(fontSize: 13),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Orderscreen(),
                                      ));
                                },
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.edit_note_outlined,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("My orders",
                                        style: TextStyle(fontSize: 13))
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 25,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FavouritePage(),
                                      ));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.favorite_border,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("My Wishlist")
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: mediaquery.size.height * 0.025,
            ),
            Container(
              height: mediaquery.size.height * 0.46,
              width: mediaquery.size.width * 0.9,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      height: mediaquery.size.height * 0.015,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.quiz_outlined,
                            size: 18,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "FaQ's",
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: mediaquery.size.width * 0.7,
                        child: Divider(
                          height: mediaquery.size.height * 0.038,
                          color: Colors.black12,
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.question_mark,
                            size: 18,
                          ),
                          SizedBox(
                            width: mediaquery.size.width * 0.025,
                          ),
                          Text(
                            "Terms and Condition",
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: mediaquery.size.width * 0.7,
                        child: Divider(
                          height: mediaquery.size.height * 0.038,
                          color: Colors.black12,
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.privacy_tip_outlined,
                            size: 18,
                          ),
                          SizedBox(
                            width: mediaquery.size.width * 0.025,
                          ),
                          Text(
                            "Privacy Policy",
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: mediaquery.size.width * 0.7,
                        child: Divider(
                          height: mediaquery.size.height * 0.038,
                          color: Colors.black12,
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.contact_page_outlined,
                            size: 18,
                          ),
                          SizedBox(
                            width: mediaquery.size.width * 0.025,
                          ),
                          Text(
                            "Contect us",
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: mediaquery.size.width * 0.7,
                        child: Divider(
                          height: mediaquery.size.height * 0.038,
                          color: Colors.black12,
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 18,
                          ),
                          SizedBox(
                            width: mediaquery.size.width * 0.025,
                          ),
                          Text(
                            "About us ",
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: mediaquery.size.width * 0.7,
                        child: Divider(
                          height: mediaquery.size.height * 0.04,
                          color: Colors.black12,
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            Dailogboox();
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_outline_outlined,
                              size: 18,
                            ),
                            SizedBox(
                              width: mediaquery.size.width * 0.025,
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      actionsPadding: EdgeInsets.all(10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor:
                                          Colors.white.withOpacity(0.95),
                                      title: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  "Do you want to delete your\naccount from our system? \n\n",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text:
                                                  "Once your account is deleted from our\nsystem, you will lose your balance and\nother information from our system.",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black45),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        SizedBox(
                                          height: 30,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Pages(),
                                                ));
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Center(
                                                child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                        ),
                                        // SizedBox(),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Center(
                                                child: Text(
                                              "No",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "Delete my account",
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                        width: mediaquery.size.width * 0.7,
                        child: Divider(
                          height: mediaquery.size.height * 0.04,
                          color: Colors.black12,
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout_outlined,
                            size: 18,
                          ),
                          SizedBox(
                            width: mediaquery.size.width * 0.03,
                          ),
                          InkWell(
                            onTap: Dailogboox,
                            child: Text(
                              "Log out",
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void Dailogboox() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            backgroundColor: Colors.white.withOpacity(0.95),
            title: Text(
              "Do you Wants to Delete your account from our system",
              style: TextStyle(fontSize: 15),
            ),
            actions: [
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Pages(),
                      ));
                },
                child: Container(
                  height: 40,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                      child: Text(
                    "Yes",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              // SizedBox(),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                      child: Text(
                    "No",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ],
          );
        });
  }
}
