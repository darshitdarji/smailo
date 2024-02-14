import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/event_home_count.dart';
import 'package:smailo/Dashboard/home/bloc/home_count/state_home_count.dart';
import 'package:smailo/model/home/home_count/home_count_model.dart';
import 'package:smailo/server_url/base_app_url.dart';

class HomeCountBloc extends Bloc<HomeCountEvent, HomeCountState> {
  HomeCountBloc() : super(HomeCountInitialState()) {
    on<FetchHomeCountEvent>((event, emit) async {
      emit(HomeCountLoadingState());
      try {
        final HomeCountListModel model = await FetchDataFromApi();
        if (model.status == 200) {
          emit(
            HomeCountLoadedState(homeCountlist: model),
          );
        } else {
          emit(
            HomeCountErrorState(error: 'An error occurred while fetching data from API'),
          );
        }
      } catch (error) {
        emit(HomeCountErrorState(error: 'An Error Occurred'));
      }
    });
  }

  FetchDataFromApi() async {
    HomeCountListModel model;
    Map data = {
      'user_id': '3'
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}homeCount";
    final Uri url  = Uri.parse(apiUrl);
    final response = await http.post(url , body: data);
    model = HomeCountListModel.fromJsonMap(jsonDecode(response.body));
    return model;
  }
}
