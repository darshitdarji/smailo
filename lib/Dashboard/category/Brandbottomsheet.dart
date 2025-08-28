import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/brand/bloc_brand_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/brand/event_barnd_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/brand/state_brand_bottomsheet.dart';
import 'Brandscreen.dart';

class BranBottomSheet extends StatefulWidget {
  const BranBottomSheet({super.key});

  @override
  State<BranBottomSheet> createState() => _BranBottomSheetState();
}

class _BranBottomSheetState extends State<BranBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrandBloc>(
      create: (context) => BrandBloc(),
      child: Brand(),
    );
  }
}

class Brand extends StatefulWidget {
  const Brand({super.key});

  @override
  State<Brand> createState() => _BrandState();
}

class _BrandState extends State<Brand> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BrandBloc>(context).add(FetchBrandEvent());
  }

  bool isselected = false;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.7,
      snap: true,
      minChildSize: 0.4,
      expand: false,
      builder: (context, scrollController) {
        return BlocBuilder<BrandBloc, BrandState>(
          builder: (context, state) {
            if (state is BrandLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is BrandLoadedState) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4)),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: state.brandList.branData.length,
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
                              builder: (context) => BrandwiseScreen(
                                  brandId: state.brandList.branData[index].id
                                      .toString()),
                            ),
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 350,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(
                                  1,
                                  4,
                                ),
                                blurRadius: 5,
                                spreadRadius: 0.5,
                              ), //BoxShadow
                            ],
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              top: 12,
                            ),
                            child: Text(
                              state.brandList.branData[index].name,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is BrandErrorState) {
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
