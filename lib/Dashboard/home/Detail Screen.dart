import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:smailo/Dashboard/home/Cart.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/bloc_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/event_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/bloc_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/event_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/state_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/product_detail/bloc_product_detail.dart';
import 'package:smailo/Dashboard/home/bloc/product_detail/event_product_detail.dart';
import 'package:smailo/Dashboard/home/bloc/product_detail/state_product_detail.dart';
import 'package:smailo/Dashboard/home/bloc/save_and_remove_wish/bloc_save_remove_wish.dart';
import 'package:smailo/Dashboard/home/bloc/save_and_remove_wish/event_save_remove_wish.dart';
import 'Favourite Screen.dart';
import 'dailog screen.dart';

class DetailScreen extends StatefulWidget {
  final String productId;

  const DetailScreen({
    super.key,
    required this.productId,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductDetailBloc>(
          create: (context) => ProductDetailBloc(),
        ),
        BlocProvider(
          create: (context) => SaveAndRemoveWishBloc(),
        ),
        BlocProvider(
          create: (context) => AddToCartBloc(),
        ),
        BlocProvider(
          create: (context) => HomeCountBloc(),
        )
      ],
      child: Detailpage(
        productId: widget.productId,
      ),
    );
  }
}

class Detailpage extends StatefulWidget {
  final String productId;

  Detailpage({
    super.key,
    required this.productId,
  });

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  int counter = 1;
  bool isLike = false;
  int selectedPag = 0;
  bool isReadMore = false;
  int status = 0;

  // CarouselController carouselController = CarouselController();
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProductDetailBloc>(context).add(
      FetchProductDetailEvent(
        productId: widget.productId,
      ),
    );
    BlocProvider.of<HomeCountBloc>(context).add(FetchHomeCountEvent());
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details",
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
                        icon: const Icon(
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
          const SizedBox(
            width: 10,
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.blue, Colors.blue.shade900])),
        ),
        backgroundColor: Colors.white.withOpacity(1),
      ),
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductDetailLoadedState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                status = state.productList.status;
              });
            });
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      if (state.productList.productDetailModelData
                              .productListData.productImages.length >
                          1)
                        CarouselSlider.builder(
                          // carouselController: carouselController,
                          itemCount: state.productList.productDetailModelData
                              .productListData.productImages.length,
                          itemBuilder: (BuildContext context, int index,
                                  int realIndex) =>
                              Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: InteractiveViewer(
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dailogscreen(
                                          images: state
                                              .productList
                                              .productDetailModelData
                                              .productListData
                                              .productImages[index]
                                              .productImage,
                                        );
                                      },
                                    );
                                  },
                                  child: Image.network(
                                    state
                                        .productList
                                        .productDetailModelData
                                        .productListData
                                        .productImages[index]
                                        .productImage,
                                    fit: BoxFit.fill,
                                    width: mediaquery.size.width * 0.9,
                                    height: 300,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          options: CarouselOptions(
                            scrollDirection: Axis.horizontal,
                            autoPlay: false,
                            enlargeCenterPage: true,
                            viewportFraction: 1,
                            aspectRatio: 1.2,
                            onPageChanged: (index, reason) {
                              setState(() {
                                selectedPag = index;
                              });
                            },
                          ),
                        ),
                      if (state.productList.productDetailModelData
                              .productListData.productImages.length <=
                          1)
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: InteractiveViewer(
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dailogscreen(
                                          images: state
                                              .productList
                                              .productDetailModelData
                                              .productListData
                                              .productImage);
                                    },
                                  );
                                },
                                child: Image.network(
                                  state
                                          .productList
                                          .productDetailModelData
                                          .productListData
                                          .productImage
                                          .isNotEmpty
                                      ? state.productList.productDetailModelData
                                          .productListData.productImage
                                      : 'default_image_url',
                                  fit: BoxFit.fill,
                                  width: mediaquery.size.width * 0.9,
                                  height: 300,
                                ),
                              ),
                            ),
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.only(right: 10, top: 290),
                        child: state.productList.productDetailModelData
                                    .productListData.productImages.length >
                                1
                            ? PageViewDotIndicator(
                                alignment: Alignment.bottomCenter,
                                size: const Size.fromRadius(4),
                                currentItem: selectedPag,
                                count: state.productList.productDetailModelData
                                    .productListData.productImages.length,
                                unselectedColor: Colors.grey,
                                selectedColor: Colors.orangeAccent,
                              )
                            : Container(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(
                                1,
                                6,
                              ),
                              blurRadius: 8,
                              spreadRadius: 3,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 15, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.productList.productDetailModelData
                                  .productListData.productName,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              state.productList.productDetailModelData
                                  .productListData.brandName,
                              style: const TextStyle(
                                  color: Colors.black45, fontSize: 14),
                            ),
                            SizedBox(
                              height: mediaquery.size.height * 0.02,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.currency_rupee,
                                    color: Colors.blue, size: 16),
                                Text(
                                  state.productList.productDetailModelData
                                              .productListData.discountPrice ==
                                          '0'
                                      ? state.productList.productDetailModelData
                                          .productListData.price
                                      : state.productList.productDetailModelData
                                          .productListData.discountPrice,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(width: mediaquery.size.width * 0.02),
                                Text(
                                  state.productList.productDetailModelData
                                              .productListData.discountPrice ==
                                          '0'
                                      ? ""
                                      : ("₹${state.productList.productDetailModelData.productListData.price}"),
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.red),
                                ),
                                SizedBox(width: mediaquery.size.width * 0.02),
                                Text(
                                  state.productList.productDetailModelData
                                              .productListData.discountPrice ==
                                          '0'
                                      ? ""
                                      : "${state.productList.productDetailModelData.productListData.discount}% off",
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: mediaquery.size.height * 0.015,
                            ),
                            Row(
                              children: [
                                Text(
                                  "School :",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  width: mediaquery.size.width * 0.015,
                                ),
                                Text(
                                  state.productList.productDetailModelData
                                      .productListData.schoolName,
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Board :",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  width: mediaquery.size.width * 0.015,
                                ),
                                Text(
                                  state.productList.productDetailModelData
                                      .productListData.boardName,
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Medium :",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  width: mediaquery.size.width * 0.015,
                                ),
                                Text(
                                  state.productList.productDetailModelData
                                      .productListData.mediumName,
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Standard :",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  state.productList.productDetailModelData
                                      .productListData.standardName,
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      final favourite = state
                                              .productList
                                              .productDetailModelData
                                              .productListData
                                              .isFavorite ==
                                          '1';

                                      if (favourite) {
                                        print("remove");
                                        BlocProvider.of<SaveAndRemoveWishBloc>(
                                                context)
                                            .add(
                                          FetchRemoveWishEvent(
                                            wishListId: state
                                                .productList
                                                .productDetailModelData
                                                .productListData
                                                .wishlistId
                                                .toString(),
                                          ),
                                        );
                                      } else {
                                        print("add");
                                        BlocProvider.of<SaveAndRemoveWishBloc>(
                                                context)
                                            .add(
                                          FetchSaveWishEvent(
                                              productId: widget.productId),
                                        );
                                      }
                                      setState(() {
                                        if (favourite) {
                                          state
                                              .productList
                                              .productDetailModelData
                                              .productListData
                                              .isFavorite = '0';
                                        } else {
                                          state
                                              .productList
                                              .productDetailModelData
                                              .productListData
                                              .isFavorite = '1';
                                        }
                                      });
                                    },
                                    child: Container(
                                      height: mediaquery.size.height * 0.06,
                                      width: mediaquery.size.width * 0.12,
                                      decoration: BoxDecoration(
                                        color: state
                                                    .productList
                                                    .productDetailModelData
                                                    .productListData
                                                    .isFavorite ==
                                                '1'
                                            ? Colors.red.shade200
                                            : Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          state
                                                      .productList
                                                      .productDetailModelData
                                                      .productListData
                                                      .isFavorite ==
                                                  '1'
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color:
                                              isLike ? Colors.red : Colors.red,
                                          size: 25,
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              isReadMore
                                  ? state.productList.productDetailModelData
                                      .productListData.description
                                  : state
                                              .productList
                                              .productDetailModelData
                                              .productListData
                                              .description
                                              .length >
                                          22
                                      ? '${state.productList.productDetailModelData.productListData.description.substring(0, 22)}...'
                                      : state.productList.productDetailModelData
                                          .productListData.description,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 10,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: mediaquery.size.height * 0.01,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(
                                  () {
                                    isReadMore = !isReadMore;
                                  },
                                );
                              },
                              child: Text(
                                isReadMore
                                    ? "< See Less Details"
                                    : " See More Details >",
                                textAlign: TextAlign.center,
                                maxLines: isReadMore ? 10 : 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: mediaquery.size.height * 0.06,
                              width: mediaquery.size.width * 0.3,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                border: Border.all(
                                  color: Colors.black26,
                                ),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: mediaquery.size.height * 0.011,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (counter != 0) {
                                              counter--;
                                            }
                                          });
                                        },
                                        child: Container(
                                          height:
                                              mediaquery.size.height * 0.035,
                                          width: mediaquery.size.width * 0.075,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.black26,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: const Center(
                                              child: Icon(
                                            Icons.remove,
                                            size: 15,
                                          )),
                                        ),
                                      ),
                                      Text(
                                        "${counter}",
                                        // "1",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          counter++;

                                          setState(
                                            () {
                                              counter++;
                                            },
                                          );
                                        },
                                        child: Container(
                                          height:
                                              mediaquery.size.height * 0.035,
                                          width: mediaquery.size.width * 0.075,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.black26,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.add,
                                              size: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Similar Products",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "View All",
                              style: TextStyle(
                                color: Colors.black26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black26,
                              size: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(
                                1,
                                6,
                              ),
                              blurRadius: 8,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          controller: controller,
                          itemCount: state.productList.productDetailModelData
                              .productTopSellings.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 5,
                            childAspectRatio: 0.71,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            String discount = state
                                .productList
                                .productDetailModelData
                                .productTopSellings[index]
                                .discount;
                            String discountprice = state
                                .productList
                                .productDetailModelData
                                .productTopSellings[index]
                                .discountPrice;
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                              productId: state
                                                  .productList
                                                  .productDetailModelData
                                                  .productTopSellings[index]
                                                  .id
                                                  .toString(),
                                            )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15),
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            topLeft: Radius.circular(10)),
                                        child: Image.network(
                                          state
                                              .productList
                                              .productDetailModelData
                                              .productTopSellings[index]
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
                                                  .productList
                                                  .productDetailModelData
                                                  .productTopSellings[index]
                                                  .productName,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              state
                                                  .productList
                                                  .productDetailModelData
                                                  .productTopSellings[index]
                                                  .brandName,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black45,
                                              ),
                                            ),
                                            SizedBox(
                                              height: mediaquery.size.height *
                                                  0.002,
                                            ),
                                            Text(
                                                discount == '0'
                                                    ? " "
                                                    : ("${state.productList.productDetailModelData.productTopSellings[index].discount} %off"),
                                                style: TextStyle(
                                                    color: Colors.green)),
                                            SizedBox(
                                              height: mediaquery.size.height *
                                                  0.008,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                              .productDetailModelData
                                                              .productTopSellings[
                                                                  index]
                                                              .price
                                                          : state
                                                              .productList
                                                              .productDetailModelData
                                                              .productTopSellings[
                                                                  index]
                                                              .discountPrice,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: mediaquery
                                                              .size.width *
                                                          0.01,
                                                    ),
                                                    Text(
                                                      discountprice == '0'
                                                          ? ""
                                                          : state
                                                              .productList
                                                              .productDetailModelData
                                                              .productTopSellings[
                                                                  index]
                                                              .price,
                                                      style: const TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: Colors.red,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Icon(
                                                  Icons.shopping_cart,
                                                  size: 25,
                                                  color: Colors.black45,
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
                      ))
                ],
              ),
            );
          } else if (state is ProductDetailErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: status == 200
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    print("add");
                    BlocProvider.of<AddToCartBloc>(context).add(
                      FetchAddToCartEvent(
                          productId: widget.productId,
                          quantity: counter.toString()),
                    );
                  },
                  child: Container(
                    height: mediaquery.size.height * 0.075,
                    width: mediaquery.size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        "Add To Cart",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartScreen(),
                        ));
                  },
                  child: Container(
                    height: mediaquery.size.height * 0.075,
                    width: mediaquery.size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(
                          10,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Buy Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Text("Loading"),
    );
  }
}
