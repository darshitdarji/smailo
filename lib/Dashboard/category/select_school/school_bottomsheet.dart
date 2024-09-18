import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/school/bloc_school_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/school/event_school_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/school/state_school_bottomsheet.dart';

import 'Board_bottomsheet.dart';

class schoolBottomSheet extends StatefulWidget {
  const schoolBottomSheet({super.key});

  @override
  State<schoolBottomSheet> createState() => _schoolBottomSheetState();
}

class _schoolBottomSheetState extends State<schoolBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SchoolBloc>(
      create: (context) => SchoolBloc(),
      child:const School(),
    );
  }
}

class School extends StatefulWidget {
  const School({super.key});

  @override
  State<School> createState() => _SchoolState();
}

class _SchoolState extends State<School> {
  ScrollController controller = ScrollController();
  final List<String> Standard = [
    '1',
    '2',
    '610',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
       BlocProvider.of<SchoolBloc>(context).add(FetchSchoolEvent());
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      builder: (BuildContext context, ScrollController) {
      //  BlocProvider.of<SchoolBloc>(context).add(FetchSchoolEvent());
        return BlocBuilder<SchoolBloc,SchoolState>(
            builder: (context, state) {

              if(state is SchoolLoadingState){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }else if(state is SchoolLoadedState) {
                return  Column(
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
                        Text( "Select School",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),

                    ListView.builder(
                      // controller: scrollController,
                      itemCount: state.schoolModel.schoolData.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return
                          Container(
                          // height: 100,
                          width: double.infinity,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    barrierColor: Colors.transparent,
                                    showDragHandle: true,
                                    builder: (context) {
                                      return  BoardBottomSheet(schoolId:state.schoolModel.schoolData[index].id.toString(),
                                      );
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
                                          color: Colors.black12,
                                          offset: Offset(
                                            1,
                                            6,
                                          ),
                                          blurRadius: 8,
                                          spreadRadius: 3,
                                        ),
                                      ],
                                      color: Colors.white),
                                  child: Center(
                                      child: Text(
                                        state.schoolModel.schoolData[index].name,
                                        style: TextStyle(fontSize: 15),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
            }else if(state is SchoolErrorState){
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
