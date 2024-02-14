import 'package:smailo/model/home/flash_deal/flash_deal_model.dart';

abstract class FlashDealState {}

class FlashDealInitialState extends FlashDealState {}

class FlashDealLoadingState extends FlashDealState {}

class FlashDealLoadedState extends FlashDealState {
  final FlashDealModel flashDealModel;

  FlashDealLoadedState({required this.flashDealModel});
}

class FlashDealErrorState extends FlashDealState {
  final String error;

  FlashDealErrorState({required this.error});
}
