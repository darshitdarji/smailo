import 'package:smailo/model/home/Features/features_modal.dart';

abstract class FeaturesState {}

class FeaturesInitialState extends FeaturesState {}

class FeaturesLoadingState extends FeaturesState {}

class FeaturesLoadedState extends FeaturesState {
  final FeaturesListModal featuresList;

  FeaturesLoadedState({required this.featuresList});
}

class FeaturesErrorState extends FeaturesState {
 final String error;

 FeaturesErrorState({required this.error});
}
