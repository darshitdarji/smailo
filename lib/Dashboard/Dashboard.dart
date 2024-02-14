import 'package:flutter/material.dart';
import 'package:smailo/Dashboard/category/category.dart';
import 'package:smailo/Dashboard/home/Homescreen.dart';
import 'package:smailo/Dashboard/offers/Offer%20Screen.dart';
import 'package:smailo/Dashboard/Profile%20Screen/Profile%20screen.dart';

import 'Orders Screen/Order Screen.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key, });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedindex = 0;
  int myindex = 0;

  List<Widget> _Widgetoption = <Widget>[
    HomeScreen(),
    Category(),
    OfferScreen(),
    Orderscreen(),
    Profilescreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.98),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedindex,
        onTap: (index) {
          setState(() {
            selectedindex = index;
          });
          _onitemtap(index);
        },
        selectedItemColor: Colors.blue,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedIconTheme: IconThemeData(color: Colors.blue),
        unselectedItemColor: Colors.black26,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: "Category"),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_offer_outlined), label: "Offer"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart_sharp), label: "order"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_sharp), label: "Profile")
        ],
      ),
    );
  }

  void _onitemtap(int index) {
    setState(() {
      myindex = index;
      selectedindex = index;
    });
  }

  Widget _buildBody() {
    return Center(
      child: _Widgetoption.elementAt(myindex),
    );
  }
}
