part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class AddFavoriteWorkshopLoadingState extends FavoriteState {}
final class AddFavoriteWorkshopSuccessState extends FavoriteState {
 final AddFavoriteWorkshopResponse data;

  AddFavoriteWorkshopSuccessState({required this.data});
}
final class AddFavoriteWorkshopErrorState extends FavoriteState {
  final String message;

  AddFavoriteWorkshopErrorState({required this.message});
}
final class GetFavoriteWorkshopsLoadingState extends FavoriteState {}

final class GetFavoriteWorkshopsSuccessState extends FavoriteState {
 final GetFavoriteWorkshopsResponse data;

 GetFavoriteWorkshopsSuccessState({required this.data});
}
final class GetFavoriteWorkshopsErrorState extends FavoriteState {
  final String message;

  GetFavoriteWorkshopsErrorState({required this.message});
}
