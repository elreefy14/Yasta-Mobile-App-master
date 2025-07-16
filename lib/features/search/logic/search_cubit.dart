import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../../../core/networks/api_exception.dart';
import '../../../core/networks/api_manager.dart';
import '../../../core/networks/api_response.dart';
import '../../my_car_screen/logic/model/show_car_model.dart';
import '../data/model/get_filtered_workshop_response.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);
  LatLng? selectedDestination;

  filterNormalWorkshops({required Map<String, dynamic> queryParams}) async {
    emit(GetFilteredWorkshopLoadingState());
    try {
      print(queryParams);
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'filter/workshops',
        queryParams: queryParams,
        method: Method.GET,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(GetFilteredWorkshopSuccessState(
            data: GetFilteredWorkshopResponse.fromJson(response.data!)));
      } else {
        emit(GetFilteredWorkshopErrorState(
            message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(GetFilteredWorkshopErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  filterMapWorkshops({required Map<String, dynamic> queryParams}) async {
    emit(GetFilteredWorkshopLoadingState());
    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'filter/workshops',
        queryParams: queryParams,
        method: Method.GET,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(GetFilteredWorkshopSuccessState(
            data: GetFilteredWorkshopResponse.fromJson(response.data!)));
      } else {
        emit(GetFilteredWorkshopErrorState(
            message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(GetFilteredWorkshopErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  showAllCar() async {
    emit(CarLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'user/cars',
        method: Method.GET,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(CarSuccessState(
            data: ShowCarResponse.fromJson(response.data!)));
      } else {
        emit(CarErrorState(message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(CarErrorState(
          message:
          e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }
}
