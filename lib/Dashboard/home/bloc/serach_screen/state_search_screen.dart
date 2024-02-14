import 'package:smailo/model/home/search_screen/search_screen_model.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final SearchListModel searchList;

  SearchLoadedState({required this.searchList});
}

class SearchErrorState extends SearchState {
  final String error;

  SearchErrorState({required this.error});
}
