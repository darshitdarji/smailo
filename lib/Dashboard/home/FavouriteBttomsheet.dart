import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/save_and_remove_wish/bloc_save_remove_wish.dart';
import 'package:smailo/Dashboard/home/bloc/save_and_remove_wish/event_save_remove_wish.dart';
import 'package:smailo/Dashboard/home/bloc/save_and_remove_wish/state_save_remove_wish.dart';

class FavouriteBottomSheet extends StatefulWidget {
  final String image;
  final String name;
  final String wishId;

  const FavouriteBottomSheet({
    super.key,
    required this.image,
    required this.name,
    required this.wishId,
  });

  @override
  State<FavouriteBottomSheet> createState() => _FavouriteBottomSheetState();
}

class _FavouriteBottomSheetState extends State<FavouriteBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SaveAndRemoveWishBloc(),
      child: Favouritebottom(
        image: widget.image,
        name: widget.name,
        wishId: widget.wishId,
      ),
    );
  }
}

class Favouritebottom extends StatefulWidget {
  final String image;
  final String name;
  final String wishId;

  const Favouritebottom({
    super.key,
    required this.image,
    required this.name,
    required this.wishId,
  });

  @override
  State<Favouritebottom> createState() => _FavouritebottomState();
}

class _FavouritebottomState extends State<Favouritebottom> {
  var increment = 1;

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return BlocConsumer<SaveAndRemoveWishBloc, SaveAndRemoveWishState>(
      listener: (context, state) {
        if (state is RemoveToWishErrorState) {
        } else if (state is RemoveToWishLoadedState) {
          Navigator.of(context).pop(true);
        }
      },
      builder: (context, state) {
        if (state is SaveToWishLoadingState) {
          return Container(
            height: mediaquery.size.height * 0.25,
            width: double.infinity,
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(
            top: 5,
            right: 10,
            left: 10,
          ),
          child: Container(
            height: mediaquery.size.height * 0.25,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              // color: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: 115,
                            width: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                widget.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: mediaquery.size.width * 0.02,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.name),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Are you sure wants to remove this\n items from wishlist?",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black26,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(
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
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black12,
                  height: 10,
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text(
                          "No",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        color: Colors.black26,
                      ),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<SaveAndRemoveWishBloc>(context).add(
                            FetchRemoveWishEvent(wishListId: widget.wishId),
                          );
                        },
                        child: const Text(
                          "Yes",
                          style: TextStyle(fontSize: 12, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
