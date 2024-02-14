abstract class SearchEvent {}

class FetchSearchEvent extends SearchEvent {
  final String keyword;

  FetchSearchEvent({required this.keyword});
}
