import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import 'package:yasta/features/favourite_screen/data/models/add_favorite_workshop_request_body.dart';
import 'package:yasta/features/favourite_screen/data/models/add_favorite_workshop_response.dart';
import '../../../core/networks/api_exception.dart';
import '../../../core/networks/api_manager.dart';
import '../../../core/networks/api_response.dart';
import '../../../core/networks/request_body.dart';
import '../data/models/get_favorite_workshops_response.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

//  static FavoriteCubit get(context) => BlocProvider.of(context);


  getFavoriteWorkshops() async {
    emit(GetFavoriteWorkshopsLoadingState());
    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'user/favorites?latitude=${CacheHelper.getdata(key: "latitude")}&longitude=${CacheHelper.getdata(key: "longitude")}',
        method: Method.GET,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(GetFavoriteWorkshopsSuccessState(
            data: GetFavoriteWorkshopsResponse.fromJson(response.data!)));
      } else {
        emit(GetFavoriteWorkshopsErrorState(message: response?.message ?? ''));
      }
    } catch (e) {
      emit(GetFavoriteWorkshopsErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }
}
