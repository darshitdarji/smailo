import 'package:smailo/model/home/brand/brand_modal.dart';

abstract class BrandState {}

class BrandInitialState extends BrandState {}

class BrandLoadingState extends BrandState {}

class BrandLoadedState extends BrandState {
  final BrandListModel brandList;

  BrandLoadedState({required this.brandList});
}

class BrandErrorState extends BrandState {
  final String error;

  BrandErrorState({required this.error});
}
