import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:yasta/core/networks/api_exception.dart';
import 'package:yasta/core/networks/api_manager.dart';
import 'package:yasta/core/networks/api_response.dart';
import 'package:yasta/core/networks/request_body.dart';
import 'package:yasta/features/workshop_profile/model/add_Reviews_response.dart';
import 'package:yasta/features/workshop_profile/model/add_reviwe_model.dart';
import 'package:yasta/features/workshop_profile/model/show_all_reviews.dart';
import 'package:yasta/features/workshop_profile/model/update_reviews.dart';

import '../../favourite_screen/data/models/add_favorite_workshop_request_body.dart';
import '../../favourite_screen/data/models/add_favorite_workshop_response.dart';
import '../model/get_workshop_byId_response.dart';

part 'work_shop_for_reviews_state.dart';

class WorkShopForReviewsCubit extends Cubit<WorkShopForReviewsState> {
  WorkShopForReviewsCubit() : super(WorkShopForReviewsInitial());

  static WorkShopForReviewsCubit get(context) => BlocProvider.of(context);

  TextEditingController reviewsController = TextEditingController();
  int ?id;

  addReviews({required AddReviewsModel addReviewsModel}) async {
    emit(AddReviewsLoadingState());
    // Send the API request
    ApiResponse? response = await ApiManager.sendRequest(
      link: 'user/reviews',
      body: RequestBody(addReviewsModel.toJson()),
      method: Method.POST,
    );

    // Debugging for response
    debugPrint('Response status: ${response?.data!['status']}');
    debugPrint('Response message: ${response?.data!['message']}');

    if (response != null && response.statusCode == 200) {
      emit(AddReviewsSuccessState(
          data: AddReviewsResponseModel.fromJson(response.data!)));
    } else {
      emit(AddReviewsErrorState(message: response?.message ?? 'Failed'));
    }
  }

  updateReviews({required UpdateReviews UpdateReviews}) async {
    emit(UpdateReviewsLoadingState());
    // Send the API request
    ApiResponse? response = await ApiManager.sendRequest(
      link: 'user/reviews/$id',
      body: RequestBody(UpdateReviews.toJson()),
      method: Method.PUT,
    );

    // Debugging for response
    debugPrint('Response status: ${response?.data!['status']}');
    debugPrint('Response message: ${response?.data!['message']}');

    if (response != null && response.statusCode == 200) {
      emit(UpdateReviewsSuccessState(
          data: AddReviewsResponseModel.fromJson(response.data!)));
    } else {
      emit(UpdateReviewsErrorState(message: response?.message ?? 'Failed'));
    }
  }

  getAllReviews({
    required int workshopId,
}) async {
    emit(GetReviewsLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'workshops/$workshopId/reviews',
        method: Method.GET,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(GetReviewsSuccessState(
            data: ShowAllReviewsResponseModel.fromJson(response.data!)));
      } else {
        emit(
            GetReviewsErrorState(message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(GetReviewsErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  addFavorite({
    required AddFavoriteWorkshopRequestBody addFavoriteWorkshopRequestBody,
  }) async
  {
    emit(AddFavoriteWorkshopLoadingState());
    try {
      ApiResponse? response = await ApiManager.sendRequest(
        body: RequestBody(addFavoriteWorkshopRequestBody.toJson()),
        link: 'user/favorite/toggle',
        method: Method.POST,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(AddFavoriteWorkshopSuccessState(
            data: AddFavoriteWorkshopResponse.fromJson(response.data!)));
      } else {
        emit(AddFavoriteWorkshopErrorState(message: response?.message ?? ''));
      }
    } catch (e) {
      emit(AddFavoriteWorkshopErrorState(
          message:
          e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  getWorkshopDataById({required int id}) async {
    emit(GetWorkshopDatByIdLoadingState());
    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'workshops/$id',
        method: Method.GET,
      );
      if (response != null && response.statusCode == 200) {
        emit(GetWorkshopDatByIdSuccessState(
            data: GetWorkshopByIdResponse.fromJson(response.data!)));
      } else {
        emit(GetWorkshopDatByIdErrorState(
            message: response?.message ?? 'Failed'));
      }
    } catch (e) {
      emit(GetWorkshopDatByIdErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }
}
