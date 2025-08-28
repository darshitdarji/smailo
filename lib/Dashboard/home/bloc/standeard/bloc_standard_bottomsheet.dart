import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/standeard/event_standard_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/standeard/state_standard_bottomsheet.dart';
import 'package:smailo/model/home/standard/standard_modal.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class StandardBloc extends Bloc<StandardEvent, StandardState> {
  StandardBloc() : super(StandardInitialState()) {
    on<FetchStandardEvent>((event, emit) async {
      emit(StandardLoadingState());
      try {
        StandardListModel model = await fetchDataApi(mediumId: event.mediumId);
        if (model.status == 200) {
          emit(StandardLoadedState(standardList: model));
        } else {
          emit(
            StandardErrorState(
                error: 'An error occurred while fetching data from API'),
          );
        }
      } catch (error) {
        emit(StandardErrorState(error: 'An Error Occurred'));
      }
    });
  }

  fetchDataApi({required String mediumId}) async {
    StandardListModel model;
    Map data = {
      'medium_id': mediumId,
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}standerd";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    model = StandardListModel.fromJsonMap(jsonDecode(response.body));
    return model;
  }
}
