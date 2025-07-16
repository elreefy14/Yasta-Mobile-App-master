part of 'user_profile_cubit.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}

final class UpdateUsernameLoadingState extends UserProfileState {}

final class UpdateUsernameSuccessState extends UserProfileState {
  final UpdatePersonalData data;

  UpdateUsernameSuccessState({required this.data});
}

final class UpdateUsernameErrorState extends UserProfileState {
  final String message;

  UpdateUsernameErrorState({required this.message});
}

final class UpdatePhoneNumberLoadingState extends UserProfileState {}

final class UpdatePhoneNumberSuccessState extends UserProfileState {
  final UpdateResponse data;

  UpdatePhoneNumberSuccessState({required this.data});
}

final class UpdatePhoneNumberErrorState extends UserProfileState {
  final String message;

  UpdatePhoneNumberErrorState({required this.message});
}
final class VerifyUpdatePhoneNumberLoadingState extends UserProfileState {}

final class VerifyUpdatePhoneNumberSuccessState extends UserProfileState {
  final UpdateResponse data;

  VerifyUpdatePhoneNumberSuccessState({required this.data});
}

final class VerifyUpdatePhoneNumberErrorState extends UserProfileState {
  final String message;

  VerifyUpdatePhoneNumberErrorState({required this.message});
}

final class UpdatePasswordLoadingState extends UserProfileState {}

final class UpdatePasswordSuccessState extends UserProfileState {
  final UpdateResponse data;

  UpdatePasswordSuccessState({required this.data});
}

final class UpdatePasswordErrorState extends UserProfileState {
  final String message;

  UpdatePasswordErrorState({required this.message});
}
