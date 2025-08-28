import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/Detail%20Screen.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/bloc_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/event_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/all_products/bloc_all_products.dart';
import 'package:smailo/Dashboard/home/bloc/all_products/event_all_products.dart';
import 'package:smailo/Dashboard/home/bloc/all_products/state_all_products.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/bloc_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/event_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/state_home_count.dart';
import '../home/Cart.dart';
import '../home/Favourite Screen.dart';
import 'Filterdailog Box.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    super.key,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AllProductsBloc>(
          create: (context) => AllProductsBloc(),
        ),
        BlocProvider<AddToCartBloc>(
          create: (context) => AddToCartBloc(),
        ),
        BlocProvider<HomeCountBloc>(
          create: (context) => HomeCountBloc(),
        )
      ],
      child: Product(),
    );
  }
}

class Product extends StatefulWidget {
  const Product({
    super.key,
  });

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HomeCountBloc>(context).add(FetchHomeCountEvent());

    BlocProvider.of<AllProductsBloc>(context).add(
      FetchAllProductEvent(
        filterPrice: '',
        filterShortBy: '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Product",
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
        ],
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            )),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Colors.blue, Colors.blue.shade900],
            ),
          ),
        ),
        backgroundColor: Colors.white.withOpacity(0.95),
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<AllProductsBloc, AllProductsState>(
        builder: (context, state) {
          if (state is AllProductsLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AllProductsLoadedState) {
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.filter_alt_outlined,
                          color: Colors.blue,
                          size: 25,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              barrierColor: Colors.black12,
                              context: context,
                              builder: (context) {
                                return filterdailogbox();
                              },
                            ).then(
                              (value) {
                                if (value != null) {
                                  BlocProvider.of<AllProductsBloc>(context).add(
                                    FetchAllProductEvent(
                                      filterShortBy: value[1],
                                      filterPrice: value[0],
                                    ),
                                  );
                                }
                              },
                            );
                          },
                          child: Text(
                            "Filter",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller,
                    itemCount: state.allProductsList.allProductsData.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.72,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      String discount =
                          state.allProductsList.allProductsData[index].discount;
                      String discounprice = state
                          .allProductsList.allProductsData[index].discountPrice;

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                productId: state
                                    .allProductsList.allProductsData[index].id
                                    .toString(),
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15),
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
                                    state.allProductsList.allProductsData[index]
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
                                        state.allProductsList
                                            .allProductsData[index].productName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        state.allProductsList
                                            .allProductsData[index].brandName,
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
                                            : ("${state.allProductsList.allProductsData[index].discount}% off"),
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
                                                discounprice == '0'
                                                    ? state
                                                        .allProductsList
                                                        .allProductsData[index]
                                                        .price
                                                    : ("${state.allProductsList.allProductsData[index].discountPrice}"),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                width: mediaquery.size.width *
                                                    0.015,
                                              ),
                                              Text(
                                                discounprice == '0'
                                                    ? " "
                                                    : ("₹${state.allProductsList.allProductsData[index].price}"),
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
                                                      .allProductsList
                                                      .allProductsData[index]
                                                      .isCart ==
                                                  '1';
                                              if (cart) {
                                                print("remove");

                                                BlocProvider.of<AddToCartBloc>(
                                                        context)
                                                    .add(
                                                  FetchRemoveToCartEvent(
                                                      productId: state
                                                          .allProductsList
                                                          .allProductsData[
                                                              index]
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
                                                        .allProductsList
                                                        .allProductsData[index]
                                                        .id
                                                        .toString(),
                                                    quantity: '1',
                                                  ),
                                                );
                                              }
                                              setState(() {
                                                if (cart) {
                                                  state
                                                      .allProductsList
                                                      .allProductsData[index]
                                                      .isCart = '0';
                                                } else {
                                                  state
                                                      .allProductsList
                                                      .allProductsData[index]
                                                      .isCart = '1';
                                                }
                                              });
                                            },
                                            child: Icon(
                                              Icons.shopping_cart,
                                              color: state
                                                          .allProductsList
                                                          .allProductsData[
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
                        ),
                      );
                    },
                  ),
                )),
              ],
            );
          } else if (state is AllProductsErrorState) {
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
