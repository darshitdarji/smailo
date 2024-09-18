import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/Pending_OrderDetail/bloc_pending_orderdetail.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/Pending_OrderDetail/event_pending_orderdetail.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/Pending_OrderDetail/state_pending_orderdetail.dart';


import 'package:smailo/Dashboard/Orders%20Screen/reason_cancel_order.dart';
import 'package:smailo/Dashboard/home/Detail%20Screen.dart';

class PendingOrderDetail extends StatefulWidget {
  final String orderId;
  final String orderIdEncrypt;

  const PendingOrderDetail({
    super.key,
    required this.orderId,
    required this.orderIdEncrypt,
  });

  @override
  State<PendingOrderDetail> createState() => _PendingOrderDetailState();
}

class _PendingOrderDetailState extends State<PendingOrderDetail> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PendingOrderDetailBloc>(
      create: (context) => PendingOrderDetailBloc(),
      child: PendingOrderDetailPage(
        orderId: widget.orderId,
        orderIdEncrypt: widget.orderIdEncrypt,
      ),
    );
  }
}

class PendingOrderDetailPage extends StatefulWidget {
  final String orderIdEncrypt;
  final String orderId;

  const PendingOrderDetailPage({
    super.key,
    required this.orderId,
    required this.orderIdEncrypt,
  });

  @override
  State<PendingOrderDetailPage> createState() => _PendingOrderDetailPageState();
}

class _PendingOrderDetailPageState extends State<PendingOrderDetailPage> {
  int activeStep = 0;
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PendingOrderDetailBloc>(context).add(
      FetchPendingOrderDetailEvent(
          orderId: widget.orderId, orderIdEncrypt: widget.orderIdEncrypt),
    );
  }

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
      body: BlocBuilder<PendingOrderDetailBloc, PendingOrderDetailState>(
          builder: (context, state) {
        if (state is PendingOrderDetailLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PendingOrderDetailLoadedState) {
          return SingleChildScrollView(
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
                    child: Container(
                      height: 200,
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                      child: SizedBox(
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Text("Order:"),
                                          Text(
                                            state
                                                .pendingOrderDetailList
                                                .orderDetailData
                                                .orderDetail
                                                .orderNo,
                                            style: const TextStyle(
                                                color: Colors.black45),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        state
                                            .pendingOrderDetailList
                                            .orderDetailData
                                            .orderDetail
                                            .orderDate,
                                        style: const TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text("Payment type: "),
                                      Text(
                                        state
                                            .pendingOrderDetailList
                                            .orderDetailData
                                            .orderDetail
                                            .paymentType,
                                        style: const TextStyle(
                                            color: Colors.black45),
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
                                          Text(
                                            state
                                                .pendingOrderDetailList
                                                .orderDetailData
                                                .orderDetail
                                                .pickupDate,
                                            style: const TextStyle(
                                                color: Colors.black45),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          height: 30,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
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
                                  Row(
                                    children: [
                                      const Text("Total Amount :"),
                                      Text(
                                          state
                                              .pendingOrderDetailList
                                              .orderDetailData
                                              .orderDetail
                                              .totalAmount,
                                          style: const TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const Text("Pick up Location :"),
                                  Text(
                                    state.pendingOrderDetailList.orderDetailData
                                        .orderDetail.userAddressId,
                                    style:
                                        const TextStyle(color: Colors.black45),
                                  )
                                ],
                              ))),
                    ),
                  ),
                  //     },
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller,
                      itemCount: state.pendingOrderDetailList.orderDetailData
                          .orderDetail.orderItem.length,
                      itemBuilder: (BuildContext context, int index) {
                        // String? openType = Category[index]['Type'];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                      productId: state
                                          .pendingOrderDetailList
                                          .orderDetailData
                                          .orderDetail
                                          .orderItem[index]
                                          .productId
                                          .toString()),
                                ),
                              );
                            },
                            child: Container(
                              height: mediaquery.size.height * 0.13,
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
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
                                // border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  height: 70,
                                                  width: 90,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                    child: Image.network(
                                                      state
                                                          .pendingOrderDetailList
                                                          .orderDetailData
                                                          .orderDetail
                                                          .orderItem[index]
                                                          .productData
                                                          .productImage,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width:
                                                  mediaquery.size.width * 0.015,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(state
                                                    .pendingOrderDetailList
                                                    .orderDetailData
                                                    .orderDetail
                                                    .orderItem[index]
                                                    .productData
                                                    .productName),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.currency_rupee,
                                                      size: 15,
                                                      color: Colors.blue,
                                                    ),
                                                    Text(
                                                      // widget.rupees,
                                                      state
                                                          .pendingOrderDetailList
                                                          .orderDetailData
                                                          .orderDetail
                                                          .orderItem[index]
                                                          .productData
                                                          .price,
                                                      // text[index]['rupees'],
                                                      style: const TextStyle(
                                                          color: Colors.blue),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
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
                                            Text(
                                              state
                                                  .pendingOrderDetailList
                                                  .orderDetailData
                                                  .orderDetail
                                                  .orderItem[index]
                                                  .quantity,
                                              style: const TextStyle(fontSize: 15),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text("Payment Summary",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total MRP"),
                            Row(
                              children: [
                                const Icon(
                                  Icons.currency_rupee,
                                  size: 15,
                                ),
                                Text(state.pendingOrderDetailList
                                    .orderDetailData.orderDetail.subTotal
                                    .toString()),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Discount on MRP"),
                            Row(
                              children: [
                                const Icon(
                                  Icons.remove,
                                  color: Colors.green,
                                  size: 10,
                                ),
                                const Icon(
                                  Icons.currency_rupee,
                                  color: Colors.green,
                                  size: 15,
                                ),
                                Text(
                                    state.pendingOrderDetailList.orderDetailData
                                        .orderDetail.discountMrp
                                        .toString(),
                                    style: const TextStyle(color: Colors.green))
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
                                const Icon(
                                  Icons.currency_rupee,
                                  color: Colors.green,
                                  size: 15,
                                ),
                                Text(
                                  state.pendingOrderDetailList.orderDetailData
                                      .orderDetail.discountMrp
                                      .toString(),
                                  style: const TextStyle(color: Colors.green),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Order Total  ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.currency_rupee,
                                  size: 15,
                                ),
                                Text(
                                  state.pendingOrderDetailList.orderDetailData
                                      .orderDetail.totalAmount
                                      .toString(),
                                  style: const TextStyle(
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
          );
        } else if (state is PendingOrderDetailErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        return Container();
      }),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>   CancelOrderReason(orderId: widget.orderId),
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
              //     builder: (context) => Pr(),
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
