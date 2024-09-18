import 'package:smailo/Dashboard/Orders%20Screen/Tabbar%20screens/Panding.dart';
import 'package:smailo/model/order/pending/pending_model.dart';

abstract class ConfirmedState {}

class ConfirmedInitialState extends ConfirmedState {}

class ConfirmedLoadingState extends ConfirmedState {}

class ConfirmedLoadedState extends ConfirmedState {
  final PendingListModel pendingList;
  ConfirmedLoadedState({required this.pendingList});
}

class ConfirmedErrorState extends ConfirmedState {
  final String error;

  ConfirmedErrorState({required this.error});
}
