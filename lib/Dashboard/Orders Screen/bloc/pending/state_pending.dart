import 'package:smailo/model/order/pending/pending_model.dart';

abstract class PendingState {}

class PendingInitialState extends PendingState {}

class PendingLoadingState extends PendingState {}

class PendingLoadedState extends PendingState {
  final PendingListModel pendingList;

  PendingLoadedState({required this.pendingList});
}

class PendingErrorState extends PendingState {
  final String error;

  PendingErrorState({required this.error});
}
