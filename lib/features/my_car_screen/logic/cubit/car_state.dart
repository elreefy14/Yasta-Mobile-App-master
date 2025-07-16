part of 'car_cubit.dart';

@immutable
sealed class CarState {}

final class CarInitial extends CarState {}
final class CarLoadingState extends CarState {}

class CarSuccessState extends CarState {
  final ShowCarResponse? data;
  CarSuccessState({this.data});
}

final class CarErrorState extends CarState {
  final String message;
  CarErrorState({required this.message});
}
