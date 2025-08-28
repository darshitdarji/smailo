import 'package:smailo/model/home/product_add/product_model.dart';
import 'package:smailo/model/home/product_details/product_detail_model.dart';

abstract class ProductDetailState {}

class ProductDetailInitialState extends ProductDetailState {}

class ProductDetailLoadingState extends ProductDetailState {}

class ProductDetailLoadedState extends ProductDetailState {
  final ProductDetailListModel productList;

  ProductDetailLoadedState({required this.productList});
}

class ProductDetailErrorState extends ProductDetailState {
  final String error;

  ProductDetailErrorState({required this.error});
}
