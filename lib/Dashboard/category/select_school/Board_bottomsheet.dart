import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/board/bloc_board_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/board/event_board_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/board/state_board_bottomsheet.dart';

import 'Medium_bottomsheet.dart';

class BoardBottomSheet extends StatefulWidget {
  final String schoolId;

  const BoardBottomSheet({super.key, required this.schoolId});

  @override
  State<BoardBottomSheet> createState() => _BoardBottomSheetState();
}

class _BoardBottomSheetState extends State<BoardBottomSheet> {
  @override
  Widget build(BuildContext context) {

    return BlocProvider<BoardBLoc>(
      create: (context) => BoardBLoc(),
      child: Board(schoolId: widget.schoolId.toString(),),
    );
  }
}

class Board extends StatefulWidget {
  final String schoolId;

  Board({super.key, required this.schoolId});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BlocProvider.of<BoardBLoc>(context).add(
        FetchBoardEvent(schoolId: widget.schoolId.toString()));
    print('objectssss${widget.schoolId}');
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      maxChildSize: 0.7,
      minChildSize: 0.5,
      expand: false,
      builder: (BuildContext context, ScrollController) {
        return
          BlocBuilder<BoardBLoc, BoardState>(
            builder: (context, state) {
              print('objectssss${widget.schoolId}');

              if (state is BoardLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is BoardLoadedState) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back)),
                        SizedBox(
                          width: 90,
                        ),
                        Text("Select Board",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    ListView.builder(
                      itemCount: state.boardList.boardData.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  showDragHandle: true,
                                  context: context,
                                  barrierColor: Colors.transparent,
                                  builder: (context) {
                                    return MediumBottomsheet(boardId:state.boardList.boardData.length.toString(),);
                                  },
                                );
                              },
                              child: Container(
                                height: 40,
                                width: 350,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
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
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 5),
                                  child: Text(
                                    state.boardList.boardData[index].name
                                    , style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                        //   Padding(
                        //   padding: EdgeInsets.all(5),
                        //   child: Container(
                        //     height: 40,
                        //     width: 350,
                        //     decoration: BoxDecoration(
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.black12,
                        //             offset: Offset(
                        //               1,
                        //               4,
                        //             ),
                        //             blurRadius: 5,
                        //             spreadRadius: 0.5,
                        //           ), //BoxShadow
                        //         ],
                        //         borderRadius: BorderRadius.circular(5), color: Colors.white),
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(left: 10, top: 10),
                        //       child: Text(Standard[index]),
                        //     ),
                        //   ),
                        // );
                      },
                    ),
                  ],
                );
              } else if (state is BoardErrorState) {
                return Center(
                  child: Text(state.error),

                );
              }
              return Container();
            },
          );

        //   Column(
        //   children: [
        //     // SizedBox(height: 20,),
        //     Row(
        //       crossAxisAlignment:
        //       CrossAxisAlignment
        //           .start,
        //       children: [
        //         InkWell(
        //             onTap: () {
        //               Navigator.pop(
        //                   context);
        //             },
        //             child: Icon(Icons
        //                 .arrow_back)),
        //         SizedBox(
        //           width: 85,
        //         ),
        //         Text("Select Board",
        //             style: TextStyle(
        //                 color: Colors
        //                     .black,
        //                 fontSize: 20,
        //                 fontWeight:
        //                 FontWeight
        //                     .bold)),
        //       ],
        //     ),
        //     SizedBox(
        //       height: 20,
        //     ),
        //     InkWell(
        //       onTap: () {
        //         showModalBottomSheet(
        //           showDragHandle: true,
        //           context: context,
        //           barrierColor: Colors.transparent,
        //           builder: (context) {
        //             return Mediumbottomsheet();
        //           },
        //         );
        //       },
        //       child: Container(
        //         height: 40,
        //         width: 350,
        //         decoration:
        //         BoxDecoration(
        //             borderRadius:
        //             BorderRadius
        //                 .circular(
        //                 10),
        //             boxShadow: [
        //               BoxShadow(
        //                 color: Colors
        //                     .black26,
        //                 offset:
        //                 Offset(
        //                   1,
        //                   6,
        //                 ),
        //                 blurRadius:
        //                 8,
        //                 spreadRadius:
        //                 3,
        //               ),
        //             ],
        //             color: Colors
        //                 .white),
        //         child: Padding(
        //           padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
        //           child: Text(
        //             "GSEB",
        //             style: TextStyle(
        //                 fontSize: 15),
        //           ),
        //         ),
        //       ),
        //     )
        //   ],
        // );
      },
    );
  }
}
