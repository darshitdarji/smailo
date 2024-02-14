import 'package:smailo/model/home/removewish/removewish_model.dart';
import 'package:smailo/model/home/savewish/savewish_model.dart';

abstract class SaveAndRemoveWishState {}

class SaveToWishInitialState extends SaveAndRemoveWishState {}

class SaveToWishLoadingState extends SaveAndRemoveWishState {}

class SaveToWishLoadedState extends SaveAndRemoveWishState {
  final SaveWishListModel saveWishList;
  SaveToWishLoadedState({required this.saveWishList});
}

class SaveToWishErrorState extends SaveAndRemoveWishState {
  final String error;
  SaveToWishErrorState({required this.error});
}

class RemoveToWishLoadedState extends SaveAndRemoveWishState {
  final RemoveWishListModel removeWishList;
  RemoveToWishLoadedState({required this.removeWishList});
}

class RemoveToWishErrorState extends SaveAndRemoveWishState {
  final String error;
  RemoveToWishErrorState({required this.error});

}
