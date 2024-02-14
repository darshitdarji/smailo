import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/Profile%20Screen/Cart.dart';
import 'package:smailo/Dashboard/home/Favourite%20Screen.dart';
import 'package:smailo/Dashboard/home/bloc/board/bloc_board_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/board/event_board_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/board/state_board_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/school/bloc_school_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/school/event_school_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/school/state_school_bottomsheet.dart';

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
      ],
      child: CategoryPage(),
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
  bool educationboard = false;
  bool language = false;
  bool stand = false;
  bool Done = false;
  int schoolId = -1;
  int selectedTypeIndex = -1;

  var index;

  int selectdlanguage = -1;
  int selectedstd = -1;

  final List<Map<String, dynamic>> text = [
    {'language': 'ENGLISH'},
    {'language': 'GUJARATI'},
    {'language': 'HINDI'}
  ];
  final List<Map<String, dynamic>> std = [
    {'standerd': 'nursery'},
    {'standerd': 'Junior KG'},
    {'standerd': 'senior KG'},
    {'standerd': 'first'}
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
          title: Text(
            "Category",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavouritePage(),
                    ));
              },
              child: Icon(
                Icons.favorite,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ));
              },
              child: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            )
          ]),
      body: BlocBuilder<SchoolBloc, SchoolState>(
        builder: (context, state) {
          if (state is SchoolLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SchoolLoadedState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: mediaquery.size.height * 0.025,
                    ),
                    Text(
                      "School",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      itemCount: state.schoolModel.schoolData.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Center(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                educationboard =!educationboard;
// language=!language;
                                language = false;
                                stand = false;
                                Done = false;
                                selectdlanguage = -1;
                                selectedstd = -1;
                              });
                            },
                            child: Container(
                                height: mediaquery.size.height * 0.32,
                                width: mediaquery.size.width * 0.5,
                                decoration: BoxDecoration(
                                    color: educationboard
                                        ? Colors.blue
                                        : Colors.white,
                                    border: Border.all(color: Colors.black26),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Image.network(
                                            state.schoolModel.schoolData[index]
                                                .image,
                                            fit: BoxFit.cover,
                                            height: 160,
                                            width: 150,
                                          ),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        state
                                            .schoolModel.schoolData[index].name,
                                        maxLines: 3,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: educationboard
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: mediaquery.size.height * 0.015,
                    ),
                    if (educationboard)
                      Column(
                        children: [
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Education Board',
                              style:
                              TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 10),
                          BlocBuilder<BoardBLoc, BoardState>(
                            builder: (BuildContext context, state) {
                              if (state is BoardLoadingState) {
                                return Container();
                              } else if (state is BoardLoadedState) {
                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  height: 250,
                                  width: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                                    border: Border.all(color: Colors.black26,),
                                    color: language ? Colors.blue.shade400 : Colors.white,
                                  ),
                                  child: ListView.builder(
                                    itemCount: state.boardList.boardData.length,
                                    physics: const NeverScrollableScrollPhysics(),

                                    itemBuilder: (BuildContext context, int index) {

                                      return GestureDetector(
                                        onTap: () {
                                          schoolId =
                                              state.boardList.boardData[index].id;
                                          setState(() {
                                            language = !language;
                                            selectedstd = -1;
                                            stand = false;
                                            Done = false;
                                          });
                                          BlocProvider.of<BoardBLoc>(context)
                                              .add(FetchBoardEvent(schoolId:schoolId.toString()));
                                        },
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Image.network(
                                          state.boardList.boardData[index].image,
                                                height: 150,
                                                width: 120,
                                              ),
                                              Text(
                                                state.boardList.boardData[index].name,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: educationboard
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
                    if (language)
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Medium",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: mediaquery.size.height * 0.015,
                          ),
                          Container(
                            height: mediaquery.size.height * 0.07,
                            child: ListView.builder(
                              itemCount: text.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.all(5),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectdlanguage = index;
                                        stand = !stand;
                                        stand = true;
                                        selectedstd = -1;
                                        Done = false;
                                      });
                                    },
                                    child: Container(
                                      height: mediaquery.size.height * 0.07,
                                      width: mediaquery.size.width * 0.28,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black26),
                                          color: selectdlanguage == index
                                              ? Colors.blue
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                          child: Text(
                                        text[index]['language'],
                                        style: TextStyle(
                                            color: selectdlanguage == index
                                                ? Colors.white
                                                : Colors.black),
                                      )),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: mediaquery.size.height * 0.01,
                    ),
                    if (stand)
                      Column(children: [
                        SizedBox(
                          height: mediaquery.size.height * 0.01,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Standard",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )),
                        SizedBox(
                          height: mediaquery.size.height * 0.01,
                        ),
                        Container(
                          height: mediaquery.size.height * 0.07,
                          // width: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: std.length,
                            itemBuilder: (BuildContext context,int index) {
                              return Padding(
                                padding: EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedstd = index;
                                      Done = true;
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black26),
                                        color: selectedstd == index
                                            ? Colors.blue
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      std[index]['standerd'],
                                      style: TextStyle(
                                          color: selectedstd == index
                                              ? Colors.white
                                              : Colors.black),
                                    )),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ]),
                    SizedBox(height: 30),
                    if (Done)
                      Center(
                          child: InkWell(
                              // onTap: () {
                              //
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) =>
                              //                 ProductAddPage())).then((result) {
                              //       if (result == "clearSelection") {
                              //         setState(() {
                              //           educationboard = false;
                              //           language = false;
                              //           stand = false;
                              //           Done = false;
                              //           selectdlanguage = -1;
                              //           selectedstd = -1;
                              //         });
                              //       }
                              //     });
                              //
                              // },
                              child: Text(
                        "Done",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )))
                  ],
                ),
              ),
            );
          } else if (state is SchoolErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          ;
          return Container();
        },
      ),
    );
  }
}
