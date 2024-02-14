import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/bloc_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/add_to_cart/event_add_to_cart.dart';
import 'package:smailo/Dashboard/home/bloc/cartscreen/bloc_cart_sccreen.dart';
import 'package:smailo/Dashboard/home/bloc/cartscreen/event_cart_screen.dart';
import 'package:smailo/Dashboard/home/bloc/save_and_remove_wish/bloc_save_remove_wish.dart';
import 'package:smailo/Dashboard/home/bloc/save_and_remove_wish/event_save_remove_wish.dart';

class CartBottomSheet extends StatefulWidget {
  final String image;
  final String name;
  final String id;

  const CartBottomSheet(
      {super.key, required this.image, required this.name, required this.id});

  @override
  State<CartBottomSheet> createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddToCartBloc(),
        ),
        BlocProvider(create: (context) => SaveAndRemoveWishBloc(),
        )
      ],
      child: CartBottom(
        image: widget.image,
        name: widget.name,
        id: widget.id,
      ),
    );
  }
}

class CartBottom extends StatefulWidget {
  final String image;
  final String name;
  final String id;

  const CartBottom({
    super.key,
    required this.image,
    required this.name,
    required this.id,
  });

  @override
  State<CartBottom> createState() => _CartBottomState();
}

class _CartBottomState extends State<CartBottom> {
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 5, right: 10, left: 10),
      child: Container(
        height: mediaquery.size.height * 0.25,
        width: double.infinity,
        color: Colors.white,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              // col2or: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: 115,
                            width: 80,
                            child: Image.network(
                              widget.image,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: mediaquery.size.width * 0.02,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.name,
                              maxLines: widget.name.length > 20 ? 3 : null,
                              overflow: widget.name.length > 20 ? TextOverflow.ellipsis : null,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Are you wants to move this\n item from bag?",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.black26, fontSize: 13),
                            ),
                            SizedBox(
                              height: 30,
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    size: 25,
                  ),
                )
              ],
            ),
            const Divider(
              color: Colors.black12,
              height: 0,
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<AddToCartBloc>(context).add(
                        FetchRemoveToCartEvent(productId: widget.id),
                      );
                      Navigator.of(context).pop(true);
                    },
                    child: const Text(
                      "Remove",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  VerticalDivider(),
                  TextButton(
                    onPressed: () {
BlocProvider.of<AddToCartBloc>(context).add(FetchRemoveToCartEvent(productId: widget.id),);
BlocProvider.of<SaveAndRemoveWishBloc>(context).add(FetchSaveWishEvent(productId: widget.id),);
                      Navigator.of(context).pop(true);
                    },
                    child: const Text(
                      "MOVE TO WISHLIST",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
