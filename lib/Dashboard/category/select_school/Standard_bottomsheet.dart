import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/category/select_school/Product%20Add%20Bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/standeard/bloc_standard_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/standeard/event_standard_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/standeard/state_standard_bottomsheet.dart';

class StandardBottomsheet extends StatefulWidget {
  final String mediumId;

  const StandardBottomsheet({super.key, required this.mediumId});

  @override
  State<StandardBottomsheet> createState() => _StandardBottomsheetState();
}

class _StandardBottomsheetState extends State<StandardBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StandardBloc>(
      create: (context) => StandardBloc(),
      child: Standards(
        mediumId: widget.mediumId,
      ),
    );
  }
}

class Standards extends StatefulWidget {
  final String mediumId;

  const Standards({super.key, required this.mediumId});

  @override
  State<Standards> createState() => _StandardsState();
}

class _StandardsState extends State<Standards> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<StandardBloc>(context).add(
      FetchStandardEvent(
        mediumId: widget.mediumId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      expand: false,
      snap: true,
      builder: (BuildContext context, ScrollController) {
        return BlocBuilder<StandardBloc, StandardState>(
          builder: (context, state) {
            if (state is StandardLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is StandardLoadedState) {
              return Column(
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
                        "Select Standard",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 10,
                            ),
                            child: SingleChildScrollView(
                              child: ListView.builder(
                                controller: controller,
                                itemCount:
                                    state.standardList.standardData.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.all(5),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).popUntil(
                                          (route) => route.isFirst,
                                        );
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductAddScreen(
                                              standardId: state.standardList
                                                  .standardData[index].id
                                                  .toString(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 350,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(1, 6),
                                              blurRadius: 8,
                                              spreadRadius: 3,
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            top: 13,
                                            bottom: 10,
                                          ),
                                          child: Text(
                                            state.standardList
                                                .standardData[index].name,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is StandardErrorState) {
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
