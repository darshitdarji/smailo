  import 'package:smailo/model/home/bannerlist/bannerlist_model.dart';

  abstract class BannerState {}

  class BannerInitialState extends BannerState {}

  class BannerLoadingState extends BannerState {}

  class BannerLoadedState extends BannerState {
    final BannerListModel bannerList;

    BannerLoadedState({required this.bannerList});
  }

  class BannerErrorState extends BannerState {
    final String error;

    BannerErrorState({required this.error});
  }
