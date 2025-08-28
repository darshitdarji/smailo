import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/Cart.dart';
import 'package:smailo/Dashboard/category/select_school/Product%20Add%20Bottomsheet.dart';
import 'package:smailo/Dashboard/home/Favourite%20Screen.dart';
import 'package:smailo/Dashboard/home/bloc/board/bloc_board_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/board/event_board_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/board/state_board_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/bloc_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/event_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/state_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/medium/bloc_medium_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/medium/event_medium_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/medium/state_medium_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/product_add/bloc_product_add.dart';
import 'package:smailo/Dashboard/home/bloc/product_add/event_product_add.dart';
import 'package:smailo/Dashboard/home/bloc/school/bloc_school_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/school/event_school_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/school/state_school_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/standeard/bloc_standard_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/standeard/event_standard_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/standeard/state_standard_bottomsheet.dart';

class Category extends StatefulWidget {
  const Category({
    super.key,
  });

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SchoolBloc>(
          create: (context) => SchoolBloc(),
        ),
        BlocProvider<BoardBLoc>(
          create: (context) => BoardBLoc(),
        ),
        BlocProvider<MediumBloc>(
          create: (context) => MediumBloc(),
        ),
        BlocProvider<HomeCountBloc>(
          create: (context) => HomeCountBloc(),
        ),
        BlocProvider<StandardBloc>(
          create: (context) => StandardBloc(),
        ),
        BlocProvider<ProductAddBloc>(
          create: (context) => ProductAddBloc(),
        ),
      ],
      child: const CategoryPage(),
    );
  }
}

class CategoryPage extends StatefulWidget {
  const CategoryPage({
    super.key,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool educationBoard = false;
  bool language = false;
  bool standard = false;
  bool done = false;
  int schoolId = -1;
  int selectedTypeIndex = -1;
  int mediumId = -1;
  int boardId = -1;
  int selectedLanguage = -1;
  int selectedStandard = -1;
  int standardId = -1;
  int selectedMedium = -1;
  int selectedStdIndex = -1;

  final List<Map<String, dynamic>> std = [
    {'standard': 'nursery'},
    {'standard': 'Junior KG'},
    {'standard': 'senior KG'},
    {'standard': 'first'}
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SchoolBloc>(context).add(FetchSchoolEvent());
    BlocProvider.of<BoardBLoc>(context).add(
      FetchBoardEvent(
        schoolId: schoolId.toString(),
      ),
    );
    BlocProvider.of<MediumBloc>(context).add(FetchMediumEvent(
      boardId: mediumId.toString(),
    ));
    BlocProvider.of<HomeCountBloc>(context).add(FetchHomeCountEvent());
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    mediaquery = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Colors.blue, Colors.blue.shade800])),
          ),
          title: const Text(
            "Category",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                              decoration: const BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                      state
                                          .homeCountlist.countData.favoriteCount
                                          .toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
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
                                  builder: (context) => const CartScreen(),
                                ));
                              },
                              icon: const Icon(
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
                                  decoration: const BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: Center(
                                      child: Text(
                                          state
                                              .homeCountlist.countData.cartCount
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)))),
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
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<SchoolBloc, SchoolState>(
                builder: (BuildContext context, state) {
                  if (state is SchoolLoadingState) {
                    return SizedBox(
                      height: mediaquery.size.height * 0.045,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is SchoolLoadedState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: mediaquery.size.height * 0.025,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Text(
                            'School',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: mediaquery.size.height * 0.015,
                        ),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: mediaquery.size.height * 0.3,
                            width: mediaquery.size.width * 0.5,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border:
                                  Border.all(color: Colors.black38, width: 0.2),
                              color: educationBoard
                                  ? Colors.blue.shade400
                                  : Colors.white,
                            ),
                            child: ListView.builder(
                              itemCount: state.schoolModel.schoolData.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    schoolId =
                                        state.schoolModel.schoolData[index].id;

                                    setState(() {
                                      educationBoard = !educationBoard;
                                      language = false;
                                      standard = false;
                                      done = false;
                                      selectedLanguage = -1;
                                      selectedStandard = -1;
                                    });

                                    BlocProvider.of<BoardBLoc>(context).add(
                                        FetchBoardEvent(
                                            schoolId: schoolId.toString()));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Image.network(
                                          state.schoolModel.schoolData[index]
                                              .image,
                                          fit: BoxFit.cover,
                                          height: 150,
                                          width: 150,
                                        ),
                                        SizedBox(
                                          height: mediaquery.size.height * 0.01,
                                        ),
                                        Text(
                                          state.schoolModel.schoolData[index]
                                              .name,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: educationBoard
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state is SchoolErrorState) {
                    return Center(
                      child: Text(state.error),
                    );
                  }
                  return Container();
                },
              ),

              SizedBox(height: mediaquery.size.height * 0.05),
              if (educationBoard)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        'Education Board',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<BoardBLoc, BoardState>(
                      builder: (BuildContext context, state) {
                        if (state is BoardLoadingState) {
                          return Container();
                        } else if (state is BoardLoadedState) {
                          return Center(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              height: mediaquery.size.height * 0.3,
                              width: mediaquery.size.width * 0.5,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    color: Colors.black38, width: 0.2),
                                color: language
                                    ? Colors.blue.shade400
                                    : Colors.white,
                              ),
                              child: ListView.builder(
                                itemCount: state.boardList.boardData.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      selectedMedium =
                                          state.boardList.boardData[index].id;
                                      setState(() {
                                        selectedLanguage = -1;
                                        language = !language;
                                        selectedTypeIndex = -1;
                                        standard = false;
                                        done = false;
                                      });
                                      BlocProvider.of<MediumBloc>(context).add(
                                          FetchMediumEvent(
                                              boardId:
                                                  selectedMedium.toString()));
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: mediaquery.size.height * 0.01,
                                        ),
                                        Image.network(
                                          state
                                              .boardList.boardData[index].image,
                                          fit: BoxFit.fitHeight,
                                          height: 150,
                                          width: 160,
                                        ),
                                        SizedBox(
                                          height: mediaquery.size.height * 0.02,
                                        ),
                                        Text(
                                          state.boardList.boardData[index].name,
                                          style: TextStyle(
                                            fontSize: 22,
                                            color: language
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        } else if (state is BoardErrorState) {
                          return Center(
                            child: Text(state.error),
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              SizedBox(height: mediaquery.size.height * 0.05),

              if (language)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: mediaquery.size.height * 0.015,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        "Medium",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: mediaquery.size.height * 0.015,
                    ),
                    BlocBuilder<MediumBloc, MediumState>(
                      builder: (context, state) {
                        if (state is MediumLoadingState) {
                          return Container();
                        } else if (state is MediumLoadedState) {
                          return SizedBox(
                            height: mediaquery.size.height * 0.07,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.mediumModel.mediumData.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: InkWell(
                                    onTap: () {
                                      standardId = state
                                          .mediumModel.mediumData[index].id;
                                      setState(() {
                                        selectedLanguage = index;
                                        standard = !standard;
                                        standard = true;
                                        selectedStdIndex = -1;
                                        done = false;
                                      });
                                      BlocProvider.of<StandardBloc>(context)
                                          .add(FetchStandardEvent(
                                              mediumId: standardId.toString()));
                                    },
                                    child: Container(
                                      height: 40,
                                      width: mediaquery.size.width * 0.4,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black12),
                                        color: selectedLanguage == index
                                            ? Colors.blue
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Center(
                                          child: Text(
                                        state
                                            .mediumModel.mediumData[index].name,
                                        style: TextStyle(
                                            // color: Colors.black
                                            color: selectedLanguage == index
                                                ? Colors.white
                                                : Colors.black),
                                      )),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (state is MediumErrorState) {
                          return Center(
                            child: Text(state.error),
                          );
                        }
                        return Container();
                      },
                    )
                  ],
                ),
              SizedBox(height: mediaquery.size.height * 0.05),

              if (standard)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        "Standard",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mediaquery.size.height * 0.015,
                    ),
                    BlocBuilder<StandardBloc, StandardState>(
                      builder: (BuildContext context, state) {
                        if (state is StandardLoadingState) {
                          // print('Loading:');
                          return Container();
                        } else if (state is StandardLoadedState) {
                          return SizedBox(
                            height: mediaquery.size.height * 0.06,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.standardList.standardData.length,
                              itemBuilder: (BuildContext context, int index) {
                                // print("BoardId:$selectedMedium");
                                return GestureDetector(
                                  onTap: () {
                                    standardId = state
                                        .standardList.standardData[index].id;
                                    setState(() {
                                      selectedStdIndex = index;
                                      done = true;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(
                                          color: Colors.black38, width: 0.2),
                                      color: selectedStdIndex == index
                                          ? Colors.blue.shade400
                                          : Colors.white,
                                    ),
                                    margin: const EdgeInsets.all(5),
                                    child: Center(
                                      child: Text(
                                        state.standardList.standardData[index]
                                            .name,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: selectedStdIndex == index
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (state is StandardErrorState) {
                          return Center(
                            child: Text(state.error),
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),

              // Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //   SizedBox(
              //     height: mediaquery.size.height * 0.01,
              //   ),
              //   const Padding(
              //     padding: EdgeInsets.only(left: 25),
              //     child: Text(
              //       "Standard",
              //       style: TextStyle(
              //           color: Colors.black,
              //           fontWeight: FontWeight.w500,
              //           fontSize: 20),
              //     ),
              //   ),
              //   SizedBox(
              //     height: mediaquery.size.height * 0.015,
              //   ),
              //   BlocBuilder<StandardBloc, StandardState>(
              //     builder: (context, state) {
              //
              //       if (state is StandardLoadingState) {
              //         return Container();
              //       } else if (state is StandardLoadedState) {
              //         return SizedBox(
              //           height: 60,
              //
              //           // height: mediaquery.size.height * 0.07,
              //           child: ListView.builder(
              //           //  shrinkWrap: true,
              //             itemCount: state.standardList.standardData.length,
              //             scrollDirection: Axis.horizontal,
              //             itemBuilder: (BuildContext context, int index) {
              //
              //
              //
              //
              //
              //               return InkWell(
              //                 onTap: () {
              //                   standardId = state
              //                       .standardList.standardData[index].id;
              //                   // BlocProvider.of<StandardBloc>(context).add(
              //                   //   FetchStandardEvent(
              //                   //     mediumId: standardId.toString(),
              //                   // / ),
              //                   // );
              //                   setState(() {
              //                     selectedStandard = index;
              //                     done = false;
              //                   });
              //                 },
              //                 child: Container(
              //                   height: 40,
              //                   width: 120,
              //                   decoration: BoxDecoration(
              //                     border: Border.all(color: Colors.black38),
              //                     color: selectedStandard == index
              //                         ? Colors.blue
              //                         : Colors.white,
              //                     borderRadius: BorderRadius.circular(10),
              //                   ),
              //                   child: Center(
              //                       child: Text(
              //                     state.standardList.standardData[index]
              //                         .name,
              //                     style: TextStyle(
              //                         // color: Colors.black
              //                         color: selectedStandard == index
              //                             ? Colors.white
              //                             : Colors.black),
              //                   )),
              //                 ),
              //               );
              //             },
              //           ),
              //         );
              //       } else if (state is StandardErrorState) {
              //         return Center(
              //           child: Text(state.error),
              //         );
              //       }
              //       return Container();
              //     },
              //   ),
              // ]),
              const SizedBox(height: 30),
              if (done)
                Center(
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<ProductAddBloc>(context).add(
                        FetchProductAdd(standardId: standardId.toString()),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductAddScreen(
                              standardId: standardId.toString()),
                        ),
                      ).then((result) {
                        setState(() {
                          educationBoard = false;
                          language = false;
                          standard = false;
                          done = false;
                          selectedLanguage = -1;
                          selectedStandard = -1;
                        });
                      });
                    },
                    child: const Text(
                      "Done",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        ));
  }
}
