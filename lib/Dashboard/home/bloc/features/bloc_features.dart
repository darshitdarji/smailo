import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/features/event_features.dart';
import 'package:smailo/Dashboard/home/bloc/features/state_features.dart';
import 'package:smailo/model/home/Features/features_modal.dart';
import 'package:smailo/server_url/base_app_url.dart';

class FeaturesBloc extends Bloc<FeaturesEvent, FeaturesState> {
  FeaturesBloc() : super(FeaturesInitialState()) {
    on<FetchFeaturesEvent>((event, emit) async {
      emit(FeaturesLoadingState());
      try {
        FeaturesListModal model = await FeatchDataFromApi();
        if (model.status == 200) {
          emit(FeaturesLoadedState(featuresList: model));
        } else {
          emit(FeaturesErrorState(
              error: '"An error occurred while fetching data from API"'));
        }
      } catch (error) {
        print("features---->${error}");
        emit(FeaturesErrorState(error: "An error Occurred"));
      }
    });
  }

  FeatchDataFromApi() async {
    FeaturesListModal model;
    Map data = {'user_id': '610'};
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}features";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    model = FeaturesListModal.fromJsonMap(
      jsonDecode(
        response.body,
      ),
    );
    return model;
  }
}
