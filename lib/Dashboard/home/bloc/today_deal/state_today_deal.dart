import 'package:smailo/model/home/Today_deal/today_deal_model.dart';

abstract class TodayDealState {}

class TodayDealInitialState extends TodayDealState {}

class TodayDealLoadingState extends TodayDealState {}

class TodayDealLoadedState extends TodayDealState {
  final TodayDealModel todayDeal;

  TodayDealLoadedState({
    required this.todayDeal,
  });
}

class TodayDealErrorState extends TodayDealState {
  final String error;

  TodayDealErrorState({required this.error});
}
