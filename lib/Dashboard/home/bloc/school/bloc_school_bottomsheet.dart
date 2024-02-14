import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/school/event_school_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/school/state_school_bottomsheet.dart';
import 'package:smailo/model/home/school_bottomsheet/school_modal.dart';
import 'package:smailo/server_url/base_app_url.dart';

class SchoolBloc extends Bloc<SchoolEvent, SchoolState> {
  SchoolBloc() : super(SchoolInitialState()) {
    on<SchoolEvent>((event, emit) async {
      emit(SchoolLoadingState());
      try {
        SchoolModel model = await fetchDatafromApi();
        if (model.status == 200) {
          emit(SchoolLoadedState(schoolModel: model));
        } else {
          emit(SchoolErrorState(
              error: "An error occurred while fetching data from API"));
        }
      } catch (error) {
        emit(SchoolErrorState(error: "An Error Occurred"));
      }
    });
  }

  fetchDatafromApi() async {
    SchoolModel model;
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}school";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url);
    model = SchoolModel.fromJsonMap(jsonDecode(response.body));
    return model;
  }
}
