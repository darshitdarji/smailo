import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/Cartbottomsheet.dart';
import 'package:smailo/Dashboard/category/Product.dart';
import 'package:smailo/Dashboard/home/Checkout%20Screen.dart';
import 'package:smailo/Dashboard/home/Detail%20Screen.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/bloc_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/event_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/state_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/cartscreen/bloc_cart_sccreen.dart';
import 'package:smailo/Dashboard/home/bloc/cartscreen/event_cart_screen.dart';
import 'package:smailo/Dashboard/home/bloc/cartscreen/state_cart_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<CartBloc>(
        create: (context) => CartBloc(),
      ),
      BlocProvider<AddToCartBloc>(
        create: (context) => AddToCartBloc(),
      )
    ], child: Cart());
  }
}

class Cart extends StatefulWidget {
  const Cart({
    super.key,
  });

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  ScrollController controller = ScrollController();

  int increment = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CartBloc>(context).add(FetchCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Colors.blue, Colors.blue.shade900],
            ),
          ),
        ),
        title: const Text(
          "Cart",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      backgroundColor: Colors.white.withOpacity(0.95),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is AddToCartLoadedState ||
              state is RemoveToCartLoadedState) {
            BlocProvider.of<CartBloc>(context).add(FetchCartEvent());
          }
        },
        builder: (context, state) {
          if (state is CartLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartLoadedState) {
            if (state.cartList.cartDetail.cartDetailData.isEmpty) {
              return Center(
                child: Text(
                  "Please Enter Product to Cart",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        controller: controller,
                        itemCount:
                            state.cartList.cartDetail.cartDetailData.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index < 0 ||
                              index >=
                                  state.cartList.cartDetail.cartDetailData
                                      .length) {
                            return Container();
                          }
                          String discount = state.cartList.cartDetail
                              .cartDetailData[index].productData.discount;
                          return Dismissible(
                            confirmDismiss: (direction) async {
                              return showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return CartBottomSheet(
                                    name: state
                                        .cartList
                                        .cartDetail
                                        .cartDetailData[index]
                                        .productData
                                        .productName,
                                    image: state
                                        .cartList
                                        .cartDetail
                                        .cartDetailData[index]
                                        .productData
                                        .productImage,
                                    id: state.cartList.cartDetail
                                        .cartDetailData[index].productId,
                                  );
                                },
                              );
                            },
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
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              BlocProvider.of<CartBloc>(context).add(
                                FetchCartEvent(),
                              );
                            },
                            key: Key(
                              state.cartList.cartDetail.cartDetailData[index]
                                  .toString(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                        productId: state.cartList.cartDetail
                                            .cartDetailData[index].productId
                                            .toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      const BoxShadow(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5),
                                                    decoration: BoxDecoration(),
                                                    height:
                                                        mediaQuery.size.height *
                                                            0.13,
                                                    width:
                                                        mediaQuery.size.width *
                                                            0.22,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: Image.network(
                                                        state
                                                            .cartList
                                                            .cartDetail
                                                            .cartDetailData[
                                                                index]
                                                            .productData
                                                            .productImage,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        mediaQuery.size.width *
                                                            0.015,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          ('${state.cartList.cartDetail.cartDetailData[index].productData.productName}' +
                                                              (state
                                                                          .cartList
                                                                          .cartDetail
                                                                          .cartDetailData[
                                                                              index]
                                                                          .productData
                                                                          .productName
                                                                          .length >
                                                                      20
                                                                  ? '...'
                                                                  : '')),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        Text(
                                                          state
                                                              .cartList
                                                              .cartDetail
                                                              .cartDetailData[
                                                                  index]
                                                              .productData
                                                              .brandName,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: mediaQuery
                                                                  .size.height *
                                                              0.008,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .currency_rupee,
                                                              size: 15,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                            Text(
                                                              "${int.parse(state.cartList.cartDetail.cartDetailData[index].productData.discountPrice) * increment}",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .blue),
                                                            ),
                                                            SizedBox(
                                                                width: mediaQuery
                                                                        .size
                                                                        .width *
                                                                    0.02),
                                                            Text(
                                                              discount == '0'
                                                                  ? ""
                                                                  : "₹${int.parse(state.cartList.cartDetail.cartDetailData[index].productData.price) * increment}",
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 12,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: mediaQuery
                                                                        .size
                                                                        .width *
                                                                    0.02),
                                                            Text(
                                                              discount == '0'
                                                                  ? ""
                                                                  : ("${state.cartList.cartDetail.cartDetailData[index].productData.discount}% off"),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .green,
                                                                  fontSize: 13),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: mediaQuery
                                                                  .size.height *
                                                              0.009,
                                                        ),
                                                        Container(
                                                          width: mediaQuery
                                                                  .size.width *
                                                              0.2,
                                                          height: mediaQuery
                                                                  .size.height *
                                                              0.05,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.blue,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    BlocProvider.of<CartBloc>(
                                                                            context)
                                                                        .add(
                                                                            FetchCartEvent());
                                                                  });

                                                                  if (state
                                                                          .cartList
                                                                          .cartDetail
                                                                          .cartDetailData[
                                                                              index]
                                                                          .qty ==
                                                                      '1') {
                                                                    showModalBottomSheet(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return CartBottomSheet(
                                                                          id: state
                                                                              .cartList
                                                                              .cartDetail
                                                                              .cartDetailData[index]
                                                                              .productId,
                                                                          name: state
                                                                              .cartList
                                                                              .cartDetail
                                                                              .cartDetailData[index]
                                                                              .productData
                                                                              .productName,
                                                                          image: state
                                                                              .cartList
                                                                              .cartDetail
                                                                              .cartDetailData[index]
                                                                              .productData
                                                                              .productImage,
                                                                        );
                                                                      },
                                                                    );
                                                                  } else {
                                                                    int quntity = int.parse(state
                                                                        .cartList
                                                                        .cartDetail
                                                                        .cartDetailData[
                                                                            index]
                                                                        .qty);
                                                                    quntity--;
                                                                    BlocProvider.of<AddToCartBloc>(
                                                                            context)
                                                                        .add(
                                                                      FetchAddToCartEvent(
                                                                        productId: state
                                                                            .cartList
                                                                            .cartDetail
                                                                            .cartDetailData[index]
                                                                            .productId,
                                                                        quantity:
                                                                            quntity.toString(),
                                                                      ),
                                                                    );
                                                                  }
                                                                },
                                                                child: Icon(
                                                                  state.cartList.cartDetail.cartDetailData[index].qty ==
                                                                          '1'
                                                                      ? Icons
                                                                          .delete_outline
                                                                      : Icons
                                                                          .remove,
                                                                  size: 25,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              Container(
                                                                height: mediaQuery
                                                                        .size
                                                                        .height *
                                                                    0.033,
                                                                width: mediaQuery
                                                                        .size
                                                                        .width *
                                                                    0.05,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    2,
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    int.parse(state
                                                                            .cartList
                                                                            .cartDetail
                                                                            .cartDetailData[index]
                                                                            .qty)
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    BlocProvider.of<CartBloc>(
                                                                            context)
                                                                        .add(
                                                                            FetchCartEvent());
                                                                  });

                                                                  int quentity = int.parse(state
                                                                      .cartList
                                                                      .cartDetail
                                                                      .cartDetailData[
                                                                          index]
                                                                      .qty);
                                                                  quentity++;
                                                                  BlocProvider.of<
                                                                              AddToCartBloc>(
                                                                          context)
                                                                      .add(
                                                                    FetchAddToCartEvent(
                                                                      productId: state
                                                                          .cartList
                                                                          .cartDetail
                                                                          .cartDetailData[
                                                                              index]
                                                                          .productId,
                                                                      quantity:
                                                                          quentity
                                                                              .toString(),
                                                                    ),
                                                                  );
                                                                },
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 25,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )
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
                                                    return CartBottomSheet(
                                                      id: state
                                                          .cartList
                                                          .cartDetail
                                                          .cartDetailData[index]
                                                          .id
                                                          .toString(),
                                                      name: state
                                                          .cartList
                                                          .cartDetail
                                                          .cartDetailData[index]
                                                          .productData
                                                          .productName,
                                                      image: state
                                                          .cartList
                                                          .cartDetail
                                                          .cartDetailData[index]
                                                          .productData
                                                          .productImage,
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
                                      )
                                    ],
                                  ),
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
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Coupons and Discounts",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      child: Container(
                        height: mediaQuery.size.height * 0.13,
                        width: mediaQuery.size.width * 0.92,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 18,
                            ),
                            Container(
                              height: mediaQuery.size.height * 0.065,
                              width: mediaQuery.size.width * 0.58,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  hintText: "Apply the coupon Code here",
                                  hintStyle: TextStyle(
                                    color: Colors.black26,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: mediaQuery.size.height * 0.065,
                              width: mediaQuery.size.width * 0.21,
                              child: const Center(
                                child: Text(
                                  "Apply",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Payment Summry",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 5, bottom: 10),
                      child: Container(
                        width: mediaQuery.size.width * 0.92,
                        height: mediaQuery.size.width * 0.52,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total MRP",
                                      style: TextStyle(fontSize: 16)),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.currency_rupee,
                                        size: 15,
                                      ),
                                      Text(
                                        state.cartList.cartDetail.cartSummary
                                            .subTotal
                                            .toString(),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.black26,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Discount on MRP",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        child: const Icon(
                                          Icons.remove,
                                          size: 10,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.currency_rupee,
                                        size: 15,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        state.cartList.cartDetail.cartSummary
                                            .discountTotal
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.green,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.black26,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Coupon Discount",
                                      style: TextStyle(fontSize: 16)),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.remove,
                                        size: 10,
                                        color: Colors.green,
                                      ),
                                      Icon(
                                        Icons.currency_rupee,
                                        size: 15,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        state.cartList.cartDetail.cartSummary
                                            .couponDiscount
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.black26,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Order Total",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.currency_rupee,
                                        size: 14,
                                      ),
                                      Text(
                                        state.cartList.cartDetail.cartSummary
                                            .orderTotal
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          } else if (state is CartErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartLoadedState) {
            if (state.cartList.cartDetail.cartDetailData.isNotEmpty) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProductScreen(),
                          ));
                    },
                    child: Container(
                      height: mediaQuery.size.height * 0.075,
                      width: mediaQuery.size.width * 0.5,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Add More",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mediaQuery.size.height * 0.075,
                    width: mediaQuery.size.width * 0.5,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      controller: controller,
                      itemCount:
                          state.cartList.cartDetail.cartDetailData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckoutScreen(
                                  totalMrp: state
                                      .cartList.cartDetail.cartSummary.subTotal
                                      .toString(),
                                  coupon: state.cartList.cartDetail.cartSummary
                                      .couponDiscount
                                      .toString(),
                                  discountMrp: state.cartList.cartDetail
                                      .cartSummary.discountTotal
                                      .toString(),
                                  orderTotal: state.cartList.cartDetail
                                      .cartSummary.orderTotal
                                      .toString(),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: mediaQuery.size.height * 0.075,
                            width: mediaQuery.size.width * 0.5,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Checkout",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
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
            } else {
              return SizedBox();
            }
          } else if (state is CartErrorState) {
            return Text("No Data Found");
          }
          return Container();
        },
      ),
    );
  }
}
