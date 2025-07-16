part of 'center_profile_cubit.dart';

@immutable
sealed class CenterProfileState {}

final class CenterProfileInitial extends CenterProfileState {}

final class GetCenterDataLoadingState extends CenterProfileState {}

final class GetCenterDataSuccessState extends CenterProfileState {
  final ShowWorkshopDataResponse data;

  GetCenterDataSuccessState({required this.data});
}

final class GetCenterDataErrorState extends CenterProfileState {
  final String message;

  GetCenterDataErrorState({required this.message});
}

final class GetWorkshopScheduleLoadingState extends CenterProfileState {}

final class GetWorkshopScheduleSuccessState extends CenterProfileState {
  final ShowWorkshopSchedulesResponse data;

  GetWorkshopScheduleSuccessState({required this.data});
}

final class GetWorkshopScheduleErrorState extends CenterProfileState {
  final String message;

  GetWorkshopScheduleErrorState({required this.message});
}

final class GetWorkshopServicesLoadingState extends CenterProfileState {}

final class GetWorkshopServicesSuccessState extends CenterProfileState {
  final ShowWorkshopServicesResponse data;

  GetWorkshopServicesSuccessState({required this.data});
}

final class GetWorkshopServicesErrorState extends CenterProfileState {
  final String message;

  GetWorkshopServicesErrorState({required this.message});
}

final class GetWorkshopModelsLoadingState extends CenterProfileState {}

final class GetWorkshopModelsSuccessState extends CenterProfileState {
  final ShowWorkshopModelsResponse data;

  GetWorkshopModelsSuccessState({required this.data});
}

final class GetWorkshopModelsErrorState extends CenterProfileState {
  final String message;

  GetWorkshopModelsErrorState({required this.message});
}

final class GetWorkshopSocialsLoadingState extends CenterProfileState {}

final class GetWorkshopSocialsSuccessState extends CenterProfileState {
  final ShowWorkshopSocialsResponse data;

  GetWorkshopSocialsSuccessState({required this.data});
}

final class GetWorkshopSocialsErrorState extends CenterProfileState {
  final String message;

  GetWorkshopSocialsErrorState({required this.message});
}
