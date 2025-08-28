import 'package:smailo/model/home/home_count/home_count_model.dart';

abstract class HomeCountState {}

class HomeCountInitialState extends HomeCountState {}

class HomeCountLoadingState extends HomeCountState {}

class HomeCountLoadedState extends HomeCountState {
  final HomeCountListModel homeCountlist;

  HomeCountLoadedState({required this.homeCountlist});
}

class HomeCountErrorState extends HomeCountState {
  final String error;

  HomeCountErrorState({required this.error});
}
