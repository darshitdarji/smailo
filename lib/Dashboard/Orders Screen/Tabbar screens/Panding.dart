import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/pending/bloc_pending.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/pending/event_pending.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/pending/state_pending.dart';
import 'package:smailo/Dashboard/Orders%20Screen/pending_orderdetail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/pending/bloc_pending.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/pending/event_pending.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/pending/state_pending.dart';
import 'package:smailo/Dashboard/Orders%20Screen/pending_orderdetail_screen.dart';

class Pending extends StatefulWidget {
  const Pending({
    super.key,
  });

  @override
  State<Pending> createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PendingBloc>(
      create: (context) => PendingBloc(),
      child: const PendingPage(),
    );
  }
}

class PendingPage extends StatefulWidget {
  const PendingPage({
    super.key,
  });

  @override
  State<PendingPage> createState() => _PendingPageState();
}

class _PendingPageState extends State<PendingPage> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PendingBloc>(context).add(FetchPendingEvent());
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(body: BlocBuilder<PendingBloc, PendingState>(
      builder: (context, state) {
        if (state is PendingLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PendingLoadedState) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      controller: controller,
                      itemCount: state.pendingList.pendingData.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 2.1,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        // String? openType = Category[index]['Type'];
                        return Container(
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
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Order:  ",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          state.pendingList.pendingData[index]
                                              .orderNo,
                                          style: TextStyle(
                                            color: Colors.black26,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      state.pendingList.pendingData[index]
                                          .orderDate,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                // SizedBox(height: 20,),

                                Row(
                                  children: [
                                    Text("Pick up Date:  "),
                                    Text(
                                      state.pendingList.pendingData[index]
                                          .pickupDate,
                                      style: TextStyle(
                                        color: Colors.black38,
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Quantity:  "),
                                        Text(state.pendingList
                                            .pendingData[index].totalQuantity
                                            .toString()),
                                      ],
                                    ),
                                    // SizedBox(width: 100,),
                                    Row(
                                      children: [
                                        Text("Total Amount:  "),
                                        Text(
                                          state.pendingList.pendingData[index]
                                              .totalAmount,
                                          style: TextStyle(
                                            color: Colors.blue,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PendingOrderDetail(
                                              orderId: state.pendingList
                                                  .pendingData[index].id
                                                  .toString(),
                                              orderIdEncrypt: state
                                                  .pendingList
                                                  .pendingData[index]
                                                  .orderIdEncrypt,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: mediaQuery.size.height * 0.04,
                                        width: mediaQuery.size.width * 0.25,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(
                                                0.5,
                                                4,
                                              ),
                                              blurRadius: 2,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                          color: Colors.white.withOpacity(0.95),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Details",
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // SizedBox(width: 150,),
                                    Text(
                                      state.pendingList.pendingData[index]
                                          .orderStatus,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.green),
                                    )
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
        } else if (state is PendingErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        return Container();
      },
    ));
  }
}
