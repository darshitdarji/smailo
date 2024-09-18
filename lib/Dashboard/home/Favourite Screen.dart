import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/Detail%20Screen.dart';
import 'package:smailo/Dashboard/home/FavouriteBttomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/bloc_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/favourite/event_favourite.dart';
import 'package:smailo/Dashboard/home/bloc/favourite/state_favourite.dart';
import 'bloc/favourite/bloc_favourite.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavouriteBloc>(
          create: (context) => FavouriteBloc(),
        ),
        BlocProvider<AddToCartBloc>(
          create: (context) => AddToCartBloc(),
        )
      ],
      child: const FavouritePage(),
    );
  }
}

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  var increment = 1;

  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<FavouriteBloc>(context).add(FetchFavouriteEvent());
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favourite",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
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
      ),
      body: BlocBuilder<FavouriteBloc, FavouriteState>(
        builder: (context, state) {
          if (state is FavouriteLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FavouriteLoadedState) {
            if (state.favouriteList.favouriteData.isEmpty) {
              return const Center(
                child: Text(
                  "Data Not Found",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black45,
                  ),
                ),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(10),
                      shrinkWrap: true,
                      controller: controller,
                      itemCount: state.favouriteList.favouriteData.length,
                      itemBuilder: (BuildContext context, int index) {
                        String discount = state.favouriteList
                            .favouriteData[index].productData.discount;
                        String discountprice = state.favouriteList
                            .favouriteData[index].productData.discountPrice;
                        return Dismissible(
                          direction: DismissDirection.startToEnd,
                          background: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.centerLeft,
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          confirmDismiss: (direction) async {
                            await showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return FavouriteBottomSheet(
                                    image: state
                                        .favouriteList
                                        .favouriteData[index]
                                        .productData
                                        .productImage,
                                    name: state
                                        .favouriteList
                                        .favouriteData[index]
                                        .productData
                                        .productName,
                                    wishId: state.favouriteList
                                        .favouriteData[index].id
                                        .toString(),
                                  );
                                }).then((value) {
                              if (value == true) {
                                BlocProvider.of<FavouriteBloc>(context)
                                    .add(FetchFavouriteEvent());
                              }
                            });
                            return null;
                          },
                          key: Key(state.favouriteList.favouriteData[index].id
                              .toString()),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      productId: state.favouriteList
                                          .favouriteData[index].productId
                                          .toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
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
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 5),
                                                  decoration: BoxDecoration(
                                                    // color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(0),
                                                  ),
                                                  height: mediaquery.size.height *
                                                      0.13,
                                                  width: mediaquery.size.width *
                                                      0.22,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: Image.network(
                                                        state
                                                            .favouriteList
                                                            .favouriteData[index]
                                                            .productData
                                                            .productImage,
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: mediaquery.size.width *
                                                      0.015,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        state
                                                            .favouriteList
                                                            .favouriteData[index]
                                                            .productData
                                                            .productName,overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        state
                                                            .favouriteList
                                                            .favouriteData[index]
                                                            .productData
                                                            .brandName,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black45,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            mediaquery.size.height *
                                                                0.008,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.currency_rupee,
                                                            size: 15,
                                                            color: Colors.blue,
                                                          ),
                                                          Text(
                                                            discountprice == '0'
                                                                ? state
                                                                    .favouriteList
                                                                    .favouriteData[
                                                                        index]
                                                                    .productData
                                                                    .price
                                                                : ("${state.favouriteList.favouriteData[index].productData.discountPrice}"),
                                                            style: const TextStyle(
                                                                color: Colors.blue),
                                                          ),
                                                          SizedBox(
                                                            width: mediaquery
                                                                    .size.width *
                                                                0.02,
                                                          ),
                                                          Text(
                                                            discountprice == '0'
                                                                ? ""
                                                                : ('₹${state.favouriteList.favouriteData[index].productData.price}'),
                                                            style: const TextStyle(
                                                              color: Colors.red,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: mediaquery
                                                                    .size.width *
                                                                0.02,
                                                          ),
                                                          Text(
                                                            discount == '0'
                                                                ? ""
                                                                : ("${state.favouriteList.favouriteData[index].productData.discount}% off"),
                                                            style: const TextStyle(
                                                              color: Colors.green,
                                                              fontSize: 13,
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
                                          GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return FavouriteBottomSheet(
                                                    image: state
                                                        .favouriteList
                                                        .favouriteData[index]
                                                        .productData
                                                        .productImage,
                                                    name: state
                                                        .favouriteList
                                                        .favouriteData[index]
                                                        .productData
                                                        .productName,
                                                    wishId: state
                                                        .favouriteList
                                                        .favouriteData[index]
                                                        .id
                                                        .toString(),
                                                  );
                                                },
                                              );
                                            },
                                            child: const Icon(
                                              Icons.close,
                                              size: 25,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          } else if (state is FavouriteErrorState) {
            return Center(
              child: Text(
                "Data Not Found",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black45,
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
