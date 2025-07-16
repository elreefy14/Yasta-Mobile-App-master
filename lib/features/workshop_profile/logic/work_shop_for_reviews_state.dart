part of 'work_shop_for_reviews_cubit.dart';

@immutable
sealed class WorkShopForReviewsState {}

final class WorkShopForReviewsInitial extends WorkShopForReviewsState {}
final class AddReviewsLoadingState extends WorkShopForReviewsState {}

class AddReviewsSuccessState extends WorkShopForReviewsState {
  final AddReviewsResponseModel? data;

  AddReviewsSuccessState({this.data});
}

final class AddReviewsErrorState extends WorkShopForReviewsState {
  final String message;

  AddReviewsErrorState({required this.message});
}
final class UpdateReviewsLoadingState extends WorkShopForReviewsState {}

class UpdateReviewsSuccessState extends WorkShopForReviewsState {
  final AddReviewsResponseModel? data;

  UpdateReviewsSuccessState({this.data});
}

final class UpdateReviewsErrorState extends WorkShopForReviewsState {
  final String message;

  UpdateReviewsErrorState({required this.message});
}


final class GetReviewsLoadingState extends WorkShopForReviewsState {}

class GetReviewsSuccessState extends WorkShopForReviewsState {
  final ShowAllReviewsResponseModel? data;

  GetReviewsSuccessState({this.data});
}

final class GetReviewsErrorState extends WorkShopForReviewsState {
  final String message;

  GetReviewsErrorState({required this.message});
}

final class GetWorkshopDatByIdLoadingState extends WorkShopForReviewsState {}

class GetWorkshopDatByIdSuccessState extends WorkShopForReviewsState {
  final GetWorkshopByIdResponse? data;

  GetWorkshopDatByIdSuccessState({this.data});
}

final class GetWorkshopDatByIdErrorState extends WorkShopForReviewsState {
  final String message;

  GetWorkshopDatByIdErrorState({required this.message});
}


final class AddFavoriteWorkshopLoadingState extends WorkShopForReviewsState {}
final class AddFavoriteWorkshopSuccessState extends WorkShopForReviewsState {
  final AddFavoriteWorkshopResponse data;

  AddFavoriteWorkshopSuccessState({required this.data});
}
final class AddFavoriteWorkshopErrorState extends WorkShopForReviewsState {
  final String message;

  AddFavoriteWorkshopErrorState({required this.message});
}