import 'package:flutter/material.dart';
import 'package:smailo/Dashboard/Orders%20Screen/Order%20Details%20Screen.dart';

class Pending extends StatefulWidget {
  const   Pending({super.key});

  @override
  State<Pending> createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              itemCount:1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio:2.1,
              ),
              itemBuilder: (BuildContext context, int index) {
                // String? openType = Category[index]['Type'];
                return GestureDetector(
                  onTap: (){
                  },
                  child: Container(
                    height: 200,
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
                          blurRadius: 2,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text("Order:",style: TextStyle(color: Colors.black,),),
                                  Text("MBV432",style: TextStyle(color: Colors.black26,),),

                                ],
                              ),
                              Text("20/12/2023",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                            ],
                          ),
                          // SizedBox(height: 20,),

                          Row(
                            children: [
                              Text("Pick up Date:"),
                              Text("22/12/2023",style: TextStyle(color: Colors.black38,),),

                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text("Quantity:"),
                                  Text("2"),
                                ],
                              ),
                              // SizedBox(width: 100,),
                              Row(
                                children: [
                                  Text("Total Amount:"),
                                  Text("183INR",style: TextStyle(color: Colors.blue,),)

                                ],
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetails(),));
                                },
                                child: Container(
                                    height: mediaQuery.size.height*0.04,
                                    width: mediaQuery.size.width*0.25,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(
                                            0.5,
                                            4,
                                          ),
                                          blurRadius: 2,
                                          spreadRadius:1,
                                        ),
                                      ],
                                      color: Colors.white.withOpacity(0.95),
                                      borderRadius: BorderRadius.circular(10),

                                    ),
                                    child: Center(child: Text("Details",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold
                                    ),))),
                              ),
                              // SizedBox(width: 150,),
                              Text("Pending",style: TextStyle(fontSize: 18, color: Colors.green),)
                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

        ],
      )
    );
  }
}
