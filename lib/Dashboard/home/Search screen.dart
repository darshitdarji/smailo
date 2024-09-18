import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/Detail%20Screen.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/bloc_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/event_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/cartscreen/bloc_cart_sccreen.dart';
import 'package:smailo/Dashboard/home/bloc/cartscreen/event_cart_screen.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/bloc_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/event_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/state_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/serach_screen/bloc_search_screen.dart';
import 'package:smailo/Dashboard/home/bloc/serach_screen/event_search_screen.dart';
import 'package:smailo/Dashboard/home/bloc/serach_screen/state_search_screen.dart';

import 'Cart.dart';
import 'Favourite Screen.dart';

class SearchScreeen extends StatefulWidget {
  final String keyword;

  SearchScreeen({
    super.key,
    required this.keyword,
  });

  @override
  State<SearchScreeen> createState() => _SearchScreeenState();
}

class _SearchScreeenState extends State<SearchScreeen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
        ),
        BlocProvider<AddToCartBloc>(
          create: (context) => AddToCartBloc(),
        ),
        BlocProvider<HomeCountBloc>(
          create: (context) => HomeCountBloc(),
        )
      ],
      child: Search_Page(keyword: widget.keyword),
    );
  }
}

class Search_Page extends StatefulWidget {
  final String keyword;

  const Search_Page({
    super.key,
    required this.keyword,
  });

  @override
  State<Search_Page> createState() => _Search_PageState();
}

class _Search_PageState extends State<Search_Page> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchBloc>(context).add(
      FetchSearchEvent(keyword: widget.keyword),

    );
    BlocProvider.of<HomeCountBloc>(context).add(FetchHomeCountEvent());


  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search",
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
      backgroundColor: Colors.white,
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SearchLoadedState) {
            return Column(
              children: [
                SizedBox(height: mediaquery.size.height * 0.015),
                Text(
                  "Showing Result For '${widget.keyword}'",
                  style: TextStyle(
                    color: Colors.black26,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: mediaquery.size.height*0.01),
                Expanded(
                  child: SingleChildScrollView(
                    child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        controller: controller,
                        itemCount: state.searchList.searchData.searchDataList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          childAspectRatio: 0.72,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          if (index <
                              state.searchList.searchData.searchDataList.length) {
                          } else {
                            return SizedBox(); // Return an empty widget if index is out of bounds
                          }
                          String discount = state
                              .searchList.searchData.searchDataList[index].discount;
                          String discountprice = state.searchList.searchData
                              .searchDataList[index].discountPrice;

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    productId: state.searchList.searchData
                                        .searchDataList[index].id
                                        .toString(),
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
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
                                        state.searchList.searchData
                                            .searchDataList[index].productImage,
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
                                            state.searchList.searchData
                                                .searchDataList[index].productName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(),
                                          ),
                                          Text(
                                            state.searchList.searchData
                                                .searchDataList[index].brandName,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black45,
                                            ),
                                          ),
                                          SizedBox(
                                            height: mediaquery.size.height * 0.002,
                                          ),
                                          Text(
                                            discount == '0'
                                                ? ""
                                                : ("${state.searchList.searchData.searchDataList[index].discount}% off"),
                                            style: const TextStyle(
                                              color: Colors.green,
                                            ),
                                          ),
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
                                                    discountprice == '0'
                                                        ? state
                                                            .searchList
                                                            .searchData
                                                            .searchDataList[index]
                                                            .price
                                                        : ("${state.searchList.searchData.searchDataList[index].discountPrice}"),
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
                                                    discountprice == '0'
                                                        ? " "
                                                        : ("₹${state.searchList.searchData.searchDataList[index].price}"),
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
                                                  final cart = state
                                                          .searchList
                                                          .searchData
                                                          .searchDataList[index]
                                                          .isCart ==
                                                      '1';
                                                  if (cart) {
                                                    print("remove");

                                                    BlocProvider.of<AddToCartBloc>(
                                                            context)
                                                        .add(
                                                      FetchRemoveToCartEvent(
                                                          productId: state
                                                              .searchList
                                                              .searchData
                                                              .searchDataList[index]
                                                              .id
                                                              .toString()),
                                                    );
                                                  } else {
                                                    print("add");

                                                    BlocProvider.of<AddToCartBloc>(
                                                            context)
                                                        .add(
                                                      FetchAddToCartEvent(
                                                        productId: state
                                                            .searchList
                                                            .searchData
                                                            .searchDataList[index]
                                                            .id
                                                            .toString(),
                                                        quantity: '1',
                                                      ),
                                                    );
                                                  }
                                                  setState(() {
                                                    if (cart) {
                                                      state
                                                              .searchList
                                                              .searchData
                                                              .searchDataList[index]
                                                              .isCart =
                                                          '0';
                                                    } else {
                                                      state
                                                              .searchList
                                                              .searchData
                                                              .searchDataList[index]
                                                              .isCart =
                                                          '1';
                                                    }
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.shopping_cart,
                                                  color: state
                                                              .searchList
                                                              .searchData
                                                              .searchDataList[index]
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
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            );
          } else if (state is SearchErrorState) {
            return Column(
              children: [
                SizedBox(
                  height: mediaquery.size.height * 0.02,
                ),
                Text(
                  "Showing Result For '${widget.keyword}'",
                  style: TextStyle(
                    color: Colors.black26,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Image(
                    image: AssetImage(
                      "assets/img_30.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  "No result found",
                  style: TextStyle(
                    color: Colors.black26,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Text(
                  "We Couldn't find what you search for\n try searching again",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black26,
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
