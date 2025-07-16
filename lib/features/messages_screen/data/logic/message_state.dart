part of 'message_cubit.dart';

@immutable
sealed class MessageState {}

final class MessageInitial extends MessageState {}

final class GetAllConversationsLoadingState extends MessageState {}

class GetAllConversationsSuccessState extends MessageState {
  final GetConversationsModel? data;

  GetAllConversationsSuccessState({this.data});
}

final class GetAllConversationsErrorState extends MessageState {
  final String message;

  GetAllConversationsErrorState({required this.message});
}
