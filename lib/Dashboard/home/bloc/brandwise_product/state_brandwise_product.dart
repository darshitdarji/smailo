import 'package:smailo/model/home/brandwise_product_model/brandwise_product_model.dart';

abstract class BrandWiseState {}

class BrandwiseInitialState extends BrandWiseState {}

class BrandwiseLoadingState extends BrandWiseState {}

class BrandwiseLoadedState extends BrandWiseState {
  final BrandWiseListModel brandWiseList;
  BrandwiseLoadedState({required this.brandWiseList});
}

class BrandwiseErrorState extends BrandWiseState {
  final String error;
  BrandwiseErrorState({required this.error});
}
