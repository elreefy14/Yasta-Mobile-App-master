part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}


final class GetFilteredWorkshopLoadingState extends SearchState {}

class GetFilteredWorkshopSuccessState extends SearchState {
  final GetFilteredWorkshopResponse? data;
  GetFilteredWorkshopSuccessState({this.data});
}

final class GetFilteredWorkshopErrorState extends SearchState {
  final String message;
  GetFilteredWorkshopErrorState({required this.message});
}


final class CarLoadingState extends SearchState {}

class CarSuccessState extends SearchState {
  final ShowCarResponse? data;
  CarSuccessState({this.data});
}

final class CarErrorState extends SearchState {
  final String message;
  CarErrorState({required this.message});
}
