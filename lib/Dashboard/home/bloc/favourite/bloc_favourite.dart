import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/favourite/event_favourite.dart';
import 'package:smailo/Dashboard/home/bloc/favourite/state_favourite.dart';
import 'package:smailo/model/home/favourite/favourite_model.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc() : super(FavouriteInitialState()) {
    on<FavouriteEvent>((event, emit) async {
      emit(FavouriteLoadingState());
      try {
         FavouriteListModel model = await fetchDataFromApi();
        if (model.status == 200) {
          print("status${model.status}");

          emit(
            FavouriteLoadedState(favouriteList: model),
          );
        } else {
          emit(
            FavouriteErrorState(
              error: 'An error occurred while fetching data from API',
            ),
          );
        }
      } catch (error) {
        print("error in favourite ${error}");
        emit(
          FavouriteErrorState(error: 'an error Occurred'),
        );
      }
    },
    );
  }

  fetchDataFromApi() async {
    FavouriteListModel model;
    Map data = {
      'user_id': '610'
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}wishList";
    final Uri uri = Uri.parse(apiUrl);
    final response = await http.post(uri,body: data);

    model = FavouriteListModel.fromJsonMap(jsonDecode(response.body),);
    return model;
  }
}
