import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smailo/Dashboard/home/Cart.dart';
import 'package:smailo/Dashboard/home/Detail%20Screen.dart';
import 'package:smailo/Dashboard/home/Favourite%20Screen.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/bloc_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/event_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/flash_deal/event_flash_deal.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/bloc_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/event_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/state_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/product_add/bloc_product_add.dart';
import 'package:smailo/Dashboard/home/bloc/product_add/event_product_add.dart';
import 'package:smailo/Dashboard/home/bloc/product_add/state_product_add.dart';

class ProductAddScreen extends StatefulWidget {
  final String standardId;

  const ProductAddScreen({super.key, required this.standardId});

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ProductAddBloc>(
            create: (context) => ProductAddBloc(),
          ),
          BlocProvider<AddToCartBloc>(
            create: (context) => AddToCartBloc(),
          ),
          BlocProvider(
            create: (context) => HomeCountBloc(),
          ),
        ],
        child: ProductAddPage(
          standardId: widget.standardId,
        ));
  }
}

class ProductAddPage extends StatefulWidget {
  final String standardId;

  const ProductAddPage({super.key, required this.standardId});

  @override
  State<ProductAddPage> createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCountBloc>(context).add(FetchHomeCountEvent());
    BlocProvider.of<ProductAddBloc>(context).add(
      FetchProductAdd(standardId: widget.standardId),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text("Product",
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
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.blue, Colors.blue.shade900])),
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<ProductAddBloc, ProductAddState>(
        builder: (context, state) {
          if (state is ProductAddLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductAddLoadedState) {
            if (state.productList.productData.isEmpty) {
              return Center(
                child: Text(
                  'No Data Found..',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                      fontSize: 22),
                ),
              );
            } else {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Addbottomsheet();
                        },
                      );
                    },
                    child: Container(
                      width: mediaquery.size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.shopping_cart, color: Colors.blue),
                          Text(
                              state.productList.productData.isEmpty
                                  ? ""
                                  : "Add All",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(
                            width: mediaquery.size.width * 0.03,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        controller: controller,
                        itemCount: state.productList.productData.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          childAspectRatio: 0.72,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          String discount =
                              state.productList.productData[index].discount;
                          String discountprice = state
                              .productList.productData[index].discountPrice;

                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                              productId: state.productList
                                                  .productData[index].id
                                                  .toString(),
                                            )));
                              },
                              child: Container(
                                  height: 150,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
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
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  child: Column(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10)),
                                      child: Image.network(
                                        state.productList.productData[index]
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
                                            state.productList.productData[index]
                                                .productName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            state.productList.productData[index]
                                                .brandName,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black45,
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                mediaquery.size.height * 0.005,
                                          ),
                                          Text(
                                            discount == '0'
                                                ? ""
                                                : ("${state.productList.productData[index].discount}% off"),
                                            //text[index]['Discount'].toString(),
                                            style: TextStyle(
                                              color: Colors.green,
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                mediaquery.size.height * 0.015,
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
                                                            .productList
                                                            .productData[index]
                                                            .price
                                                        : state
                                                            .productList
                                                            .productData[index]
                                                            .discountPrice,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        mediaquery.size.width *
                                                            0.02,
                                                  ),
                                                  Text(
                                                    discountprice == '0'
                                                        ? ""
                                                        : ('₹${state.productList.productData[index].price}'),
                                                    style: TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: Colors.red,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  final cart = state
                                                          .productList
                                                          .productData[index]
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
                                                              .productList
                                                              .productData[
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
                                                            .productList
                                                            .productData[index]
                                                            .id
                                                            .toString(),
                                                        quantity: '1',
                                                      ),
                                                    );
                                                  }
                                                  setState(() {
                                                    if (cart) {
                                                      state
                                                          .productList
                                                          .productData[index]
                                                          .isCart = '0';
                                                    } else {
                                                      state
                                                          .productList
                                                          .productData[index]
                                                          .isCart = '1';
                                                    }
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.shopping_cart,
                                                  color: state
                                                              .productList
                                                              .productData[
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
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
          } else if (state is ProductAddErrorState) {
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

class Addbottomsheet extends StatefulWidget {
  const Addbottomsheet({
    super.key,
  });

  @override
  State<Addbottomsheet> createState() => _AddbottomsheetState();
}

class _AddbottomsheetState extends State<Addbottomsheet> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.53,
      maxChildSize: 0.68,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.black54,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Text("Are you sure you want to add to cart 1 items"),
              ),
              Spacer(),
              Divider(
                color: Colors.black26,
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "No",
                          style: TextStyle(color: Colors.black),
                        )),
                    VerticalDivider(color: Colors.black26),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartScreen(),
                              ));
                          Fluttertoast.showToast(
                            msg: "All products added to cart",
                            toastLength: Toast.LENGTH_LONG,
                            backgroundColor: Colors.black,
                            gravity: ToastGravity.BOTTOM,
                            textColor: Colors.white,
                          );
                        });
                      },
                      child: Center(
                        child: Text(
                          "Yes",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
