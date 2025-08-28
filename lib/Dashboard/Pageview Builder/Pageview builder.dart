import 'package:flutter/material.dart';
import 'package:smailo/Authantication/Signup%20Screen.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Pages extends StatefulWidget {
  const Pages({super.key});

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  int currentpage = 0;
  final dotcontrolle = PageController();
  ScrollController controller = ScrollController();
  List<Map<String, dynamic>> data = [
    {
      'image': 'assets/img_36.png',
      'name': 'School Wise Stationary',
      'taxt': "Easily  Get Your Stationary Product \nYour Stationary",
      'icon': Icons.circle,
      'type': 'school'
    },
    {
      'image': 'assets/img_22.png',
      'name': 'Discount',
      'taxt': 'More Discount To Market',
      'icon': Icons.circle,
      'type': 'discount'
    },
    {
      'image': 'assets/img_23.png',
      'name': 'Payment',
      'taxt': 'Easy To Use Online And Offline \nPayment',
      'icon': Icons.circle,
      'type': 'payment'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: PageView.builder(
          controller: dotcontrolle,
          itemCount: data.length,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          onPageChanged: (index) {
            setState(() {
              currentpage = index;
            });
          },
          itemBuilder: (context, index) {
            return Container(
              height: 300,
              width: 300,
              // color: Colors.blue,
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Image(
                    image: AssetImage(data[index]['image'].toString()),
                    fit: BoxFit.cover,
                    height: 300,
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Center(
                      child: Text("${data[index]['name']}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: Divider(
                      color: Colors.blue,
                    ),
                  ),
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("${data[index]['taxt']}",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                        )),
                  )),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            bottom: 20,
            left: 20,
            right: 20,
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  if (currentpage == data.length - 1) {
                  } else {
                    print("");
                  }
                });
              },
              child: InkWell(
                onTap: () {
                  if (currentpage == data.length - 1) {
                    // If on the last page, go back to the previous page
                    dotcontrolle.previousPage(
                      duration: Duration(seconds: 1),
                      curve: Curves.ease,
                    );
                  } else {
                    // Otherwise, navigate to the login screen
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => LogInScreen(),
                    //   ),
                    //   (route) => false,
                    // );
                  }
                },
                child: Row(
                  children: [
                    currentpage == data.length - 1
                        ? Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.blue,
                          )
                        : Text('Skip',
                            style: TextStyle(
                                color: Colors.blue,
                                // fontWeight: FontWeight.bold,
                                fontSize: 20)),
                  ],
                ),
              ),
            ),
            SmoothPageIndicator(
              controller: dotcontrolle,
              count: data.length,
              axisDirection: Axis.horizontal,
              effect: ExpandingDotsEffect(
                dotWidth: 10.0,
                activeDotColor: Colors.blue,
                dotHeight: 10.0,
                expansionFactor: 2,
                dotColor: Colors.black26,
              ),
            ),
            InkWell(
              onTap: () {
                if (currentpage == data.length - 1) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpScreen(),
                    ),
                    (route) => false,
                  );
                } else {
                  // Move to the next page within the PageView
                  dotcontrolle.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                }
              },
              child: Row(
                children: [
                  currentpage == data.length - 1
                      ? Text(
                          'Done',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                          ),
                        )
                      : Icon(Icons.arrow_forward_ios, color: Colors.blue),
                ],
              ),
            ),
          ]),
        ));
  }
}
