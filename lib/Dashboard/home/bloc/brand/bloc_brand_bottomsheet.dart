import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/brand/event_barnd_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/brand/state_brand_bottomsheet.dart';
import 'package:smailo/model/home/brand/brand_modal.dart';
import 'package:smailo/server_url/base_app_url.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  BrandBloc() : super(BrandInitialState()) {
    on<FetchBrandEvent>((event, emit) async {
      emit(BrandLoadingState());
      try {
        BrandListModel model = await fetchDataFromApi();
        if (model.status == 200) {
          emit(BrandLoadedState(brandList: model));
        } else {
          emit(BrandErrorState(
              error: "An error occurred while fetching data from API"));
        }
      } catch (error) {
        emit(BrandErrorState(error: "An error Occurred"));
      }
    });
  }

  fetchDataFromApi() async {
    BrandListModel model;
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}brands";

    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url);
    model = BrandListModel.fromJasonMap(jsonDecode(response.body));
    return model;
  }
}
