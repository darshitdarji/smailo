import 'package:equatable/equatable.dart';
import 'package:smailo/model/home/favourite/favourite_model.dart';

abstract class FavouriteState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavouriteInitialState extends FavouriteState {}

class FavouriteLoadingState extends FavouriteState {}

class FavouriteLoadedState extends FavouriteState {
  final FavouriteListModel favouriteList;

  FavouriteLoadedState({required this.favouriteList});

  @override
  List<Object> get props => [favouriteList];
}

class FavouriteErrorState extends FavouriteState {
  final String error;

  FavouriteErrorState({required this.error});
}
