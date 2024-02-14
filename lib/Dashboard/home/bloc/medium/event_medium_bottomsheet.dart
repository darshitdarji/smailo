abstract class MediumEvent {}

class FetchMedium extends MediumEvent {
  final String boardId;

  FetchMedium({required this.boardId});

}
