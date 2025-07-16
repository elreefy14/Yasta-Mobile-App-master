import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:yasta/features/messages_screen/data/model/get_conversations_model.dart';

import '../../../../core/networks/api_exception.dart';
import '../../../../core/networks/api_manager.dart';
import '../../../../core/networks/api_response.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageInitial());
 // static MessageCubit get(context) => BlocProvider.of(context);
  getAllConversations() async {
    emit(GetAllConversationsLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'conversations',
        method: Method.GET,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(GetAllConversationsSuccessState(
            data: GetConversationsModel.fromJson(response.data!)));
      } else {
        emit(GetAllConversationsErrorState(message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(GetAllConversationsErrorState(
          message:
          e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }
}
