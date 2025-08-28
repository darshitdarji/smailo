import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/Cart.dart';
import 'package:smailo/Dashboard/home/Favourite%20Screen.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/bloc_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/event_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/state_home_count.dart';
import 'package:smailo/Dashboard/offers/bloc/bloc_offers.dart';
import 'package:smailo/Dashboard/offers/bloc/event_offers.dart';
import 'package:smailo/Dashboard/offers/bloc/state_offers.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OfferBloc>(
          create: (context) => OfferBloc(),
        ),
        BlocProvider<HomeCountBloc>(
          create: (context) => HomeCountBloc(),
        )
      ],
      child: const OfferPage(),
    );
  }
}

class OfferPage extends StatefulWidget {
  const OfferPage({super.key});

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  String couponcode = "HRKS20";

  @override
  void initState() {
    super.initState();
    BlocProvider.of<OfferBloc>(context).add(FetchOfferEvent());
    BlocProvider.of<HomeCountBloc>(context).add(FetchHomeCountEvent());
  }

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
                  colors: <Color>[Colors.blue, Colors.blue.shade800])),
        ),
        title: const Text("Offers",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25)),
        actions: [
          BlocBuilder<HomeCountBloc, HomeCountState>(
            builder: (context, state) {
              if (state is HomeCountLoadedState) {
                return Row(
                  children: [
                    Stack(alignment: Alignment.topRight, children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const FavouriteScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      Visibility(
                        visible:
                            state.homeCountlist.countData.favoriteCount != 0,
                        child: Positioned(
                          top: 6,
                          right: 8,
                          child: Container(
                              height: mediaquery.size.height * 0.02,
                              width: mediaquery.size.width * 0.04,
                              child: Center(
                                child: Text(
                                  state.homeCountlist.countData.favoriteCount
                                      .toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              decoration: const BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)))),
                        ),
                      )
                    ]),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const CartScreen(),
                              ));
                            },
                            icon: const Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                              size: 25,
                            )),
                        Visibility(
                          visible: state.homeCountlist.countData.cartCount != 0,
                          child: Positioned(
                            top: 6,
                            right: 8,
                            child: Container(
                              height: mediaquery.size.height * 0.02,
                              width: mediaquery.size.width * 0.04,
                              child: Center(
                                child: Text(
                                  state.homeCountlist.countData.cartCount
                                      .toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                );
              } else if (state is HomeCountErrorState) {
                return Center(
                  child: Text(state.error),
                );
              }
              return Container();
            },
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      backgroundColor: Colors.white.withOpacity(0.95),
      body: BlocBuilder<OfferBloc, OfferState>(
        builder: (context, state) {
          if (state is OfferLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is OfferLoadedState) {
            if (state.offerList.offerData.isEmpty) {
              return Center(
                child: Text(
                  "Offer Are  Not Available",
                  style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        height: mediaquery.size.height * 0.13,
                        width: mediaquery.size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(
                                  1,
                                  4,
                                ),
                                blurRadius: 2,
                                spreadRadius: 1,
                              ), //BoxShadow
                            ],
                            borderRadius: BorderRadius.circular(10)),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.offerList.offerData.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Coupon Codde:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            state.offerList.offerData[index]
                                                .offerCode,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: mediaquery.size.width * 0.2,
                                        height: mediaquery.size.height * 0.04,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.blue),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: GestureDetector(
                                          onTap: copyToClipboard,
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(
                                                Icons.copy,
                                                color: Colors.blue,
                                                size: 15,
                                              ),
                                              Text("Copy",
                                                  style: TextStyle(
                                                      color: Colors.blue)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: mediaquery.size.height * 0.02,
                                  ),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Category: ",
                                              style: TextStyle(
                                                  color: Colors.black26,
                                                  fontSize: 13)),
                                          Text(
                                            "All",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Discount:",
                                            style: TextStyle(
                                                color: Colors.black26,
                                                fontSize: 13),
                                          ),
                                          Text(
                                            "15%",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: mediaquery.size.height * 0.01,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              "Valid from:",
                                              style: TextStyle(
                                                  color: Colors.black26,
                                                  fontSize: 13),
                                            ),
                                            Text(
                                              state.offerList.offerData[index]
                                                  .startDate,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Valid to:",
                                              style: TextStyle(
                                                  color: Colors.black26,
                                                  fontSize: 13),
                                            ),
                                            Text(
                                              state.offerList.offerData[index]
                                                  .endDate,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      ])
                                ],
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
          } else if (state is OfferErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
    );
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: couponcode));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('copy to couponcode'),
      ),
    );
  }
}
