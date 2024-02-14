import 'package:smailo/model/home/product_add/product_model.dart';

abstract class ProductAddState {}

class ProductAddInitialState extends ProductAddState {}

class ProductAddLoadingState extends ProductAddState {}

class ProductAddLoadedState extends ProductAddState {
  final ProductListModel productList;

  ProductAddLoadedState({required this.productList});
}

class ProductAddErrorState extends ProductAddState {
  final String error;

  ProductAddErrorState({required this.error});
}
