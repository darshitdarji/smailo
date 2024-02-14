import 'package:smailo/model/offer/offer_model.dart';

abstract class OfferState {}

class OfferInitialState extends OfferState {}

class OfferLoadingState extends OfferState {}

class OfferLoadedState extends OfferState {
  final OfferListModel offerList;

  OfferLoadedState({required this.offerList});
}

class OfferErrorState extends OfferState {
  final String error;

  OfferErrorState({required this.error});
}
