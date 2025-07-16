part of 'map_cubit.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {}

final class GetMapWorkshopsLoadingState extends MapState {}
final class ChangeLocationMapState extends MapState {

  final LatLng latLng;

  ChangeLocationMapState({required this.latLng});
}

final class GetMapWorkshopsSuccessState extends MapState {
  final GetMapWorkshopsResponse data;

  GetMapWorkshopsSuccessState({required this.data});
}

final class GetMapWorkshopsErrorState extends MapState {
  final String message;

  GetMapWorkshopsErrorState({required this.message});
}
