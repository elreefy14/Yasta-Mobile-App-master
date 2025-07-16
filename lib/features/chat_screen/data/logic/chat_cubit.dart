import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:yasta/core/networks/api_exception.dart';
import 'package:yasta/core/networks/api_manager.dart';
import 'package:yasta/core/networks/request_body.dart';
import 'package:yasta/features/bot_massage/data/model/feedback_body.dart';
import 'package:yasta/features/bot_massage/data/model/fetch_message_from_bot.dart';
import 'package:yasta/features/bot_massage/data/model/message_response.dart';
import 'package:yasta/features/bot_massage/data/model/message_workshop_response.dart';
import 'package:yasta/features/bot_massage/data/model/send_message_requst.dart';
import 'package:yasta/features/chat_screen/data/model/fetch_chat.dart';
import 'package:yasta/features/chat_screen/data/model/seen_message.dart';
import 'package:yasta/features/chat_screen/data/model/send_message_model.dart';
import 'package:yasta/features/chat_screen/data/model/send_message_response.dart';
import 'package:yasta/features/chat_screen/data/model/start_chat_response.dart';
import 'package:yasta/features/chat_screen/data/model/start_model.dart';

import '../../../../core/networks/api_response.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  int conversationsId=1;
  int page=1;
   bool enable=true;
  static ChatCubit get(context) => BlocProvider.of(context);
  fetchConversations() async {
    emit(FetchConversationsLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'conversations/$conversationsId/messages?pages=$page',
        method: Method.GET,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(FetchConversationsSuccessState(
            data: FetchConversationsModel.fromJson(response.data!)));
      } else {
        emit(FetchConversationsErrorState(message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(FetchConversationsErrorState(
          message:
          e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }
  fetchMessage() async {
    emit(FetchMessageLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'chatbots',
        method: Method.GET,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(FetchMessageSuccessState(
            data: FetchMessageFromBot.fromJson(response.data!)));
      } else {
        emit(FetchMessageErrorState(message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(FetchMessageErrorState(
          message:
          e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }
  feedBackMessage({required FeedbackBody feedbackBody}) async {
    emit(FeedbackMessageLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'chatbots/report',
        method: Method.GET,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(FeedbackMessageSuccessState(
            data: FeedbackBody.fromJson(response.data!)));
      } else {
        emit(FeedbackMessageErrorState(message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(FeedbackMessageErrorState(
          message:
          e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }
  seenConversations() async {
    emit(SeenConversationsLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'messages/$conversationsId/mark-as-seen',
        method: Method.PATCH,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(SeenConversationsSuccessState(
            data: response.message!));
      } else {
        emit(SeenConversationsErrorState(message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(SeenConversationsErrorState(
          message:
          e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }
  startConversations({required StartConversationsModel startConversationsModel}) async {
    emit(StartConversationsLoadingState());
    // Send the API request
    ApiResponse? response = await ApiManager.sendRequest(
      link: 'conversations',
      body: RequestBody(startConversationsModel.toJson()),
      method: Method.POST,
    );

    // Debugging for response
    debugPrint('Response status: ${response?.data!['status']}');
    debugPrint('Response message: ${response?.data!['message']}');

    if (response != null && response.statusCode == 200) {
      emit(StartConversationsSuccessState(
          data: StartConversationsResponseModel.fromJson(response.data!)));
    } else {
      emit(StartConversationsErrorState(message: response?.message ?? 'Failed'));
    }
  }
  sendMessage({required SendMessageModel sendMessageModel}) async {
    emit(SendMessageLoadingState());
    // Send the API request
    ApiResponse? response = await ApiManager.sendRequest(
      link: 'conversations/$conversationsId/messages',
      body: RequestBody(sendMessageModel.toJson()),
      method: Method.POST,
    );

    // Debugging for response
    debugPrint('Response status: ${response?.data!['status']}');
    debugPrint('Response message: ${response?.data!['message']}');

    if (response != null && response.statusCode == 200) {
      emit(SendMessageSuccessState(
          data: SendMessageResponseModel.fromJson(response.data!)));
    } else {
      emit(SendMessageErrorState(message: response?.message ?? 'Failed'));
    }
  }
  sendMessageToBot({required SendMessageModel sendMessageModel}) async {
    emit(SendMessageBotLoadingState());
    // Send the API request
    ApiResponse? response = await ApiManager.sendRequest(
      link: 'chatbots',
      body: RequestBody(sendMessageModel.toJson()),
      method: Method.POST,
    );

    // Debugging for response
    debugPrint('Response status: ${response?.data!['status']}');
    debugPrint('Response message: ${response?.data!['message']}');
    debugPrint('Response message: ${response?.data!['workshop_is']}');

    if (response != null && response.statusCode == 200) {
      emit(SendMessageBotSuccessState(
          data:response.data!['workshop_is'] ==true?  MessageWorkShopResponse.fromJson(response.data!):MessageResponse.fromJson(response.data!)));
    } else {
      emit(SendMessageBotErrorState(message: response?.message ?? 'Failed'));
    }
  }
}
