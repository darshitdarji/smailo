import 'package:smailo/model/home/board/board_model.dart';

abstract class BoardState {}

class BoardInitialState extends BoardState {}

class BoardLoadingState extends BoardState {}

class BoardLoadedState extends BoardState {
  final BoardListModel boardList;

  BoardLoadedState({required this.boardList});
}

class BoardErrorState extends BoardState {
  final String error;

  BoardErrorState({required this.error});
}
