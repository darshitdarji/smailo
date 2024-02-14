import 'package:smailo/model/home/school_bottomsheet/school_modal.dart';

abstract class SchoolState {}

class SchoolInitialState extends SchoolState {}

class SchoolLoadingState extends SchoolState {}

class SchoolLoadedState extends SchoolState {
  final SchoolModel  schoolModel;
  SchoolLoadedState ({required this.schoolModel});
}

class SchoolErrorState extends SchoolState {
  final String error;
  SchoolErrorState({required this.error});
}
