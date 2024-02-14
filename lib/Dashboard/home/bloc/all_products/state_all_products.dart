import 'package:smailo/model/home/all_products/all_products_model.dart';

abstract class AllProductsState{}
class AllProductsInitialState extends AllProductsState{}
class AllProductsLoadingState extends AllProductsState{}
class AllProductsLoadedState extends AllProductsState{
  final AllProductsListModel allProductsList;
  AllProductsLoadedState({required this.allProductsList});
}
class AllProductsErrorState extends AllProductsState{
  final String error;
  AllProductsErrorState({required this.error});
}
