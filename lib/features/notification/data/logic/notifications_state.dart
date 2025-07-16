part of 'notifications_cubit.dart';

@immutable
sealed class NotificationsState {}

final class NotificationsInitial extends NotificationsState {}
final class GetNotificationsLoadingState extends NotificationsState {}

class GetNotificationsSuccessState extends NotificationsState {
  final NotificationsModel? data;
  GetNotificationsSuccessState({this.data});
}

final class GetNotificationsErrorState extends NotificationsState {
  final String message;

  GetNotificationsErrorState({required this.message});
}

final class DeleteNotificationLoadingState extends NotificationsState {}

class DeleteNotificationSuccessState extends NotificationsState {
  final UpdateResponse? data;
  DeleteNotificationSuccessState({this.data});
}

final class DeleteNotificationErrorState extends NotificationsState {
  final String message;

  DeleteNotificationErrorState({required this.message});
}