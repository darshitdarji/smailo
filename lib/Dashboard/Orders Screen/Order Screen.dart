import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:smailo/Dashboard/Profile%20Screen/Cart.dart';
import 'package:smailo/Dashboard/Tabbar%20screens/Cancelled.dart';
import 'package:smailo/Dashboard/Tabbar%20screens/Confomrmed.dart';
import 'package:smailo/Dashboard/home/Favourite%20Screen.dart';

import '../Tabbar screens/Panding.dart';

class Orderscreen extends StatefulWidget {
  const Orderscreen({super.key});

  @override
  State<Orderscreen> createState() => _OrderscreenState();
}

class _OrderscreenState extends State<Orderscreen> {
  List<Tab> tabbar = [
    Tab(
      text: "Pending",
    ),
    Tab(
      text: "Confirmed",
    ),
    Tab(
      text: "Cancelled",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.blue, Colors.blue.shade800])),
        ),
        title: Text("Order",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25)),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavouritePage(),
                    ));
              },
              child: Icon(Icons.favorite, size: 25, color: Colors.white)),
          SizedBox(
            width: 10,
          ),
          InkWell(
              onTap: () {
                // Navigator.push(context,MaterialPageRoute(builder: (context) => Cart(image: '', name: '', text: '', rupees: ''),));
              },
              child: Icon(Icons.shopping_cart, size: 25, color: Colors.white)),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(children: [
          Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(15),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 1, color: Colors.grey)),
            child: TabBar(
              dividerColor: Colors.white,
              labelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BubbleTabIndicator(
                padding: EdgeInsets.only(left: 0.5, right: 0.5),
                indicatorColor: Color.fromRGBO(36, 198, 220, 1),
                indicatorHeight: 30,
                tabBarIndicatorSize: TabBarIndicatorSize.label,
              ),
              tabs: tabbar,
              labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              unselectedLabelColor: Colors.black,
              padding: EdgeInsets.all(10),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: TabBarView(children: [
              Pending(),
              Conformed(),
              Cancelled(),
            ]),
          ),
        ]),
      ),
    );
  }
}
