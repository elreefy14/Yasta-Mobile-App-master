part of 'update_center_cubit.dart';

@immutable
sealed class UpdateCenterState {}

final class UpdateCenterInitial extends UpdateCenterState {}


final class UpdateWorkshopLoadingState extends UpdateCenterState {}

class UpdateWorkshopSuccessState extends UpdateCenterState {
  final AddWorkshopResponse? data;

  UpdateWorkshopSuccessState({this.data});
}

final class UpdateWorkshopErrorState extends UpdateCenterState {
  final String message;

  UpdateWorkshopErrorState({required this.message});
}


final class UpdateServicesLoadingState extends UpdateCenterState {}

class UpdateServicesSuccessState extends UpdateCenterState {
  // final AddServicesModel? data;
  //
  // AddServicesSuccessState({this.data});
}

final class UpdateServicesErrorState extends UpdateCenterState {
  final String message;

  UpdateServicesErrorState({required this.message});
}


final class UpdateSocialsLoadingState extends UpdateCenterState {}

class UpdateSocialsSuccessState extends UpdateCenterState {
}

final class UpdateSocialsErrorState extends UpdateCenterState {
  final String message;

  UpdateSocialsErrorState({required this.message});
}

final class UpdateModelsLoadingState extends UpdateCenterState {}

class UpdateModelsSuccessState extends UpdateCenterState {
}

final class UpdateModelsErrorState extends UpdateCenterState {
  final String message;

  UpdateModelsErrorState({required this.message});
}

final class DeleteAlbumLoadingState extends UpdateCenterState {}

class DeleteAlbumSuccessState extends UpdateCenterState {
  UpdateResponse? data;
  DeleteAlbumSuccessState({required this.data});
}

final class DeleteAlbumErrorState extends UpdateCenterState {
  final String message;

  DeleteAlbumErrorState({required this.message});
}


final class AddImageLoadingState extends UpdateCenterState {}

class AddImageSuccessState extends UpdateCenterState {
  UpdateResponse? data;
  AddImageSuccessState({required this.data});
}

final class AddImageErrorState extends UpdateCenterState {
  final String message;

  AddImageErrorState({required this.message});
}