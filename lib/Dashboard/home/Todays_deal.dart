import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/Cart.dart';
import 'package:smailo/Dashboard/home/Detail%20Screen.dart';
import 'package:smailo/Dashboard/home/Favourite%20Screen.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/bloc_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/event_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/bloc_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/event_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/state_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/today_deal/event_today_deal.dart';
import 'package:smailo/Dashboard/home/bloc/today_deal/state_today_deal.dart';
import 'bloc/today_deal/bloc_today_deal.dart';

class TodayDeal extends StatefulWidget {
  const TodayDeal({super.key});

  @override
  State<TodayDeal> createState() => _TodayDealState();
}

class _TodayDealState extends State<TodayDeal> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodayDealBloc>(
          create: (context) => TodayDealBloc(),
        ),
        BlocProvider<AddToCartBloc>(
          create: (context) => AddToCartBloc(),
        ),
        BlocProvider<HomeCountBloc>(
          create: (context) => HomeCountBloc(),
        )
      ],
      child: const TodayDealPage(),
    );
  }
}

class TodayDealPage extends StatefulWidget {
  const TodayDealPage({super.key});

  @override
  State<TodayDealPage> createState() => _TodayDealPageState();
}

class _TodayDealPageState extends State<TodayDealPage> {
  ScrollController Controller = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCountBloc>(context).add(FetchHomeCountEvent());

    BlocProvider.of<TodayDealBloc>(context).add(FetchTodayDealEvent());
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
                    colors: <Color>[Colors.blue, Colors.blue.shade900])),
          ),
          title: Text("Today's Deal",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
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
                                        state.homeCountlist.countData
                                            .favoriteCount
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
                            visible:
                                state.homeCountlist.countData.cartCount != 0,
                            child: Positioned(
                              top: 6,
                              right: 8,
                              child: Container(
                                  height: mediaquery.size.height * 0.02,
                                  width: mediaquery.size.width * 0.04,
                                  child: Center(
                                      child: Text(
                                          state
                                              .homeCountlist.countData.cartCount
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12))),
                                  decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50)))),
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
          ],
        ),
        backgroundColor: Colors.white.withOpacity(0.95),
        body: BlocBuilder<TodayDealBloc, TodayDealState>(
            builder: (context, state) {
          if (state is TodayDealLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodayDealLoadedState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: GridView.builder(
                          controller: Controller,
                          scrollDirection: Axis.vertical,
                          itemCount: state.todayDeal.todayDealData.length,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.67,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15),
                          itemBuilder: (context, index) {
                            String ontype = state
                                .todayDeal.todayDealData[index].discountPrice;
                            String productdiscount =
                                state.todayDeal.todayDealData[index].discount;

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                        productId: state
                                            .todayDeal.todayDealData[index].id
                                            .toString()),
                                  ),
                                );
                              },
                              child: Container(
                                height: 150,
                                width: 150,
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
                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            topLeft: Radius.circular(10)),
                                        child: Image.network(
                                          state.todayDeal.todayDealData[index]
                                              .productImage,
                                          // Product[index]['image'],
                                          fit: BoxFit.fill,
                                          width: double.infinity,
                                          height: 150,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 3),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.todayDeal.todayDealData[index]
                                                .productName,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            state.todayDeal.todayDealData[index]
                                                .brandName,
                                            // Product[index]['text'],
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black45,
                                            ),
                                          ),
                                          SizedBox(
                                              height: mediaquery.size.height *
                                                  0.01),
                                          Text(
                                              productdiscount == '0'
                                                  ? " "
                                                  : ('${state.todayDeal.todayDealData[index].discount}% off'),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w400)),
                                          SizedBox(
                                              height: mediaquery.size.height *
                                                  0.01),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.currency_rupee,
                                                      size: 15,
                                                      color: Colors.blue),
                                                  Text(
                                                    ontype == '0'
                                                        ? state
                                                            .todayDeal
                                                            .todayDealData[
                                                                index]
                                                            .price
                                                        : state
                                                            .todayDeal
                                                            .todayDealData[
                                                                index]
                                                            .discountPrice,
                                                    // Product[index]['rupees'],
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                      width: mediaquery
                                                              .size.width *
                                                          0.02),
                                                  Text(
                                                    ontype == '0'
                                                        ? " "
                                                        : ('₹ ${state.todayDeal.todayDealData[index].price}'),
                                                    // Product[index]['off price']
                                                    //     .toString(),
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red),
                                                  ),
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  final cart = state
                                                          .todayDeal
                                                          .todayDealData[index]
                                                          .isCart ==
                                                      '1';
                                                  if (cart) {
                                                    print("remove");
                                                    BlocProvider.of<
                                                                AddToCartBloc>(
                                                            context)
                                                        .add(
                                                      FetchRemoveToCartEvent(
                                                        productId: state
                                                            .todayDeal
                                                            .todayDealData[
                                                                index]
                                                            .id
                                                            .toString(),
                                                      ),
                                                    );
                                                  } else {
                                                    print("add");

                                                    BlocProvider.of<
                                                                AddToCartBloc>(
                                                            context)
                                                        .add(
                                                      FetchAddToCartEvent(
                                                        productId: state
                                                            .todayDeal
                                                            .todayDealData[
                                                                index]
                                                            .id
                                                            .toString(),
                                                        quantity: '1',
                                                      ),
                                                    );
                                                  }
                                                  setState(() {
                                                    if (cart) {
                                                      state
                                                          .todayDeal
                                                          .todayDealData[index]
                                                          .isCart = '0';
                                                    } else {
                                                      state
                                                          .todayDeal
                                                          .todayDealData[index]
                                                          .isCart = '1';
                                                    }
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.shopping_cart,
                                                  color: state
                                                              .todayDeal
                                                              .todayDealData[
                                                                  index]
                                                              .isCart ==
                                                          '1'
                                                      ? Colors.blue
                                                      : Colors.black45,
                                                  size: 25,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (state is TodayDealErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        }));
  }
}
