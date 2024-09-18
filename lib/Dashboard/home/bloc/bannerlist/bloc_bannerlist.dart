import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/bannerlist/event_bannerlist.dart';
import 'package:smailo/Dashboard/home/bloc/bannerlist/state_bannerlist.dart';
import 'package:smailo/model/home/bannerlist/bannerlist_model.dart';
import 'package:http/http.dart' as http;
import 'package:smailo/server_url/base_app_url.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc() : super(BannerInitialState()) {
    on<FetchBannerEvent>((event, emit) async {
      emit(BannerLoadingState());
      try {
        BannerListModel model = await fetchDataFromApi();
        if (model.status == 200) {
          emit(BannerLoadedState(bannerList: model));
        } else {
          emit(BannerErrorState(
              error: "An error occurred while fetching data from API"));
        }
      } catch (error) {
        emit(BannerErrorState(error: "An error Occurred"));
      }
    });
  }

  fetchDataFromApi() async {
    BannerListModel model;
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}bannerList";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url);
    model = BannerListModel.fromJsonMap(jsonDecode(response.body));
    return model;
  }
}
