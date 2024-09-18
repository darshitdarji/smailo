import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/model/home/Today_deal/today_deal_model.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'event_today_deal.dart';
import 'state_today_deal.dart';

class TodayDealBloc extends Bloc<TodayDealEvent, TodayDealState> {
  TodayDealBloc() : super(TodayDealInitialState()) {
    on<FetchTodayDealEvent>((event, emit) async {
      emit(TodayDealLoadingState());
      try {
        TodayDealModel model = await fetchDataFromApi();
        if (model.status == 200) {
          emit(TodayDealLoadedState(todayDeal: model));
        } else {
          emit(TodayDealErrorState(
              error: "An error occurred while fetching data from API"));
        }
      } catch (error) {
        print("todays deal${error}");
        emit(TodayDealErrorState(error: "An error Occurred"));
      }
    });
  }

  fetchDataFromApi() async {
    TodayDealModel model;
    Map data = {
      'user_id': '610',
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}todaysDeal";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    model = TodayDealModel.fromJsonMap(jsonDecode(response.body));
    return model;
  }
}
