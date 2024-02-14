import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/second_banner/event_secondbanner.dart';
import 'package:smailo/Dashboard/home/bloc/second_banner/state_secondbanner.dart';
import 'package:smailo/model/home/second_banner/secondbannar_model.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class SecondBannerBloc extends Bloc<SecondBannerEvent, SecondBannerState> {
  SecondBannerBloc() : super(SecondBannerInitialState()) {
    on<FetchSecondBannerEvent>(
      (event, emit) async {
        emit(SecondBannerLoadingState());
        try {
          SecondBannerListModel model = await FetchDataFromApi();
          if (model.status == 200) {
            emit(
              SecondBannerLoadedState(secondBannerData: model),
            );
          } else {
            emit(
              SecondBannerErrorState(
                error: 'An error occurred while fetching data from API',
              ),
            );
          }
        } catch (error) {
          emit(
            SecondBannerErrorState(
              error: 'An Error Occurred',
            ),
          );
        }
      },
    );
  }

  FetchDataFromApi() async {
    final SecondBannerListModel model;
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}secondBannerList";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url);

    model = SecondBannerListModel.fromJsonMap(jsonDecode(response.body,),);
    return model;
  }
}
