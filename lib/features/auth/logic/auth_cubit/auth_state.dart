part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final LoginResponse? data;

  LoginSuccessState({this.data});
}

final class LoginErrorState extends AuthState {
  final String message;

  LoginErrorState({required this.message});
}
final class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {
  final RegisterResponse? data;

  RegisterSuccessState({this.data});
}

final class RegisterErrorState extends AuthState {
  final String message;

  RegisterErrorState({required this.message});
}

final class VerifyLoadingState extends AuthState {}

class VerifySuccessState extends AuthState {
  final VerifyResponse? data;

  VerifySuccessState({this.data});
}

final class VerifyErrorState extends AuthState {
  final String message;

  VerifyErrorState({required this.message});
}

final class ForgetPasswordLoadingState extends AuthState {}

class ForgetPasswordSuccessState extends AuthState {


  ForgetPasswordSuccessState();
}

final class ForgetPasswordErrorState extends AuthState {
  final String message;

  ForgetPasswordErrorState({required this.message});
}

final class VerifyOTPLoadingState extends AuthState {}

class VerifyOTPSuccessState extends AuthState {
  final VerifyResponse? data;

  VerifyOTPSuccessState({this.data});
}

final class VerifyOTPErrorState extends AuthState {
  final String message;

  VerifyOTPErrorState({required this.message});
}

final class ReSendLoadingState extends AuthState {}

class ReSendSuccessState extends AuthState {
  final ReSendOTPModel? data;

  ReSendSuccessState({this.data});
}

final class ReSendErrorState extends AuthState {
  final String message;

  ReSendErrorState({required this.message});
}

final class LogoutLoadingState extends AuthState {}

class LogoutSuccessState extends AuthState {
  final Map<String, dynamic>? data;

  LogoutSuccessState({this.data});
}

final class LogoutErrorState extends AuthState {
  final String message;

  LogoutErrorState({required this.message});
}

final class GetBrandsLoadingState extends AuthState {}

class GetBrandsSuccessState extends AuthState {
  final BrandsResponse? data;

  GetBrandsSuccessState({this.data});
}

final class GetBrandsErrorState extends AuthState {
  final String message;

  GetBrandsErrorState({required this.message});
}

final class GetModelsLoadingState extends AuthState {}

class GetModelsSuccessState extends AuthState {
  final BrandsResponse? data;

  GetModelsSuccessState({this.data});
}

final class GetModelsErrorState extends AuthState {
  final String message;

  GetModelsErrorState({required this.message});
}

final class GetYearsLoadingState extends AuthState {}

class GetYearsSuccessState extends AuthState {
  final YearsResponse? data;

  GetYearsSuccessState({this.data});
}

final class GetYearsErrorState extends AuthState {
  final String message;

  GetYearsErrorState({required this.message});
}

final class AddCarForUserLoadingState extends AuthState {}

class AddCarForUserSuccessState extends AuthState {
  final AddCarResponse? data;

  AddCarForUserSuccessState({this.data});
}

final class AddCarForUserErrorState extends AuthState {
  final String message;

  AddCarForUserErrorState({required this.message});
}

final class UpdateCarForUserLoadingState extends AuthState {}

class UpdateCarForUserSuccessState extends AuthState {
  final UpdateResponse? data;

  UpdateCarForUserSuccessState({this.data});
}

final class UpdateCarForUserErrorState extends AuthState {
  final String message;

  UpdateCarForUserErrorState({required this.message});
}


final class AddWorkshopLoadingState extends AuthState {}

class AddWorkshopSuccessState extends AuthState {
  final AddWorkshopResponse? data;

  AddWorkshopSuccessState({this.data});
}

final class AddWorkshopErrorState extends AuthState {
  final String message;

  AddWorkshopErrorState({required this.message});
}

final class AddScheduleLoadingState extends AuthState {}

class AddScheduleSuccessState extends AuthState {
  final AddWorkshopResponse? data;

  AddScheduleSuccessState({this.data});
}

final class AddScheduleErrorState extends AuthState {
  final String message;

  AddScheduleErrorState({required this.message});
}
final class UpdateScheduleLoadingState extends AuthState {}

class UpdateScheduleSuccessState extends AuthState {
  final AddWorkshopResponse? data;

  UpdateScheduleSuccessState({this.data});
}

final class UpdateScheduleErrorState extends AuthState {
  final String message;

  UpdateScheduleErrorState({required this.message});
}

final class AddSocialsLoadingState extends AuthState {}

class AddSocialsSuccessState extends AuthState {
}

final class AddSocialsErrorState extends AuthState {
  final String message;

  AddSocialsErrorState({required this.message});
}

final class AddModelsLoadingState extends AuthState {}

class AddModelsSuccessState extends AuthState {
}

final class AddModelsErrorState extends AuthState {
  final String message;

  AddModelsErrorState({required this.message});
}


final class AddServicesLoadingState extends AuthState {}

class AddServicesSuccessState extends AuthState {
  // final AddServicesModel? data;
  //
  // AddServicesSuccessState({this.data});
}

final class AddServicesErrorState extends AuthState {
  final String message;

  AddServicesErrorState({required this.message});
}

final class GetServicesLoadingState extends AuthState {}

class GetServicesSuccessState extends AuthState {
  final GetServicesResponse? data;

  GetServicesSuccessState({this.data});
}

final class GetServicesErrorState extends AuthState {
  final String message;

  GetServicesErrorState({required this.message});
}
final class GetAllModelsLoadingState extends AuthState {}

class GetAllModelsSuccessState extends AuthState {
  final GetAllModelsResponse? data;

  GetAllModelsSuccessState({this.data});
}

final class GetAllModelsErrorState extends AuthState {
  final String message;

  GetAllModelsErrorState({required this.message});
}