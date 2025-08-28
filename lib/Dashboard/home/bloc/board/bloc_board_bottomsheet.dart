import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/board/event_board_bottomsheet.dart';
import 'package:smailo/Dashboard/home/bloc/board/state_board_bottomsheet.dart';
import 'package:smailo/model/home/board/board_model.dart';
import 'package:smailo/server_url/base_app_url.dart';

class BoardBLoc extends Bloc<BoardEvent, BoardState> {
  BoardBLoc() : super(BoardInitialState()) {
    on<FetchBoardEvent>((event, emit) async {
      emit(BoardLoadingState());
      try {
        BoardListModel model = await FetchdataFromApi(schoolId: event.schoolId);

        if (model.status == 200) {
          emit(BoardLoadedState(boardList: model));
        } else {
          emit(BoardErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        emit(BoardErrorState(error: "An error Occurred"));
      }
    });
  }

  FetchdataFromApi({required String schoolId}) async {
    BoardListModel model;
    Map data = {
      'school_id': schoolId,
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}board";

    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    model = BoardListModel.fromJsonMap(jsonDecode(response.body));
    return model;
  }
}
