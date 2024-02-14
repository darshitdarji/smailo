import 'package:smailo/model/home/medium/medium_modal.dart';

abstract class MediumState {}

class MediumInitialState extends MediumState {}

class MediumLoadingState extends MediumState {}

class MediumLoadedState extends MediumState {
  final MediumListModal mediumModel;
  MediumLoadedState({required this.mediumModel});
}

class MediumErrorState extends MediumState {
  final String error;
  MediumErrorState ({required this.error});
}
