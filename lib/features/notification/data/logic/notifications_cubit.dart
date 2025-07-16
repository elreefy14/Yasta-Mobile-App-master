import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:yasta/core/networks/api_exception.dart';
import 'package:yasta/core/networks/api_manager.dart';
import 'package:yasta/core/networks/request_body.dart';
import 'package:yasta/features/notification/data/model/notifaction_model.dart';
import 'package:yasta/features/notification/data/model/notification_input_model.dart';
import 'package:yasta/features/user_profile_screen/data/models/update_response.dart';

import '../../../../core/networks/api_response.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  static NotificationsCubit get(context) => BlocProvider.of(context);
  getNotifications() async {
    emit(GetNotificationsLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'notifications',
        method: Method.GET,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(GetNotificationsSuccessState(
            data: NotificationsModel.fromJson(response.data!)));
      } else {
        emit(GetNotificationsErrorState(message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(GetNotificationsErrorState(
          message:
          e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }


  deleteNotification({required NotificationsInputModel notificationsInputModel}) async {
    emit(DeleteNotificationLoadingState());
    // Send the API request
    ApiResponse? response = await ApiManager.sendRequest(
      link: 'notifications',
      body: RequestBody(notificationsInputModel.toJson()),
      method: Method.POST,
    );

    // Debugging for response
    debugPrint('Response status: ${response?.data!['status']}');
    debugPrint('Response message: ${response?.data!['message']}');

    if (response != null && response.statusCode == 200) {
      emit(DeleteNotificationSuccessState(
          data: UpdateResponse.fromJson(response.data!)));
    } else {
      emit(DeleteNotificationErrorState(message: response?.message ?? 'Failed'));
    }
  }
}
