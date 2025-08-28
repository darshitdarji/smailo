import 'package:smailo/model/order/cancelled/cancelled-model.dart';

abstract class CancelledState {}

class CancelledInitialState extends CancelledState {}

class CancelledLoadingState extends CancelledState {}

class CancelledLoadedState extends CancelledState {
  CancelledListModel cancelledList;

  CancelledLoadedState({required this.cancelledList});
}

class CancelledErrorState extends CancelledState {
  final String error;

  CancelledErrorState({required this.error});
}
