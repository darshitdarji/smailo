abstract class MediumEvent {}

class FetchMediumEvent extends MediumEvent {
  final String boardId;

  FetchMediumEvent({required this.boardId});
}
