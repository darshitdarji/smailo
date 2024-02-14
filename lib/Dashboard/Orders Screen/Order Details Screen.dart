import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smailo/Dashboard/Orders%20Screen/Cancel%20Order.dart';
import 'package:url_launcher/url_launcher.dart';



class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final Uri _url = Uri.parse('https://flutter.dev');

  Future<void> _launchUrl(String invoiceUrl) async {
    if (await canLaunch(invoiceUrl)) {
      await launch(invoiceUrl);
    } else {
      throw 'Could not launch $invoiceUrl';
    }
  }

  final List<Map<String, dynamic>> text = [
    {
      'image': 'assets/img_9.png',
      'name': 'ગુજરાતી',
      'text': 'પાથ્યપુસ્તક',
      'Icon': Icons.shopping_cart,
      'rupees': '34',
      'icondata': Icons.currency_rupee
    },
    {
      'image': 'assets/img_10.png',
      'name': 'ગણિત',
      'text': 'પાથ્યપુસ્તક',
      'Icon': Icons.shopping_cart,
      'rupees': '149',
      'icondata': Icons.currency_rupee
    },
    {
      'image': 'assets/img_11.png',
      'name': 'વિજ્ઞાન',
      'text': 'પાથ્યપુસ્તક',
      'Icon': Icons.shopping_cart,
      'rupees': 149,
      'icondata': Icons.currency_rupee
    },
    {
      'image': 'assets/img_12.png',
      'name': 'સામાજિક વિજ્ઞાન',
      'text': 'પાથ્યપુસ્તક',
      'Icon': Icons.shopping_cart,
      'rupees': 49,
      'icondata': Icons.currency_rupee
    },
    {
      'image': 'assets/img_13.png',
      'name': 'સંસ્કૃત',
      'text': 'પાથ્યપુસ્તક',
      'Icon': Icons.shopping_cart,
      'rupees': 44,
      'icondata': Icons.currency_rupee
    }
  ];

  int activeStep = 0;
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.blue, Colors.blue.shade900])),
        ),
        backgroundColor: Colors.white.withOpacity(0.95),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text("Pending",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 20)),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                // Wrap EasyStepper with Row
                children: [
                  Expanded(
                    child: EasyStepper(
                      stepRadius: 22,
                      stepBorderRadius: 15,
                      activeStep: 1,
                      finishedStepTextColor: Colors.blue,

                      unreachedStepTextColor: Colors.blue,
                      unreachedStepIconColor: Colors.grey,
                      finishedStepBackgroundColor: Colors.blue,
                      unreachedStepBackgroundColor: Colors.white,
                      // enableStepTapping: true,
                      stepShape: StepShape.circle,
                      showLoadingAnimation: true,
                      direction: Axis.horizontal,
                      // Set the direction to horizontal
                      steps: [
                        EasyStep(
                          icon: Icon(CupertinoIcons.cart),
                          title: 'Pending',
                        ),
                        EasyStep(
                          icon: Icon(Icons.filter_center_focus_sharp),
                          title: 'confirmed',
                        ),
                        EasyStep(
                          icon: Icon(Icons.local_shipping_outlined),
                          title: 'Ready',
                        ),
                        EasyStep(
                          icon: Icon(Icons.thumb_up),
                          title: 'Delivered',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller,
                  itemCount: 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1.9,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    // String? openType = Category[index]['Type'];
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            const BoxShadow(
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
                        child: Container(
                            height: 50,
                            width: 50,
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text("Order:"),
                                            Text(
                                              "MBV432",
                                              style: TextStyle(
                                                  color: Colors.black45),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "20-12-2023",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const Row(
                                      children: [
                                        Text("Payment type: "),
                                        Text(
                                          "Pickup",
                                          style:
                                              TextStyle(color: Colors.black45),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Text("Pick up Date:"),
                                            const Text(
                                              "22/12/2023",
                                              style: TextStyle(
                                                  color: Colors.black45),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (text[index]['name'] ==
                                                  'Invoice') {
                                                String invoiceUrl =
                                                    'https://example.com/invoice.pdf';
                                                _launchUrl(invoiceUrl);
                                              }
                                            });
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                const BoxShadow(
                                                  color: Colors.black12,
                                                  offset: Offset(
                                                    1,
                                                    6,
                                                  ),
                                                  blurRadius: 2,
                                                  spreadRadius: 2,
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: const Center(
                                                child: Text("Invoice",
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                          ),
                                        )
                                      ],
                                    ),
                                    const Row(
                                      children: [
                                        Text("Total Amount :"),
                                        Text(" 183INR ",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    const Text("Pick up Location :"),
                                    const Text(
                                      "Madhavbaug Vidhyabaug,  New Kosad Road, Amroli 394107",
                                      style: TextStyle(color: Colors.black45),
                                    )
                                  ],
                                ))),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     child: GridView.builder(
              //       scrollDirection: Axis.vertical,
              //       shrinkWrap: true,
              //       controller: controller,
              //       itemCount: 1,
              //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 1,
              //         mainAxisSpacing: 15,
              //         crossAxisSpacing: 15,
              //         childAspectRatio: 3.7,
              //       ),
              //       itemBuilder: (BuildContext context, int index) {
              //         return
              //
              //       },
              //     ),
              //   ),
              // ),
              Container(
                height: mediaquery.size.height * 0.13,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.black12,
                      offset: Offset(
                        1,
                        6,
                      ),
                      blurRadius: 2,
                      spreadRadius: 2,
                    ),
                  ],
                  // border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              height: 70,
                              width: 90,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: const Image(
                                  image: AssetImage(
                                    // widget.image
                                    //   text[index]['image']
                                    "assets/img_11.png",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(
                            //   height: 5,
                            // ),
                            Text(
                              // widget.name
                              "વિજ્ઞાન",
                              //   text[index]['name']
                            ),
                            Row(
                              children: [
                                Icon(
                                  // text[index]['Icon'],
                                  Icons.currency_rupee,
                                  size: 15,
                                  color: Colors.blue,
                                ),
                                Text(
                                  // widget.rupees,
                                  "34", //

                                  // text[index]['rupees'],
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 160,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              // onTap: () {
                              //   showModalBottomSheet(
                              //     context: context,
                              //     builder: (context) {
                              //       return const Bottomsheet(  image: '', name: '',
                              //       );
                              //     },
                              //   );
                              // },
                              child: const Icon(
                                Icons.close,
                                size: 15,
                              ),
                            ),
                            const Text(
                              "1",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text("Payment Summary",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: mediaquery.size.height * 0.23,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total MRP"),
                        Row(
                          children: [
                            Icon(
                              Icons.currency_rupee,
                              size: 15,
                            ),
                            Text("126"),
                          ],
                        ),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Discount on MRP"),
                        // SizedBox(
                        //   width: 170,
                        // ),
                        Row(
                          children: [
                            Icon(
                              Icons.remove,
                              color: Colors.green,
                              size: 10,
                            ),
                            Icon(
                              Icons.currency_rupee,
                              color: Colors.green,
                              size: 15,
                            ),
                            Text("0", style: TextStyle(color: Colors.green))
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Coupon Discount"),
                        Row(
                          children: [
                            const Icon(
                              Icons.remove,
                              color: Colors.green,
                              size: 10,
                            ),
                            Icon(
                              Icons.currency_rupee,
                              color: Colors.green,
                              size: 15,
                            ),
                            const Text(
                              "0",
                              style: TextStyle(color: Colors.green),
                            )
                          ],
                        ),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order Total  ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // SizedBox(
                        //   width: 200,
                        // ),
                        Row(
                          children: [
                            Icon(
                              Icons.currency_rupee,
                              size: 15,
                            ),
                            Text(
                              "126",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
// SizedBox(height: 10,)
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Cancellorder(),
                ),
              );
            },
            child: Container(
              height: mediaquery.size.height * 0.075,
              width: mediaquery.size.width * 0.5,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: const Center(
                child: Text(
                  "Cancel Order",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const Product(),
              //   ),
              // );
            },
            child: Container(
              height: mediaquery.size.height * 0.075,
              width: mediaquery.size.width * 0.5,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(
                    10,
                  ),
                ),
              ),
              child: const Center(
                child: Text(
                  "View More",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
