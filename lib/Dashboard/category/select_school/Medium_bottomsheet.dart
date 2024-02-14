import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/medium/bloc_medium_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/medium/event_medium_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/medium/state_medium_bottomsheet.dart';

import 'Standard_bottomsheet.dart';

class MediumBottomsheet extends StatefulWidget {
  final String boardId;

  const MediumBottomsheet({super.key, required this.boardId});

  @override
  State<MediumBottomsheet> createState() => _MediumBottomsheetState();
}

class _MediumBottomsheetState extends State<MediumBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MediumBloc>(
      create: (context) => MediumBloc(),
      child: Medium(
        boardId: widget.boardId,
      ),
    );
  }
}

class Medium extends StatefulWidget {
  final String boardId;

  const Medium({super.key, required this.boardId});

  @override
  State<Medium> createState() => _MediumState();
}

class _MediumState extends State<Medium> {
  ScrollController controller = ScrollController();
  final List<String> Selectmedium = ["GUJARATI", "ENGLISH", "HINDI"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<MediumBloc>(context).add(
      FetchMedium(
        boardId: widget.boardId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      // maxChildSize: 0.7,ss
      expand: false,
      builder: (BuildContext context, ScrollController) {
        return BlocBuilder<MediumBloc, MediumState>(
          builder: (context, state) {
            if (state is MediumLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MediumLoadedState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                          ),
                        ),
                        SizedBox(
                          width: 85,
                        ),
                        Text(
                          "Select Medium",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: ListView.builder(
                        controller: controller,
                        itemCount: state.mediumModel.mediumData.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(5),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  showDragHandle: true,
                                  barrierColor: Colors.transparent,
                                  builder: (context) {
                                    return StandardBottomsheet(
                                      mediumId: state
                                          .mediumModel.mediumData[index].id
                                          .toString(),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 40,
                                width: 350,
                                decoration: BoxDecoration(
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
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 12),
                                  child: Text(
                                    state.mediumModel.mediumData[index].name,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            } else if (state is MediumErrorState) {
              return Center(
                child: Text(state.error),
              );
            }
            return Container();
          },
        );
      },
    );
  }
}
