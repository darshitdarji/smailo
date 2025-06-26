import 'package:flutter/material.dart';
import 'package:smailo/Dashboard/category/category.dart';
import 'package:smailo/Dashboard/home/Homescreen.dart';
import 'package:smailo/Dashboard/offers/Offer%20Screen.dart';
import 'package:smailo/Dashboard/Profile%20Screen/Profile%20screen.dart';
import 'package:smailo/Dashboard/Orders%20Screen/Order%20Screen.dart';

class Dashboard extends StatefulWidget {
  Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Category(),
    OfferScreen(),
    OrderScreen(),
    ProfileScreen(),
  ];

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.98),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedItemColor: Colors.blue,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedIconTheme: IconThemeData(color: Colors.blue),
        unselectedItemColor: Colors.black26,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: "Category",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer_outlined),
            label: "Offer",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart_sharp),
            label: "Order",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_sharp),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBody() {
    if (_selectedIndex != 3) {
      return Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      );
    } else {
      return OrderScreen();
    }
  }
}
