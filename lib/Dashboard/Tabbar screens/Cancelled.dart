import 'package:flutter/material.dart';
import 'package:smailo/Dashboard/Orders%20Screen/Cancel_orderdetailscreen.dart';
import 'package:smailo/Dashboard/Orders%20Screen/Order%20Details%20Screen.dart';

class Cancelled extends StatefulWidget {
  const Cancelled({super.key});

  @override
  State<Cancelled> createState() => _CancelledState();
}

class _CancelledState extends State<Cancelled> {


  ScrollController Controller = ScrollController();
  final List<Map<String, dynamic>> Orders = [
    {
      'Order': 'MBV431',
      'Quantity': 2,
      'Details': 'Deatails',
      'Date': '18/12/2023',
      'Amount': 'Total Amount1:',
      'INR': '34INR',
      'Conformation': 'Cancelled'
    },
    {
      'Order': 'MBV430',
      'Quantity': 2,
      'Details': 'Deatails',
      'Date': '18/12/2023',
      'Amount': 'Total Amount:',
      'INR': '34INR',
      'Conformation': 'Cancelled'
    },
    {
      'Order': 'MBV429',
      'Quantity': 2,
      'Details': 'Deatails',
      'Date': '8/12/2023',
      'Amount': 'Total Amount:',
      'INR': '34INR',
      'Conformation': 'Cancelled'
    },
    {
      'Order': 'MBV428',
      'Quantity': 1,
      'Details': 'Deatails',
      'Date': '7/12/2023',
      'Amount': 'Total Amount:',
      'INR': '126INR',
      'Conformation': 'Cancelled'
    },

  ];
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                controller: Controller,
                itemCount: Orders.length,

                itemBuilder: (BuildContext context, int index) {
                  return

                    Container(
                      margin: EdgeInsets.all(10),
                    height: mediaquery.size.height*0.16,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [ Text("Order:"),
                                  Text(Orders[index]['Order'].toString(),style: TextStyle(color: Colors.black38)),

                                ],
                              ),
                              Text(Orders[index]['Date'].toString(),style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500)),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text("Quantity:"),
                                  Text(Orders[index]['Quantity'].toString(),style: TextStyle(color: Colors.black38)),

                                ],
                              ),
                              Row(
                                children: [
                                  Text(Orders[index]['Amount']),
                                  Text(Orders[index]['INR'].toString(),style: TextStyle(color: Colors.blue)),

                                ],
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Cancel_orderdeatail(),));
                                },
                                child: Container(
                                  height: mediaquery.size.height*0.04,
                                  width: mediaquery.size.width*0.2,
                                  child: Center(
                                      child: Text(
                                    "Details",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  )),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(
                                            0.5,
                                            4,
                                          ),
                                          blurRadius: 2,
                                          spreadRadius: 0.5,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                              Text(Orders[index]['Conformation'].toString(),style: TextStyle(color: Colors.green),)
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
