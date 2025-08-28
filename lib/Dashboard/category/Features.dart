import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/bloc_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/event_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/features/bloc_features.dart';
import 'package:smailo/Dashboard/home/bloc/features/event_features.dart';
import 'package:smailo/Dashboard/home/bloc/features/state_features.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/bloc_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/event_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/state_home_count.dart';
import '../home/Cart.dart';
import '../home/Detail Screen.dart';
import '../home/Favourite Screen.dart';

class FeaturesScreen extends StatefulWidget {
  const FeaturesScreen({super.key});

  @override
  State<FeaturesScreen> createState() => _FeaturesScreenState();
}

class _FeaturesScreenState extends State<FeaturesScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeaturesBloc>(
          create: (context) => FeaturesBloc(),
        ),
        BlocProvider<AddToCartBloc>(
          create: (context) => AddToCartBloc(),
        ),
        BlocProvider<HomeCountBloc>(
          create: (context) => HomeCountBloc(),
        )
      ],
      child: const Features(),
    );
  }
}

class Features extends StatefulWidget {
  const Features({super.key});

  @override
  State<Features> createState() => _FeaturesState();
}

class _FeaturesState extends State<Features> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCountBloc>(context).add(FetchHomeCountEvent());

    BlocProvider.of<FeaturesBloc>(context).add(FetchFeaturesEvent());
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Features",
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
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            )),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.blue, Colors.blue.shade900])),
        ),
        backgroundColor: Colors.white.withOpacity(0.95),
      ),
      body: BlocBuilder<FeaturesBloc, FeaturesState>(builder: (context, state) {
        if (state is FeaturesLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FeaturesLoadedState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller,
                      itemCount: state.featuresList.featuresListdata.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        String discount =
                            state.featuresList.featuresListdata[index].discount;
                        String discount_price = state
                            .featuresList.featuresListdata[index].discountPrice;

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                          productId: state.featuresList
                                              .featuresListdata[index].id
                                              .toString(),
                                        )));
                          },
                          child: Container(
                              height: 150,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
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
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10)),
                                  child: Image.network(
                                    state.featuresList.featuresListdata[index]
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
                                          state
                                              .featuresList
                                              .featuresListdata[index]
                                              .productName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500)),
                                      Text(
                                          state
                                              .featuresList
                                              .featuresListdata[index]
                                              .brandName,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black45)),
                                      SizedBox(
                                        height: mediaquery.size.height * 0.002,
                                      ),
                                      Text(
                                          discount == '0'
                                              ? ""
                                              : ('${state.featuresList.featuresListdata[index].discount}% off'),
                                          //text[index]['Discount'].toString(),
                                          style: const TextStyle(
                                              color: Colors.green)),
                                      SizedBox(
                                        height: mediaquery.size.height * 0.008,
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
                                                  discount_price == '0'
                                                      ? state
                                                          .featuresList
                                                          .featuresListdata[
                                                              index]
                                                          .price
                                                      : state
                                                          .featuresList
                                                          .featuresListdata[
                                                              index]
                                                          .discountPrice,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              SizedBox(
                                                width: mediaquery.size.width *
                                                    0.01,
                                              ),
                                              Text(
                                                discount_price == '0'
                                                    ? ""
                                                    : ('₹ ${state.featuresList.featuresListdata[index].price}'),
                                                style: const TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.red),
                                              )
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                final cart = state
                                                        .featuresList
                                                        .featuresListdata[index]
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
                                                            .featuresList
                                                            .featuresListdata[
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
                                                          .featuresList
                                                          .featuresListdata[
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
                                                        .featuresList
                                                        .featuresListdata[index]
                                                        .isCart = '0';
                                                  } else {
                                                    state
                                                        .featuresList
                                                        .featuresListdata[index]
                                                        .isCart = '1';
                                                  }
                                                });
                                              });
                                            },
                                            child: Icon(
                                              Icons.shopping_cart,
                                              color: state
                                                          .featuresList
                                                          .featuresListdata[
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
                              ])),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        } else if (state is FeaturesErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        return Container();
      }),
    );
  }
}
