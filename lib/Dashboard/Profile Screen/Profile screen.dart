  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:smailo/Dashboard/Profile%20Screen/bloc/user_profile/bloc_user_profile.dart';
  import 'package:smailo/Dashboard/Profile%20Screen/bloc/user_profile/event_user_profile.dart';
  import 'package:smailo/Dashboard/Profile%20Screen/bloc/user_profile/state_user_profile.dart';
  import 'package:smailo/Dashboard/home/Cart.dart';
  import 'package:smailo/Dashboard/Profile%20Screen/Edit%20Profile.dart';
  import 'package:smailo/Dashboard/home/Favourite%20Screen.dart';
  import 'package:smailo/Dashboard/Orders%20Screen/Order%20Screen.dart';
  import 'package:smailo/Dashboard/home/bloc/home_count/bloc_home_count.dart';
  import 'package:smailo/Dashboard/home/bloc/home_count/event_home_count.dart';
  import 'package:smailo/Dashboard/home/bloc/home_count/state_home_count.dart';

  import '../Dashboard.dart';
import '../Pageview Builder/Pageview builder.dart';
  import 'orders of user/Address of Users.dart';

  class ProfileScreen extends StatefulWidget {
    const ProfileScreen({super.key});

    @override
    State<ProfileScreen> createState() => _ProfileScreenState();
  }

  class _ProfileScreenState extends State<ProfileScreen> {
    @override
    Widget build(BuildContext context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<HomeCountBloc>(
            create: (context) => HomeCountBloc(),
          ),
          BlocProvider<EditUserProfileBloc>(
            create: (context) => EditUserProfileBloc(),
          ),
        ],
        child: const ProfilePage(),
      );
    }
  }

  class ProfilePage extends StatefulWidget {
    // final VoidCallback onTap;

    const ProfilePage({
      super.key,
      // required this.onTap,
    });

    @override
    State<ProfilePage> createState() => _ProfilePageState();
  }

  class _ProfilePageState extends State<ProfilePage> {
    var image;

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      BlocProvider.of<HomeCountBloc>(context).add(FetchHomeCountEvent());
      BlocProvider.of<EditUserProfileBloc>(context).add(FetchUserProfileEvent());
    }

    @override
    Widget build(BuildContext context) {
      var mediaQuery = MediaQuery.of(context);

      return Scaffold(
        body: BlocBuilder<EditUserProfileBloc, EditUserProfileState>(
          builder: (context, state) {
            if (state is EditUserProfileLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EditUserProfileLoadedState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: mediaQuery.size.width,
                      height: mediaQuery.size.height*0.45,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                              colors: [
                            Colors.lightBlue,
                            Colors.blue.shade600,
                            Colors.blue.shade800,
                          ])),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 20, top: 50),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const EditProfile(),
                                    ));
                                  },
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        child: ClipOval(
                                          child: Image.network(
                                            state.userList.userData.profileImage,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: mediaQuery.size.width * 0.013,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            state.userList.userData.name,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          Text(
                                            state.userList.userData.email,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const Pages(),
                                          ));
                                    },
                                    child: InkWell(
                                      onTap: Dailogboox,
                                      child: Container(
                                        height: mediaQuery.size.height * 0.04,
                                        width: mediaQuery.size.width * 0.2,
                                        child: const Center(
                                            child: Text(
                                          "Log out",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 10),
                                        )),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border:
                                                Border.all(color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<HomeCountBloc, HomeCountState>(
                              builder: (context, state) {
                                if (state is HomeCountLoadingState) {
                                  return Container();
                                } else if (state is HomeCountLoadedState) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const CartScreen(),
                                              ));
                                        },
                                        child: Container(
                                          height: mediaQuery.size.height * 0.055,
                                          width: mediaQuery.size.width * 0.24,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                state.homeCountlist.countData
                                                    .cartCount
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              const Text("In your cart",
                                                  style: TextStyle(fontSize: 10)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const FavouriteScreen(),
                                              ));
                                        },
                                        child: Container(
                                          height: mediaQuery.size.height * 0.055,
                                          width: mediaQuery.size.width * 0.28,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                state.homeCountlist.countData
                                                    .favoriteCount
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              const Text("In your wishlist",
                                                  style: TextStyle(fontSize: 10)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                     OrderScreen(),
                                              ),
                                          );
                                        },
                                        child: Container(
                                          height: mediaQuery.size.height * 0.055,
                                          width: mediaQuery.size.width * 0.25,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                state.homeCountlist.countData
                                                    .orderCount
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              const Text("your ordered",
                                                  style: TextStyle(fontSize: 10)),
                                            ],
                                          ),
                                        ),
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
                              height: 25,
                            ),
                            Container(
                              height: mediaQuery.size.height * 0.18,
                              width: mediaQuery.size.width * 1,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: mediaQuery.size.height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const EditProfile(),
                                              ));
                                        },
                                        child: const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.edit_calendar_outlined,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text("Edit Profile",
                                                style: TextStyle(fontSize: 13))
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const AddressScreen(),
                                              ));
                                        },
                                        child: const Column(
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Adress",
                                              style: TextStyle(fontSize: 13),
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const OrderScreen(),
                                              ));
                                        },
                                        child: const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.edit_note_outlined,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text("My orders",
                                                style: TextStyle(fontSize: 13))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const FavouriteScreen(),
                                              ));
                                        },
                                        child: const Column(
                                            crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.favorite_border,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text("My Wishlist")
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mediaQuery.size.height * 0.025,
                    ),
                    Container(
                      height: mediaQuery.size.height * 0.46,
                      width: mediaQuery.size.width * 0.9,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            SizedBox(
                              height: mediaQuery.size.height * 0.015,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.quiz_outlined,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "FaQ's",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                width: mediaQuery.size.width * 0.7,
                                child: Divider(
                                  height: mediaQuery.size.height * 0.038,
                                  color: Colors.black12,
                                )),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.question_mark,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: mediaQuery.size.width * 0.025,
                                  ),
                                  const Text(
                                    "Terms and Condition",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                width: mediaQuery.size.width * 0.7,
                                child: Divider(
                                  height: mediaQuery.size.height * 0.038,
                                  color: Colors.black12,
                                )),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.privacy_tip_outlined,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: mediaQuery.size.width * 0.025,
                                  ),
                                  const Text(
                                    "Privacy Policy",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                width: mediaQuery.size.width * 0.7,
                                child: Divider(
                                  height: mediaQuery.size.height * 0.038,
                                  color: Colors.black12,
                                )),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.contact_page_outlined,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: mediaQuery.size.width * 0.025,
                                  ),
                                  const Text(
                                    "Contect us",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                width: mediaQuery.size.width * 0.7,
                                child: Divider(
                                  height: mediaQuery.size.height * 0.038,
                                  color: Colors.black12,
                                )),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: mediaQuery.size.width * 0.025,
                                  ),
                                  const Text(
                                    "About us ",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                width: mediaQuery.size.width * 0.7,
                                child: Divider(
                                  height: mediaQuery.size.height * 0.04,
                                  color: Colors.black12,
                                )),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    Dailogboox();
                                  });
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.delete_outline_outlined,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: mediaQuery.size.width * 0.025,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              actionsPadding:
                                                  const EdgeInsets.all(10),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              backgroundColor:
                                                  Colors.white.withOpacity(0.95),
                                              title: RichText(
                                                text: const TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "Do you want to delete your\naccount from our system? \n\n",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "Once your account is deleted from our\nsystem, you will lose your balance and\nother information from our system.",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black45),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const Pages(),
                                                        ));
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: const Center(
                                                        child: Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                  ),
                                                ),
                                                // SizedBox(),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: const Center(
                                                        child: Text(
                                                      "No",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: const Text(
                                        "Delete my account",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                width: mediaQuery.size.width * 0.7,
                                child: Divider(
                                  height: mediaQuery.size.height * 0.04,
                                  color: Colors.black12,
                                )),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.logout_outlined,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: mediaQuery.size.width * 0.03,
                                  ),
                                  InkWell(
                                    onTap: Dailogboox,
                                    child: const Text(
                                      "Log out",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is EditUserProfileErrorState) {
              return Center(
                child: Text(state.error),
              );
            }
            return Container();
          },
        ),
      );
    }

    void Dailogboox() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              backgroundColor: Colors.white.withOpacity(0.95),
              title: const Text(
                "Do you Wants to Delete your account from our system",
                style: TextStyle(fontSize: 15),
              ),
              actions: [
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Pages(),
                        ));
                  },
                  child: Container(
                    height: 40,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                        child: Text(
                      "Yes",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                // SizedBox(),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                        child: Text(
                      "No",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ],
            );
          });
    }
  }
