import 'package:smailo/model/home/cart_creen/cart_model.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final CartListModel cartList;

  CartLoadedState({required this.cartList});
}

class CartErrorState extends CartState {
  final String error;

  CartErrorState({required this.error});
}
