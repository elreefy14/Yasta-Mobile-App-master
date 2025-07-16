import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:yasta/core/networks/api_exception.dart';
import 'package:yasta/core/networks/api_manager.dart';
import 'package:yasta/core/networks/api_response.dart';
import 'package:yasta/features/my_car_screen/logic/model/show_car_model.dart';


part 'car_state.dart';

class CarCubit extends Cubit<CarState> {
  static CarCubit get(context) => BlocProvider.of(context);
  CarCubit() : super(CarInitial());
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
