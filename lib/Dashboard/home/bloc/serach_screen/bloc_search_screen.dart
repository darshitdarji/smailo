import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/home/bloc/serach_screen/event_search_screen.dart';
import 'package:smailo/Dashboard/home/bloc/serach_screen/state_search_screen.dart';
import 'package:smailo/model/home/search_screen/search_screen_model.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitialState()) {
    on<FetchSearchEvent>(
      (event, emit) async {
        emit(SearchLoadingState());
        try {
          SearchListModel model =
              await fetchDataFromApi(keyword: event.keyword);
          if (model.status == 200) {
            emit(
              SearchLoadedState(
                searchList: model,
              ),
            );
          } else {
            emit(
              SearchErrorState(
                error: 'An error occurred while fetching data from API',
              ),
            );
          }
        } catch (error) {
          emit(SearchErrorState(error: 'An Error Occurred'));
        }
      },
    );
  }

  fetchDataFromApi({required String keyword}) async {
    SearchListModel model;
    Map data = {
      'keyword': keyword,
      'user_id': '1760',
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}search";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    model = SearchListModel.fromJsonMap(
      jsonDecode(
        response.body,
      ),
    );

    return model;
  }
}
