import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/Dashboard.dart';
import 'package:smailo/Dashboard/home/Detail%20Screen.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/bloc_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/event_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/brand/bloc_brand_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/brand/event_barnd_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/brand/state_brand_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/brandwise_product/bloc_brandwise_product.dart';
import 'package:smailo/Dashboard/home/bloc/brandwise_product/event_brandwise_product.dart';
import 'package:smailo/Dashboard/home/bloc/brandwise_product/state_brandwise_product.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/bloc_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/event_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/state_home_count.dart';
import 'package:smailo/model/home/brand/brand_modal.dart';

import '../home/Cart.dart';
import '../home/Favourite Screen.dart';

class BrandwiseScreen extends StatefulWidget {
  final String brandId;

  const BrandwiseScreen({
    super.key,
    required this.brandId,
  });

  @override
  State<BrandwiseScreen> createState() => _BrandwiseScreenState();
}

class _BrandwiseScreenState extends State<BrandwiseScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BrandWiseBloc>(
          create: (context) => BrandWiseBloc(),
        ),
        BlocProvider<BrandBloc>(
          create: (context) => BrandBloc(),
        ),
        BlocProvider<AddToCartBloc>(
          create: (context) => AddToCartBloc(),
        ),
        BlocProvider<HomeCountBloc>(
          create: (context) => HomeCountBloc(),
        )
      ],
      child: Brandpage(
        brandId: widget.brandId,
      ),
    );
  }
}

class Brandpage extends StatefulWidget {
  final String brandId;

  const Brandpage({
    super.key,
    required this.brandId,
  });

  @override
  State<Brandpage> createState() => _BrandpageState();
}

class _BrandpageState extends State<Brandpage> {
  ScrollController controller = ScrollController();

  int selected = -1;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCountBloc>(context).add(FetchHomeCountEvent());
    BlocProvider.of<BrandBloc>(context).add(FetchBrandEvent());
    BlocProvider.of<BrandWiseBloc>(context).add(
      FetchBrandwiseEvent(
        brandId: widget.brandId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Dashboard(),
                  ),
                  (route) => false);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Brand",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
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
                                    state.homeCountlist.countData.cartCount
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
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
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Colors.blue, Colors.blue.shade900],
              ),
            ),
          ),
        ),
        // backgroundColor: Colors.white,
        body: Column(
          children: [
            BlocBuilder<BrandBloc, BrandState>(
              builder: (context, state) {
                if (state is BrandLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is BrandLoadedState) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.065,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: state.brandList.branData.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // setState(() {
                            //   if (state.brandList.branData[index].isSelected ==
                            //       false) {
                            //     state.brandList.branData[index].isSelected =
                            //     true;
                            //     multipleId +=
                            //     "${state.brandList.branData[index].id},";
                            //   } else {
                            //     state.brandList.branData[index].isSelected =
                            //     false;
                            //     multipleId = multipleId.replaceFirst(
                            //         "${state.brandList.branData[index].id},",
                            //         "");
                            //   }
                            // });

                            // BlocProvider.of<BrandBloc>(context).add(
                            //   FetchBrandEvent(
                            //       brandProductId: multipleId.isNotEmpty
                            //           ? multipleId
                            //           : '0'),
                            // );
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.blue.shade800, width: 1.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  state.brandList.branData[index].name,
                                  style: TextStyle(
                                      color: widget.brandId ==
                                              state.brandList.branData[index]
                                                  .name
                                          ? Colors.black
                                          : Colors.blue,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is BrandErrorState) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                return Container();
              },
            ),
            BlocBuilder<BrandWiseBloc, BrandWiseState>(
              builder: (context, state) {
                if (state is BrandwiseLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is BrandwiseLoadedState) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        controller: controller,
                        itemCount: state.brandWiseList.brandWiseData.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          childAspectRatio: 0.72,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          String cutprice = state
                              .brandWiseList.brandWiseData[index].discountPrice;
                          String discount =
                              state.brandWiseList.brandWiseData[index].discount;
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    productId: state
                                        .brandWiseList.brandWiseData[index].id
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
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                      ),
                                      child: Image.network(
                                        state.brandWiseList.brandWiseData[index]
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
                                                .brandWiseList
                                                .brandWiseData[index]
                                                .productName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            state.brandWiseList
                                                .brandWiseData[index].brandName,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black45,
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                mediaquery.size.height * 0.008,
                                          ),
                                          Text(
                                            discount == "0"
                                                ? ""
                                                : ('${state.brandWiseList.brandWiseData[index].discount}% off'),
                                            style: TextStyle(
                                              color: Colors.green,
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                mediaquery.size.height * 0.01,
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
                                                    cutprice == '0'
                                                        ? state
                                                            .brandWiseList
                                                            .brandWiseData[
                                                                index]
                                                            .price
                                                        : ("${state.brandWiseList.brandWiseData[index].discountPrice}"),
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
                                                            0.01,
                                                  ),
                                                  Text(
                                                    cutprice == '0'
                                                        ? ""
                                                        : ('₹${state.brandWiseList.brandWiseData[index].price}'),
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: Colors.red),
                                                  ),
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  final cart = state
                                                          .brandWiseList
                                                          .brandWiseData[index]
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
                                                              .brandWiseList
                                                              .brandWiseData[
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
                                                            .brandWiseList
                                                            .brandWiseData[
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
                                                          .brandWiseList
                                                          .brandWiseData[index]
                                                          .isCart = '0';
                                                    } else {
                                                      state
                                                          .brandWiseList
                                                          .brandWiseData[index]
                                                          .isCart = '1';
                                                    }
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.shopping_cart,
                                                  size: 25,
                                                  color: state
                                                              .brandWiseList
                                                              .brandWiseData[
                                                                  index]
                                                              .isCart ==
                                                          '1'
                                                      ? Colors.blue
                                                      : Colors.black45,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ])),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else if (state is BrandwiseErrorState) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                return Container();
              },
            ),
          ],
        ));
  }
}
