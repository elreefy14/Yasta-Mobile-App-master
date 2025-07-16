part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class FetchConversationsLoadingState extends ChatState {}
class FetchConversationsSuccessState extends ChatState {
  final FetchConversationsModel? data;

  FetchConversationsSuccessState({this.data});
}

final class FetchConversationsErrorState extends ChatState {
  final String message;

  FetchConversationsErrorState({required this.message});
}

final class FetchMessageLoadingState extends ChatState {}
class FetchMessageSuccessState extends ChatState {
  final FetchMessageFromBot? data;

  FetchMessageSuccessState({this.data});
}

final class FetchMessageErrorState extends ChatState {
  final String message;
  FetchMessageErrorState({required this.message});
}
final class FeedbackMessageLoadingState extends ChatState {}
class FeedbackMessageSuccessState extends ChatState {
  final FeedbackBody? data;

  FeedbackMessageSuccessState({this.data});
}

final class FeedbackMessageErrorState extends ChatState {
  final String message;
  FeedbackMessageErrorState({required this.message});
}

final class SeenConversationsLoadingState extends ChatState {}


class SeenConversationsSuccessState extends ChatState {
  final String? data;

  SeenConversationsSuccessState({this.data});
}

final class SeenConversationsErrorState extends ChatState {
  final String message;

  SeenConversationsErrorState({required this.message});
}

final class StartConversationsLoadingState extends ChatState {}
class StartConversationsSuccessState extends ChatState {
  final StartConversationsResponseModel? data;

  StartConversationsSuccessState({this.data});
}

final class StartConversationsErrorState extends ChatState {
  final String message;

  StartConversationsErrorState({required this.message});
}

final class SendMessageLoadingState extends ChatState {}
class SendMessageSuccessState extends ChatState {
  final SendMessageResponseModel? data;

  SendMessageSuccessState({this.data});
}

final class SendMessageErrorState extends ChatState {
  final String message;

  SendMessageErrorState({required this.message});
}


final class SendMessageBotLoadingState extends ChatState {}
class SendMessageBotSuccessState extends ChatState {
  dynamic data;

  SendMessageBotSuccessState({this.data});
}

final class SendMessageBotErrorState extends ChatState {
  final String message;

  SendMessageBotErrorState({required this.message});
}