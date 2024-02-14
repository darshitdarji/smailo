import 'package:smailo/model/home/standard/standard_modal.dart';

abstract class StandardState {}

class StandardInitialState extends StandardState {}

class StandardLoadingState extends StandardState {}

class StandardLoadedState extends StandardState {
  final StandardListModel standardList;

  StandardLoadedState({required this.standardList});
}

class StandardErrorState extends StandardState {
  final String error;

  StandardErrorState({required this.error});
}
