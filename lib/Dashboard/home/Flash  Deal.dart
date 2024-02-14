import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/Profile%20Screen/Cart.dart';
import 'package:smailo/Dashboard/home/Favourite%20Screen.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/bloc_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/event_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/flash_deal/bloc_flash_deal.dart';
import 'package:smailo/Dashboard/home/bloc/flash_deal/event_flash_deal.dart';
import 'package:smailo/Dashboard/home/bloc/flash_deal/state_flash_deal.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/bloc_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/state_home_count.dart';

import '../Dashboard.dart';
import 'Detail Screen.dart';
import 'bloc/home_count/event_home_count.dart';

class FlashDealScreen extends StatefulWidget {
  const FlashDealScreen({super.key});

  @override
  State<FlashDealScreen> createState() => _FlashDealScreenState();
}

class _FlashDealScreenState extends State<FlashDealScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FlashDealBloc>(
          create: (context) => FlashDealBloc(),
        ),
        BlocProvider<AddToCartBloc>(
          create: (context) => AddToCartBloc(),
        ),
        BlocProvider<HomeCountBloc>(
          create: (context) => HomeCountBloc(),
        ),
      ],
      child: FlashDeal(),
    );
  }
}

class FlashDeal extends StatefulWidget {
  FlashDeal({super.key});

  @override
  State<FlashDeal> createState() => _FlashDealState();
}

class _FlashDealState extends State<FlashDeal> {
  ScrollController Controller = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCountBloc>(context).add(
      FetchHomeCountEvent(),
    );
    BlocProvider.of<FlashDealBloc>(context).add(
      FetchFlashDealEvent(),
    );
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
                Colors.blue.shade900,
              ],
            ),
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => Dashboard(),
              ),
            );
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Flash Deal",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            // fontSize: 20,
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
        ],
      ),
      body: BlocBuilder<FlashDealBloc, FlashDealState>(
        builder: (context, state) {
          if (state is FlashDealLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FlashDealLoadedState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        // controller: controller,
                        itemCount: state.flashDealModel.flashDealData.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          String discount = state
                              .flashDealModel.flashDealData[index].discount;
                          String discounprice = state.flashDealModel
                              .flashDealData[index].discountPrice;

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    productId: state
                                        .flashDealModel.flashDealData[index].id
                                        .toString(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 150,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  const BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(
                                      1,
                                      6,
                                    ),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                    ),
                                    child: Image.network(
                                      state.flashDealModel.flashDealData[index]
                                          .productImage,
                                      fit: BoxFit.fill,
                                      height: 140,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.flashDealModel
                                              .flashDealData[index].productName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(),
                                        ),
                                        Text(
                                          state.flashDealModel
                                              .flashDealData[index].brandName,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black45,
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              mediaquery.size.height * 0.002,
                                        ),
                                        Text(
                                          discount == '0'
                                              ? ""
                                              : ("${state.flashDealModel.flashDealData[index].discount}% off"),
                                          style: const TextStyle(
                                            color: Colors.green,
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              mediaquery.size.height * 0.008,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.currency_rupee,
                                                  color: Colors.blue,
                                                  size: 16,
                                                ),
                                                Text(
                                                  discounprice == '0'
                                                      ? state
                                                          .flashDealModel
                                                          .flashDealData[index]
                                                          .price
                                                      : ("${state.flashDealModel.flashDealData[index].discountPrice}"),
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: mediaquery.size.width *
                                                      0.015,
                                                ),
                                                Text(
                                                  discounprice == '0'
                                                      ? " "
                                                      : ("₹${state.flashDealModel.flashDealData[index].price}"),
                                                  style: const TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  final cart = state
                                                      .flashDealModel
                                                      .flashDealData[
                                                  index]
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
                                                              .flashDealModel
                                                              .flashDealData[
                                                          index]
                                                              .id
                                                              .toString()),
                                                    );
                                                  } else {
                                                    print("add");
                                                    BlocProvider.of<
                                                        AddToCartBloc>(
                                                        context)
                                                        .add(
                                                      FetchAddToCartEvent(
                                                        productId: state
                                                            .flashDealModel
                                                            .flashDealData[
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
                                                          .flashDealModel
                                                          .flashDealData[
                                                      index]
                                                          .isCart = '0';
                                                    } else {
                                                      state
                                                          .flashDealModel
                                                          .flashDealData[
                                                      index]
                                                          .isCart = '1';
                                                    }
                                                  });
                                                });
                                              },
                                              child: Icon(
                                                Icons.shopping_cart,
                                                color: state
                                                    .flashDealModel
                                                    .flashDealData[
                                                index]
                                                    .isCart ==
                                                    '1'
                                                    ? Colors.blue
                                                    : Colors.black45,
                                                size: 25,
                                              ),
                                            ),
                                          ],
                                        )
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
                  ),
                ],
              ),
            );
          } else if (state is FlashDealErrorState) {
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
