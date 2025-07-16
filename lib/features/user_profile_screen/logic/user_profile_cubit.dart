import 'dart:io';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yasta/features/user_profile_screen/data/models/update_user_data.dart';
import '../../../core/networks/api_exception.dart';
import '../../../core/networks/api_manager.dart';
import '../../../core/networks/api_response.dart';
import '../../../core/networks/request_body.dart';
import '../data/models/update_phone_number_request_body.dart';
import '../data/models/update_username_request_body.dart';
import '../data/models/update_response.dart';
import '../data/models/updated_password_request_body.dart';
import '../data/models/verify_updated_phone_number_request_body.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileInitial());

  // static UserProfileCubit get(context) => BlocProvider.of(context);
File? image;
  Future<void> updateUserName(
      {required UpdateUsernameRequestBody updateUsernameRequestBody}) async {
    emit(UpdateUsernameLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'user/update/username',
        body: RequestBody(updateUsernameRequestBody.toJson()),
        method: Method.POST,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(UpdateUsernameSuccessState(
            data: UpdatePersonalData.fromJson(response.data!)));
      } else {
        emit(UpdateUsernameErrorState(
            message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(UpdateUsernameErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }


  updateUserNameWithImage({UpdateUsernameRequestBody? updateUsernameRequestBody}) async {
    emit(UpdateUsernameLoadingState());

    try {
      // Build the form data
      Map<String, dynamic> formDataMap = {
        'first_name': updateUsernameRequestBody!.firstName,
        'last_name': updateUsernameRequestBody.lastName,
      };

      // Conditionally add the image file
      if (updateUsernameRequestBody.imageFile != null) {
        formDataMap['image_file'] = await MultipartFile.fromFile(
          updateUsernameRequestBody.imageFile!.path,
          filename: updateUsernameRequestBody.imageFile!.path.split('/').last,
        );
      }

      FormData formData = FormData.fromMap(formDataMap);

      // Send the API request
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'user/update/username',
        formData: formData,
        method: Method.POST,
      );

      // Debugging for response
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');

      if (response != null && response.statusCode == 200) {
        emit(UpdateUsernameSuccessState(
            data: UpdatePersonalData.fromJson(response.data!)));
      } else {
        emit(UpdateUsernameErrorState(message: response?.message ?? 'Failed'));
      }
    } catch (e) {
      emit(UpdateUsernameErrorState(
          message: e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }


  Future<void> updatePhoneNumber(
      {required UpdatePhoneNumberRequestBody
          updatePhoneNumberRequestBody}) async {
    emit(UpdatePhoneNumberLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'user/update/phone',
        body: RequestBody(updatePhoneNumberRequestBody.toJson()),
        method: Method.PUT,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(UpdatePhoneNumberSuccessState(
            data: UpdateResponse.fromJson(response.data!)));
      } else {
        emit(UpdatePhoneNumberErrorState(
            message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(UpdatePhoneNumberErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  Future<void> verifyUpdatedPhoneNumber(
      {required VerifyUpdatedPhoneNumberRequestBody
          verifyUpdatedPhoneNumberRequestBody}) async {
    emit(VerifyUpdatePhoneNumberLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'user/verify/phone',
        body: RequestBody(verifyUpdatedPhoneNumberRequestBody.toJson()),
        method: Method.PUT,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(VerifyUpdatePhoneNumberSuccessState(
            data: UpdateResponse.fromJson(response.data!)));
      } else {
        emit(VerifyUpdatePhoneNumberErrorState(
            message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(VerifyUpdatePhoneNumberErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  Future<void> updatePassword(
      {required UpdatedPasswordRequestBody updatedPasswordRequestBody}) async {
    emit(UpdatePasswordLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'user/update/password',
        body: RequestBody(updatedPasswordRequestBody.toJson()),
        method: Method.PUT,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(UpdatePasswordSuccessState(
            data: UpdateResponse.fromJson(response.data!)));
      } else {
        emit(UpdatePasswordErrorState(
            message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(UpdatePasswordErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }
}
