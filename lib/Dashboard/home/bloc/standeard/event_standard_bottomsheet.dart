abstract class StandardEvent {}

class FetchStandardEvent extends StandardEvent {
  final String mediumId;
  FetchStandardEvent({required this.mediumId});
}
