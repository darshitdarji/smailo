import 'package:smailo/model/home/checkout/checkout_model.dart';

abstract class CheckoutState {}

class CheckoutInitialState extends CheckoutState {}

class CheckoutLoadingState extends CheckoutState {}

class CheckoutLoadedState extends CheckoutState {
  final CheckoutListModel checkoutList;

  CheckoutLoadedState({required this.checkoutList});
}

class CheckoutErrorState extends CheckoutState {
  final String error;

  CheckoutErrorState({required this.error});
}
