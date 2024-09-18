import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smailo/Dashboard/Orders%20Screen/Order%20Screen.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/cancel_orderdetail/bloc_cancell_orderdetail.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/cancel_orderdetail/event_orderdetail.dart';

class CancelOrderReason extends StatefulWidget {
  final String orderId;

  const CancelOrderReason({
    super.key,
    required this.orderId,
  });

  @override
  State<CancelOrderReason> createState() => _CancelOrderReasonState();
}

class _CancelOrderReasonState extends State<CancelOrderReason> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CancelledOrderDetailsBloc>(
      create: (context) => CancelledOrderDetailsBloc(),
      child: CancelOrderReasonPage(orderId: widget.orderId),
    );
  }
}

class CancelOrderReasonPage extends StatefulWidget {
  final String orderId;

  const CancelOrderReasonPage({
    super.key,
    required this.orderId,
  });

  @override
  State<CancelOrderReasonPage> createState() => _CancelOrderReasonPageState();
}

class _CancelOrderReasonPageState extends State<CancelOrderReasonPage> {
  String? reason;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text("Reason for cancellation",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            const SizedBox(
              height: 10,
            ),
            const Text(
                "Please the tell the correct for cancellation. this information is used to improve our service",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w300)),
            const Divider(
              color: Colors.black26,
              thickness: 1,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: "Select Reason ",
                      ),
                      TextSpan(text: "*", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
                // Divider(),

                RadioListTile(
                  title: const Text("Product Not Required"),
                  value: "Product Not Required",
                  groupValue: reason,
                  onChanged: (value) {
                    setState(() {
                      reason = value.toString();
                    });
                  },
                ),

                RadioListTile(
                  title: const Text("cash issue"),
                  value: "cash issue",
                  groupValue: reason,
                  onChanged: (value) {
                    setState(() {
                      reason = value.toString();
                    });
                  },
                ),

                RadioListTile(
                  title: const Text("order by mistake"),
                  value: "order by mistake",
                  groupValue: reason,
                  onChanged: (value) {
                    setState(() {
                      reason = value.toString();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.arrow_back_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                          Text("Cancel",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    print("reason${reason}");

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderScreen(),
                      ),
                    );
                    BlocProvider.of<CancelledOrderDetailsBloc>(context).add(
                      FetchCancelOrderDetailEvent(
                          cancelReason: reason!, orderId: widget.orderId),
                    );
                    print("orderId${widget.orderId}");
                    if (reason == null) {
                      Fluttertoast.showToast(
                          msg: "Please select the Reason",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      Fluttertoast.showToast(
                          msg: "${reason.toString()}",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text("OK",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),

      ),
    );
  }
}
