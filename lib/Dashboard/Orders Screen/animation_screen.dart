import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smailo/Dashboard/Orders%20Screen/pending_orderdetail_screen.dart';
import 'package:smailo/Dashboard/home/bloc/checkout/bloc_checkout.dart';
import 'package:smailo/Dashboard/home/bloc/checkout/event_checkout.dart';
import 'package:smailo/Dashboard/home/bloc/checkout/state_checkout.dart';

class AnimationScreen extends StatefulWidget {
  final String totalMrp;
  final String coupon;
  final String discountMrp;
  final String orderTotal;
  const AnimationScreen({
    super.key, required this.totalMrp, required this.coupon, required this.discountMrp, required this.orderTotal,
  });

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CheckoutBloc>(create: (context) => CheckoutBloc()),
      ],
      child: AnimationPage(totalMrp: widget.totalMrp, coupon: widget.coupon, discountMrp: widget.discountMrp, orderTotal:widget.orderTotal,),
    );
  }
}

class AnimationPage extends StatefulWidget {
  final String totalMrp;
  final String coupon;
  final String discountMrp;
  final String orderTotal;
  const AnimationPage({
    Key? key, required this.totalMrp, required this.coupon, required this.discountMrp, required this.orderTotal,
  });

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 0),
    );

    BlocProvider.of<CheckoutBloc>(context).add(FetchCheckoutEvent(
      totalDiscount: widget.discountMrp,
      paymentType: '1',
      transactionId: '',
      offerDiscount: widget.coupon,
      couPonId: '0',
      totalAmount: widget.totalMrp,
      UserAddressId: 'Madhavbaug Vidhyabhavan, New Kosad Road, Amroli 394107',
    ));
    controller.forward();
    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        final state = BlocProvider.of<CheckoutBloc>(context).state;
        if (state is CheckoutLoadedState) {
          timer = Timer(Duration(seconds:2), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PendingOrderDetail(
                  orderId: state.checkoutList.checkoutData.id.toString(),
                  orderIdEncrypt: state.checkoutList.checkoutData.orderIdEncrypt,
                ),
              ),
            );
          });
        }
        controller.reset();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          return Center(
            child: Lottie.asset('assets/Animation - 1708666967814.json',
                animate: true),
          );
        },
      ),
    );
  }
}
