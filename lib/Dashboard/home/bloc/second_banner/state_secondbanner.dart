import 'package:smailo/model/home/second_banner/secondbannar_model.dart';

abstract class SecondBannerState {}

class SecondBannerInitialState extends SecondBannerState {}

class SecondBannerLoadingState extends SecondBannerState {}

class SecondBannerLoadedState extends SecondBannerState {
  final SecondBannerListModel secondBannerData;

  SecondBannerLoadedState({required this.secondBannerData});
}

class SecondBannerErrorState extends SecondBannerState {
  final String error;

  SecondBannerErrorState({required this.error});
}
