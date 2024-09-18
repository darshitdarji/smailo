import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/Orders%20Screen/Tabbar%20screens/Cancelled.dart';
import 'package:smailo/Dashboard/Orders%20Screen/Tabbar%20screens/Confomrmed.dart';
import 'package:smailo/Dashboard/Orders%20Screen/Tabbar%20screens/Panding.dart';
import 'package:smailo/Dashboard/home/Cart.dart';
import 'package:smailo/Dashboard/home/Favourite%20Screen.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/bloc_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/event_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/state_home_count.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
    BlocProvider<HomeCountBloc>(
    create: (context) => HomeCountBloc(),
    ),
      BlocProvider<HomeCountBloc>(
        create: (context) => HomeCountBloc(),
      )
    ],child: OrderPage(),);
  }
}

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<Tab> tabbar = [
    const Tab(
      text: "Pending",
    ),
    const Tab(
      text: "Confirmed",
    ),
    const Tab(
      text: "Cancelled",
    )
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              colors: <Color>[
                Colors.blue,
                Colors.blue.shade800,
              ],
            ),
          ),
        ),
        title: const Text(
          "Order",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
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
                        icon: Icon(
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
                                      state
                                          .homeCountlist.countData.favoriteCount
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
                              decoration: BoxDecoration(
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
                                builder: (context) => CartScreen(),
                              ));
                            },
                            icon: Icon(
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
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12))),
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(50)))),
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
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              child: TabBar(
                dividerColor: Colors.white,
                labelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: const BubbleTabIndicator(
                  padding: EdgeInsets.only(
                    left: 0.5,
                    right: 0.5,
                  ),
                  indicatorColor: Color.fromRGBO(
                    36,
                    198,
                    220,
                    1,
                  ),
                  indicatorHeight: 30,
                  tabBarIndicatorSize: TabBarIndicatorSize.label,
                ),
                tabs: tabbar,
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelColor: Colors.black,
                padding: const EdgeInsets.all(10),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  Pending(),
                  ConformedPage(),
                  Cancelled(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
