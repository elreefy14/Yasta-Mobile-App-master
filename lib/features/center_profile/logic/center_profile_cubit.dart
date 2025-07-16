import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/networks/api_exception.dart';
import '../../../core/networks/api_manager.dart';
import '../../../core/networks/api_response.dart';
import '../data/models/show_workshop_data_response.dart';
import '../data/models/show_workshop_models_response.dart';
import '../data/models/show_workshop_schedules_response.dart';
import '../data/models/show_workshop_services_response.dart';
import '../data/models/show_workshop_socials_response.dart';

part 'center_profile_state.dart';

class CenterProfileCubit extends Cubit<CenterProfileState> {
  CenterProfileCubit() : super(CenterProfileInitial());

  static CenterProfileCubit get(context) => BlocProvider.of(context);

  getCenterProfileData() async {
    emit(GetCenterDataLoadingState());
    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'workshop',
        method: Method.GET,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(GetCenterDataSuccessState(
            data: ShowWorkshopDataResponse.fromJson(response.data!)));
      } else {
        emit(GetCenterDataErrorState(
            message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(GetCenterDataErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  getCenterProfileSchedules() async {
    emit(GetWorkshopScheduleLoadingState());
    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'workshop/schedules',
        method: Method.GET,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(GetWorkshopScheduleSuccessState(
            data: ShowWorkshopSchedulesResponse.fromJson(response.data!)));
      } else {
        emit(GetWorkshopScheduleErrorState(
            message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(GetWorkshopScheduleErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  getCenterProfileServices() async {
    emit(GetWorkshopServicesLoadingState());
    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'workshop/services',
        method: Method.GET,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(GetWorkshopServicesSuccessState(
            data: ShowWorkshopServicesResponse.fromJson(response.data!)));
      } else {
        emit(GetWorkshopServicesErrorState(
            message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(GetWorkshopServicesErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  getCenterProfileModels() async {
    emit(GetWorkshopModelsLoadingState());
    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'workshop/models',
        method: Method.GET,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(GetWorkshopModelsSuccessState(
            data: ShowWorkshopModelsResponse.fromJson(response.data!)));
      } else {
        emit(GetWorkshopModelsErrorState(
            message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(GetWorkshopModelsErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  getCenterProfileSocials() async {
    emit(GetWorkshopSocialsLoadingState());
    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'workshop/socials',
        method: Method.GET,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(GetWorkshopSocialsSuccessState(
            data: ShowWorkshopSocialsResponse.fromJson(response.data!)));
      } else {
        emit(GetWorkshopSocialsErrorState(
            message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(GetWorkshopSocialsErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }
}
