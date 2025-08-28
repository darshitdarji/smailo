import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/medium/event_medium_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/medium/state_medium_bottomsheet.dart';
import 'package:smailo/model/home/medium/medium_modal.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class MediumBloc extends Bloc<MediumEvent, MediumState> {
  MediumBloc() : super(MediumInitialState()) {
    on<FetchMediumEvent>(
      (event, emit) async {
        emit(MediumLoadingState());
        try {
          MediumListModal model =
              await fetchDataFromApi(boardId: event.boardId);
          if (model.status == 200) {
            print("medium${model.status}");

            emit(
              MediumLoadedState(
                mediumModel: model,
              ),
            );
          } else {
            emit(
              MediumErrorState(
                error: 'An error occurred while fetching data from API',
              ),
            );
          }
        } catch (error) {
          print("medium$error");
          emit(
            MediumErrorState(
              error: "An Error Occurred",
            ),
          );
        }
      },
    );
  }

  fetchDataFromApi({required String boardId}) async {
    MediumListModal model;
    Map data = {
      'board_id': boardId,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}medium";

    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    model = MediumListModal.fromJsonMap(jsonDecode(response.body));
    return model;
  }
}
