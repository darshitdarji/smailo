import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/Orders%20Screen/Cancel_order_detailscreen.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/cancelled/bloc_cancelled.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/cancelled/event_cancellled.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/cancelled/state_cancelled.dart';

class Cancelled extends StatefulWidget {
  const Cancelled({super.key});

  @override
  State<Cancelled> createState() => _CancelledState();
}

class _CancelledState extends State<Cancelled> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CancelledBloc>(
      create: (context) => CancelledBloc(),
      child: const CancelledPage(),
    );
  }
}

class CancelledPage extends StatefulWidget {
  const CancelledPage({super.key});

  @override
  State<CancelledPage> createState() => _CancelledPageState();
}

class _CancelledPageState extends State<CancelledPage> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CancelledBloc>(context).add(FetchCancelledEvent());
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);

    return Scaffold(
      body: BlocBuilder<CancelledBloc, CancelledState>(
        builder: (context, state) {
          if (state is CancelledLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CancelledLoadedState) {
            if (state.cancelledList.cancelledData.isEmpty) {
              return const Center(
                child: Text(
                  "Cancell Order Are Not Available",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black45,
                  ),
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          // physics: const AlwaysScrollableScrollPhysics(),
                          controller: controller,
                          itemCount: state.cancelledList.cancelledData.length,
                          itemBuilder: (BuildContext context, int index) {
                            print(
                                "object${state.cancelledList.cancelledData.length}");
                            return SingleChildScrollView(
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                height: mediaquery.size.height * 0.16,
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
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Text("Order:"),
                                              Text(
                                                state
                                                    .cancelledList
                                                    .cancelledData[index]
                                                    .orderNo,
                                                style: const TextStyle(
                                                  color: Colors.black38,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            state.cancelledList
                                                .cancelledData[index].orderDate,
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w500,
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
                                              const Text("Quantity:  "),
                                              Text(
                                                state
                                                    .cancelledList
                                                    .cancelledData[index]
                                                    .totalQuantity
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black38,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text('Total Amount:  '),
                                              Text(
                                                state
                                                    .cancelledList
                                                    .cancelledData[index]
                                                    .totalAmount,
                                                style: const TextStyle(
                                                  color: Colors.blue,
                                                ),
                                              ),
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
                                                      CancelOderDetail(
                                                    orderId: state.cancelledList
                                                        .cancelledData[index].id
                                                        .toString(),
                                                    orderIdEncrypt: state
                                                        .cancelledList
                                                        .cancelledData[index]
                                                        .orderIdEncrypt,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height:
                                                  mediaquery.size.height * 0.04,
                                              width:
                                                  mediaquery.size.width * 0.2,
                                              child: const Center(
                                                child: Text(
                                                  "Details",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: const [
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
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            state
                                                .cancelledList
                                                .cancelledData[index]
                                                .orderStatus,
                                            style: const TextStyle(
                                              color: Colors.green,
                                            ),
                                          )
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
                    ),
                  ],
                ),
              );
            }
          } else if (state is CancelledErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
    );
  }
}
