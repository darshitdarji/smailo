import 'dart:core';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:smailo/Dashboard/home/Cart.dart';
import 'package:smailo/Dashboard/category/Brandbottomsheet.dart';
import 'package:smailo/Dashboard/category/Features.dart';
import 'package:smailo/Dashboard/category/Product.dart';
import 'package:smailo/Dashboard/category/select_school/school_bottomsheet.dart';
import 'package:smailo/Dashboard/home/Detail%20Screen.dart';
import 'package:smailo/Dashboard/home/Favourite%20Screen.dart';
import 'package:smailo/Dashboard/home/Flash%20%20Deal.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/bloc_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/event_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/state_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/all_products/bloc_all_products.dart';
import 'package:smailo/Dashboard/home/bloc/all_products/event_all_products.dart';
import 'package:smailo/Dashboard/home/bloc/all_products/state_all_products.dart';
import 'package:smailo/Dashboard/home/bloc/bannerlist/bloc_bannerlist.dart';
import 'package:smailo/Dashboard/home/bloc/bannerlist/event_bannerlist.dart';
import 'package:smailo/Dashboard/home/bloc/bannerlist/state_bannerlist.dart';
import 'package:smailo/Dashboard/home/bloc/cartscreen/bloc_cart_sccreen.dart';
import 'package:smailo/Dashboard/home/bloc/cartscreen/state_cart_screen.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/bloc_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/event_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/state_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/second_banner/bloc_secondbanner.dart';
import 'package:smailo/Dashboard/home/bloc/second_banner/event_secondbanner.dart';
import 'package:smailo/Dashboard/home/bloc/second_banner/state_secondbanner.dart';
import 'package:smailo/model/home/all_products/all_products_model.dart';
import 'Search screen.dart';
import 'Todays_deal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<BannerBloc>(
        create: (context) => BannerBloc(),
      ),
      BlocProvider<AllProductsBloc>(
        create: (context) => AllProductsBloc(),
      ),
      BlocProvider<SecondBannerBloc>(
        create: (context) => SecondBannerBloc(),
      ),
      BlocProvider<AddToCartBloc>(
        create: (context) => AddToCartBloc(),
      ),
      BlocProvider<HomeCountBloc>(
        create: (context) => HomeCountBloc(),
      ),
      BlocProvider<CartBloc>(
        create: (context) => CartBloc(),
      )
    ], child: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final CarouselController carouselController = CarouselController();
  ScrollController controller = ScrollController();
  TextEditingController _searchController = TextEditingController();
  int selectedPag = 0;
  bool add = false;

  late List<AllProductsListModel> productList;
  final List<Map<String, dynamic>> Category = [
    {
      'Type': 'school',
      'Icon': Icons.business,
      'Name': 'Select School',
    },
    {
      'Type': 'product',
      'Icon': Icons.school,
      'Name': 'Product',
    },
    {
      'Type': 'brand',
      'Icon': Icons.menu,
      'Name': 'Brand',
    },
    {
      'Type': 'featured',
      'Icon': Icons.drag_handle,
      'Name': 'Featured',
    }
  ];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BannerBloc>(context).add(
      FetchBannerEvent(),
    );
    BlocProvider.of<AllProductsBloc>(context).add(
      FetchAllProductEvent(filterPrice: '', filterShortBy: ''),
    );

    BlocProvider.of<SecondBannerBloc>(context).add(
      FetchSecondBannerEvent(),
    );
    BlocProvider.of<HomeCountBloc>(context).add(FetchHomeCountEvent());
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
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
                            height: mediaQuery.size.height * 0.02,
                            width: mediaQuery.size.width * 0.04,
                            child: Center(
                              child: Text(
                                state.homeCountlist.countData.favoriteCount
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
                                height: mediaQuery.size.height * 0.02,
                                width: mediaQuery.size.width * 0.04,
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
      backgroundColor: Colors.white.withOpacity(0.95),
      body: SingleChildScrollView(
        child: MultiBlocListener(
          listeners: [
            BlocListener<CartBloc, CartState>(
              listener: (context, state) {
                if (state is AddToCartLoadedState ||
                    state is RemoveToCartLoadedState) {
                  print("object2");

                  BlocProvider.of<HomeCountBloc>(context)
                      .add(FetchHomeCountEvent());
                } else {
                  print("Error While The HomeCount ");
                }
              },
            )
          ],
          child: Column(
            children: [
              Container(
                height: mediaQuery.size.height * 0.05,
                width: mediaQuery.size.width * 0.9,
                margin: const EdgeInsets.symmetric(vertical: 10),
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
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  controller: _searchController,
                  onFieldSubmitted: (value) {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => SearchScreeen(
                          keyword: value,
                        ),
                      ),
                    )
                        .then(
                      (_) {
                        _searchController.clear();
                      },
                    );
                  },
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                      alignLabelWithHint: true,
                      hintText: "Search anything",
                      hintStyle: TextStyle(
                          color: Colors.black26, fontWeight: FontWeight.w300),
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.search_sharp,
                        color: Colors.black26,
                      ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<BannerBloc, BannerState>(
                builder: (context, state) {
                  if (state is BannerLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is BannerLoadedState) {
                    return Stack(
                      children: [
                        CarouselSlider.builder(
                          // carouselController: carouselController,
                          itemCount: state.bannerList.bannerListData.length,
                          itemBuilder: (BuildContext context, int index,
                                  int realIndex) =>
                              Container(
                            width: mediaQuery.size.width * 0.9,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  state.bannerList.bannerListData[index].image,
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  10,
                                ),
                              ),
                            ),
                          ),
                          options: CarouselOptions(
                            autoPlayAnimationDuration: const Duration(
                              seconds: 2,
                            ),
                            scrollDirection: Axis.horizontal,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 1,
                            aspectRatio: 2.9,
                            onPageChanged: (index, reason) {
                              setState(
                                () {
                                  selectedPag = index;
                                },
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 120,
                          ),
                          child: PageViewDotIndicator(
                            size: const Size.fromRadius(4),
                            currentItem: selectedPag,
                            count: state.bannerList.bannerListData.length,
                            unselectedColor: Colors.grey,
                            selectedColor: Colors.orangeAccent,
                          ),
                        ),
                      ],
                    );
                  } else if (state is BannerErrorState) {
                    return Center(
                      child: Text(state.error),
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TodayDeal(),
                          ));
                    },
                    child: Container(
                      width: mediaQuery.size.width * 0.42,
                      height: mediaQuery.size.height * 0.1,
                      child: const Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.deepOrange,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Today's Deal",
                          ),
                        ],
                      ),
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
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FlashDealScreen(),
                          ));
                    },
                    child: Container(
                      width: mediaQuery.size.width * 0.42,
                      height: mediaQuery.size.height * 0.1,
                      child: const Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Icon(
                            Icons.electric_bolt_sharp,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Flash Deal")
                        ],
                      ),
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
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<SecondBannerBloc, SecondBannerState>(
                builder: (context, state) {
                  if (state is SecondBannerLoadingState) {
                    return Center(
                      child: Container(),
                    );
                  } else if (state is SecondBannerLoadedState) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller,
                      itemCount: state.secondBannerData.secondBannerData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 19, vertical: 5),
                          child: Container(
                            height: mediaQuery.size.height * 0.23,
                            width: mediaQuery.size.width * 0.9,
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                state.secondBannerData.secondBannerData[index]
                                    .image,
                                fit: BoxFit.fill,
                                height: mediaQuery.size.height * 0.05,
                                width: mediaQuery.size.width * 0.9,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is SecondBannerErrorState) {
                    return Center(
                      child: Text(state.error),
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Featured categories",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20,),
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller,
                  itemCount: Category.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    String? openType = Category[index]['Type'];
                    return GestureDetector(
                      onTap: () {
                        if (openType == 'school') {
                          showModalBottomSheet(
                            context: context,
                            showDragHandle: true,
                            builder: (context) {
                              return const schoolBottomSheet();
                            },
                          );
                        } else if (openType == 'featured') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FeaturesScreen(),
                              ),);
                        } else if (openType == 'product') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductScreen(),
                              ),
                          );
                        } else if (openType == 'brand') {
                          showModalBottomSheet(
                            showDragHandle: true,
                            context: context,
                            builder: (context) {
                              return const BranBottomSheet();
                            },
                          );
                        }
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            const BoxShadow(
                              color: Colors.black12,
                              offset: Offset(
                                1,
                                4,
                              ),
                              blurRadius: 2,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Category[index]['Icon'],
                                color: Colors.blue,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                Category[index]['Name'],
                                style: const TextStyle(
                                  color: Colors.blue,
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
              const SizedBox(
                height: 10,
              ),
              const Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "All Products",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  child: BlocBuilder<AllProductsBloc, AllProductsState>(
                    //                   listener: (context, state){
                    //                     if(state is AddToCartLoadedState||state is  RemoveToCartLoadedState){
                    // BlocProvider.of<HomeCountBloc>(context).add(FetchHomeCountEvent());
                    //                     }
                    //                   },
                    builder: (context, state) {
                      if (state is AllProductsLoadingState) {
                        return Center(
                          child: Container(),
                        );
                      } else if (state is AllProductsLoadedState) {
                        return GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          controller: controller,
                          itemCount:
                              state.allProductsList.allProductsData.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            childAspectRatio: 0.7,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            String discount = state.allProductsList
                                .allProductsData[index].discount;
                            String discounprice = state.allProductsList
                                .allProductsData[index].discountPrice;

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      productId: state.allProductsList
                                          .allProductsData[index].id
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
                                        state
                                            .allProductsList
                                            .allProductsData[index]
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
                                                .allProductsList
                                                .allProductsData[index]
                                                .productName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(),
                                          ),
                                          Text(
                                            state
                                                .allProductsList
                                                .allProductsData[index]
                                                .brandName,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black45,
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                mediaQuery.size.height * 0.002,
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
                                            height:
                                                mediaQuery.size.height * 0.008,
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
                                                            .allProductsData[
                                                                index]
                                                            .price
                                                        : ("${state.allProductsList.allProductsData[index].discountPrice}"),
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        mediaQuery.size.width *
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
                                                  setState(() {
                                                    final cart = state
                                                            .allProductsList
                                                            .allProductsData[
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
                                                                .allProductsList
                                                                .allProductsData[
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
                                                              .allProductsList
                                                              .allProductsData[
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
                                                            .allProductsList
                                                            .allProductsData[
                                                                index]
                                                            .isCart = '0';
                                                      } else {
                                                        state
                                                            .allProductsList
                                                            .allProductsData[
                                                                index]
                                                            .isCart = '1';
                                                      }
                                                    });
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
                            );
                          },
                        );
                      } else if (state is AllProductsErrorState) {
                        return Center(
                          child: Text(state.error),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
