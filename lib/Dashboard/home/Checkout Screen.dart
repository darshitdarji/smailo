  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:fluttertoast/fluttertoast.dart';
  import 'package:smailo/Dashboard/Orders%20Screen/Order%20Details%20Screen.dart';

  import '../Profile Screen/Cart.dart';
  import 'Favourite Screen.dart';

  class Checkoutscreen extends StatefulWidget {
    const Checkoutscreen({super.key});

    @override
    State<Checkoutscreen> createState() => _CheckoutscreenState();
  }

  class _CheckoutscreenState extends State<Checkoutscreen> {

    int selected = 0;
    int selectradio = 0;
    String selectedValue = 'Option 1'; // Initialize with a default value

    @override
    Widget build(BuildContext context) {
      var mediaquery = MediaQuery.of(context);
      return Scaffold(

        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              )),
          title: Text("Checkout",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Colors.blue, Colors.blue.shade900])),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text("Pick up Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: mediaquery.size.height*0.09,
                  width: mediaquery.size.width*0.92,
                  decoration: BoxDecoration(
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
                      color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Radio(
                        activeColor: Colors.blue,
                        value: 1,
                        groupValue: 1,
                        onChanged: (value) {
                          selected = value!;
                        },
                      ),
                      Text(
                        "Madhuvanbaug Vidhyabhavan,New\n Kosad Road,Amroli 394107.\n mobileNo.9913514147",
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Payment Summary",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: mediaquery.size.width*0.92,
                  height: mediaquery.size.height*0.21,
                  decoration: BoxDecoration(
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
                      color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total MRP", style: TextStyle(fontSize: 15)),

                            Row(
                              children: [
                                Icon(
                                  Icons.currency_rupee,
                                  size: 15,
                                ),
                                Text("34",
                                  // widget.rupees
                                )
                              ],
                            ),

                          ],
                        ),
                        Divider(
                          color: Colors.black26,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Discount on MRP", style: TextStyle(fontSize: 15)),

                            Row(
                              children: [
                                GestureDetector(
                                    child: Icon(
                                      Icons.remove,
                                      size: 10,color: Colors.green,
                                    )),
                                Icon(
                                  Icons.currency_rupee,
                                  size: 15,color: Colors.green,
                                ),
                                Text("0",style: TextStyle(color: Colors.green),)
                              ],
                            ),

                          ],
                        ),
                        Divider(
                          color: Colors.black26,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Coupon Discount", style: TextStyle(fontSize: 15)),

                            Row(
                              children: [
                                Icon(
                                  Icons.remove,color: Colors.green,
                                  size: 10,
                                ),
                                Icon(
                                  Icons.currency_rupee,
                                  color: Colors.green,size: 15,
                                ),
                                Text("0",style: TextStyle(color: Colors.green),)
                              ],
                            ),

                          ],
                        ),
                        Divider(
                          color: Colors.black26,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Order Total",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                            Row(
                              children: [
                                Icon(
                                  Icons.currency_rupee,
                                  size: 15,
                                ),
                                Text(
                                  // widget.rupees
                                  "34",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text("Mode of Payment",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
                SizedBox(height: 10,),

                Container(
                  height:
                  mediaquery.size.height*0.07,
                  width: mediaquery.size.width*0.92,
                  decoration: BoxDecoration(
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
                      color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                selectradio == null ;

                    },
                        child: Radio(
                          activeColor: selectradio == 1 ? Colors.blue : Colors.red,
                          value: 1,
                          groupValue: selectradio,
                          onChanged: (value) {
                            setState(() {
                              selectradio = value as int  ;

                            });
                          },
                        ),
                      ),
                      Text("Cash on Pick Up ",
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),

              ]
          ),

        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.start,

          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                  height: mediaquery.size.height * 0.075,
                  width: mediaquery.size.width * 0.5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(10))),
                  child: Center(
                      child: Text("Cancel",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)))),
            ),
            InkWell(
  onTap: (){
    setState(() {
  if(selectradio == 1){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrderDetails(),));

  }else{
    Fluttertoast.showToast(msg: "Please select Cash on Pick Up \n to proceed to payment",gravity: ToastGravity.BOTTOM,toastLength:Toast.LENGTH_LONG);

  }

    });
  },
              child: Container(
                height: mediaquery.size.height * 0.075,
                width: mediaquery.size.width * 0.5,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(10))),
                  child: Center(
                      child: Text("Proceed Payment",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15))),),
            ),

          ],
        ),

      );
    }
    void _showSnackBar(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
