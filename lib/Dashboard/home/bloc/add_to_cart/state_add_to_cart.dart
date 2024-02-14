import 'package:smailo/model/home/add_to_cart/addtocart_model.dart';
import 'package:smailo/model/home/remove_cart/remove_cart_model.dart';

abstract class AddToCartState {}

class AddToCartInitialState extends AddToCartState {}

class AddToCartLoadingState extends AddToCartState {}

class AddToCartLoadedState extends AddToCartState {
  final AddToCartListModel addToCartList;

  AddToCartLoadedState({required this.addToCartList});
}

class AddToCartErrorState extends AddToCartState {
  final String error;

  AddToCartErrorState({required this.error});
}

class RemoveToCartLoadedState extends AddToCartState {
final RemoveToCartListModel removeToCartList;

RemoveToCartLoadedState({required this.removeToCartList});
}

class RemoveToCartErrorState extends AddToCartState {
  final String error;

  RemoveToCartErrorState({required this.error});
}

