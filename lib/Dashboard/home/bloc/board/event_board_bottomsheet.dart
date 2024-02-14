abstract class BoardEvent {}

class FetchBoardEvent extends BoardEvent {
  final String schoolId;

  FetchBoardEvent ({required this.schoolId});

}
