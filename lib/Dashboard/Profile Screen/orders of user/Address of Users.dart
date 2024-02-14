import 'package:flutter/material.dart';
import 'package:smailo/Dashboard/Profile%20Screen/orders%20of%20user/UpdateDailogbox.dart';

import 'Orderdailogbox.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class Address extends StatefulWidget {
  final String updatedData;
  final String country;
  final String state;
  final String city;
  final String address;
  final String postal_code;
  final String phone;

  Address({
    super.key,
    required this.country,
    required this.state,
    required this.city,
    required this.postal_code,
    required this.phone,
    required this.updatedData,
    required this.address,
  });

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  bool isDefaultAddress = false;
  SampleItem _selectedItem = SampleItem.itemOne;

  SampleItem get selectedItem => _selectedItem;
  SampleItem selectedMenu = SampleItem.itemOne;
  ScrollController controller = ScrollController();

  final List<Map<String, dynamic>> user_detail = [
    {'text': 'Default addresses'},
    {'text': 'Address'}
  ];

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.blue, Colors.blue.shade900])),
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.white)),
        title: const Text("Addresses of Users",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: mediaquery.size.height * 0.15,
              width: mediaquery.size.width * 1,
              decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Newadress();
                    },
                  );
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text("Add Address",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              itemCount: user_detail.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    height: mediaquery.size.height * 0.25,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(
                            1,
                            6,
                          ),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 5,
                        right: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text("Address :",
                                      style: TextStyle(
                                          color: Colors.black26,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    width: mediaquery.size.width * 0.01,
                                  ),
                                  Text("Science city",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              PopupMenuButton<SampleItem>(
                                onSelected: (SampleItem item) {
                                  setState(() {
                                    selectedMenu = item;
                                    if (item == SampleItem.itemTwo) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Upadatedailogbpox();
                                        },
                                      );
                                    }
                                    if (item == SampleItem.itemOne) {
                                      Dailogbox();
                                    }
                                  });
                                },
                                itemBuilder: (BuildContext context) {
                                  List<PopupMenuEntry<SampleItem>> menuItems =
                                      [];
                                  String? openType = user_detail[index]['text'];
                                  if (openType == 'Default addresses') {
                                    print('DEFAULT');
                                    menuItems.add(
                                      PopupMenuItem(
                                        value: SampleItem.itemTwo,
                                        child: Text('Edit'),
                                      ),
                                    );
                                    menuItems.add(
                                      PopupMenuItem<SampleItem>(
                                        value: SampleItem.itemOne,
                                        child: Text('Delete'),
                                      ),
                                    );
                                  } else {
                                    print('NOT DEFAULT');
                                    // Default address is not mentioned in the list
                                    menuItems.add(
                                      PopupMenuItem<SampleItem>(
                                        value: SampleItem.itemTwo,
                                        child: Text('Edit'),
                                      ),
                                    );
                                    menuItems.add(
                                      PopupMenuItem<SampleItem>(
                                        value: SampleItem.itemOne,
                                        child: Text('Delete'),
                                      ),
                                    );
                                    menuItems.add(
                                      PopupMenuItem<SampleItem>(
                                        value: SampleItem.itemTwo,
                                        child: Text('New Item 3'),
                                      ),
                                    );
                                  }

                                  return menuItems;
                                },
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text("City :",
                                  style: TextStyle(
                                      color: Colors.black26,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: mediaquery.size.width * 0.01,
                              ),
                              Text("Ahmedabad",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          Row(
                            children: [
                              Text("State :",
                                  style: TextStyle(
                                      color: Colors.black26,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: mediaquery.size.width * 0.01,
                              ),
                              Text("Gujarat",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          Row(
                            children: [
                              Text("Country :",
                                  style: TextStyle(
                                      color: Colors.black26,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: mediaquery.size.width * 0.01,
                              ),
                              Text("India",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          Row(
                            children: [
                              Text("Postal code :",
                                  style: TextStyle(
                                      color: Colors.black26,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: mediaquery.size.width * 0.01,
                              ),
                              Text("380001",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Phone :",
                                    style: TextStyle(
                                        color: Colors.black26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: mediaquery.size.width * 0.01,
                                  ),
                                  Text("94844615823",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Text(user_detail[index]['text'],
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 12))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void Dailogbox() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          insetPadding: EdgeInsets.all(0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          actionsPadding: EdgeInsets.symmetric(horizontal: 10),
          title: Text("Confirm"),
          content: Text("Are you sure you wish to delete \nthis address?"),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(70, 35),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "DELETE",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(70, 35),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("CANCEL",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)))
          ],
        );
      },
    );
  }
}
