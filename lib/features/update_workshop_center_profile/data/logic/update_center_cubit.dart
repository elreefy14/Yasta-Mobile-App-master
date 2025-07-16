import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import 'package:yasta/features/auth/data/models/add_models.dart';
import 'package:yasta/features/auth/data/models/add_services_model.dart';
import 'package:yasta/features/auth/data/models/add_socials_model.dart';
import 'package:yasta/features/auth/data/models/add_workshop_model.dart';
import 'package:yasta/features/auth/data/models/add_workshop_response.dart';
import 'package:yasta/features/auth/data/models/login_request_body.dart';
import 'package:yasta/features/auth/data/models/login_response.dart';
import 'package:yasta/features/auth/data/models/register_request_body.dart';
import 'package:yasta/features/auth/data/models/register_response.dart';
import 'package:yasta/features/update_workshop_center_profile/data/model/update_workShop.dart';
import 'package:yasta/features/user_profile_screen/data/models/update_response.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/networks/api_exception.dart';
import '../../../../core/networks/api_manager.dart';
import '../../../../core/networks/api_response.dart';
import '../../../../core/networks/request_body.dart';

import 'package:http/http.dart' as http;

import '../../../auth/data/models/schedule_model.dart';
import '../../../workshop_profile/model/get_workshop_byId_response.dart' as data;
part 'update_center_state.dart';

class UpdateCenterCubit extends Cubit<UpdateCenterState> {
  UpdateCenterCubit() : super(UpdateCenterInitial());
  File? selectedLogo;
  String? workShopImage;
  String? userModelValue;
  String? searchTypeValue;
  String? selectedModelId;
  String? userBrandValue;
  String? workshopBrandValue;
  String? workshopServiceValue;
  String? userYearValue;
  List<File> selectedImages = [];
  List<String> selectedImage = [];
  List<String> socialMediaLink=[];
  List<Widget> socialMediaLinks = [];
  List<data.Images>? imagesAlbum;

  List<String> workshopServicesList = [];
  List<dynamic> workshopUpdatedServicesList = [];
  List<String> typeSearch = ["map" , "normal"];
  List<String> allModelsList = [];
  List<Map<String, dynamic>> workingHours = [
    {
      'dayController': <String>[], // Days selected
      'fromHourController': TextEditingController(),
      'fromMinuteController': TextEditingController(),
      'toHourController': TextEditingController(),
      'toMinuteController': TextEditingController(),
    }
  ];
  List<String> workshopBrands = [];
  List<TextEditingController> WorkshopSocialControllerList = [TextEditingController()];
  List<String> selectedValues = [];
  List<String> selectedWorkshopServices = [];
  List<String> selectedAllModel = [];
  List<Map<String, String>> modelList = [];
  List<Map<String, String>> workshopServices = [];
  List<Map<String, String>> allModels = [];
  List<Map<String, String>> brandList = [];
  List<Map<String, String>> yearList = [];
  List<String> items = ['السبت', 'الاحد', 'الاثنين', 'الثلاثاء', 'الاربعاء', 'الخميس', 'الجمعة'];
  TextEditingController WorkshopNameController = TextEditingController();
  TextEditingController WorkshopAddressController = TextEditingController();
  TextEditingController WorkshopDescriptionController = TextEditingController();
  TextEditingController WorkshopphoneNumberController = TextEditingController();
  List<TextEditingController> workshopSocialControllers = [TextEditingController()];
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController loginPhoneController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController ConfirmPasswordController = TextEditingController();
  TextEditingController firstUserNameController = TextEditingController();
  TextEditingController lastUserNameController = TextEditingController();
  TextEditingController userSignUpPhone = TextEditingController();
  TextEditingController userSignUpPassword = TextEditingController();
  TextEditingController userSignUpConfirmPassword = TextEditingController();

  List<ScheduleModel> schedules = [];
  TextEditingController fromHourController = TextEditingController();
  TextEditingController fromMinuteController = TextEditingController();
  TextEditingController toHourController = TextEditingController();
  TextEditingController toMinuteController = TextEditingController();
  LatLng? selectedDestination;


  updateWorkshop({required UpdateWorkshop workshop}) async {
    emit(UpdateWorkshopLoadingState());

    try {
      // Build the form data
      Map<String, dynamic> formDataMap = {
        'name': workshop.name,
        'address': workshop.address,
        'phone': workshop.phone,
        'description': workshop.description,
      };

      // Check if imageFile is provided and add it to formData
      if (workshop.imageFile != null) {
        formDataMap['image_file'] = await MultipartFile.fromFile(
          workshop.imageFile!.path,
          filename: workshop.imageFile!.path.split('/').last,
        );
      }

      // Construct FormData from the map
      FormData formData = FormData.fromMap(formDataMap);

      // Send the API request
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'workshop/update',
        formData: formData,
        method: Method.POST,
      );

      // Debugging for response
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');

      if (response != null && response.statusCode == 200) {
        emit(UpdateWorkshopSuccessState(
            data: AddWorkshopResponse.fromJson(response.data!)));
      } else {
        emit(UpdateWorkshopErrorState(message: response?.message ?? 'Failed'));
      }
    } catch (e) {
      emit(UpdateWorkshopErrorState(
          message: e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }


  addImage({required File imageFile}) async {
    emit(AddImageLoadingState());





    try {
      // Create a list of MultipartFile for the images
      List<MultipartFile> imageFiles = [];
      // for (File imagePath in workshop.images) {
      //   imageFiles.add(await MultipartFile.fromFile(
      //     imagePath.path,
      //     filename: imagePath.path.split('/').last,
      //   ));
      // }

      // Build the form data
      FormData formData = FormData.fromMap({

        'image_file': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
         // Attach the list of images
      });

      // Send the API request
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'workshop/images',
        formData: formData,
        method: Method.POST,
      );

      // Debugging for response
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');

      if (response != null && response.statusCode == 200) {
        emit(AddImageSuccessState(
            data: UpdateResponse.fromJson(response.data!)));
      } else {
        emit(AddImageErrorState(message: response?.message ?? 'Failed'));
      }
    } catch (e) {
      emit(AddImageErrorState(
          message: e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  updateServices({required AddServicesModel addServicesModel}) async {
    emit(UpdateServicesLoadingState());
    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'workshop/new/services',
        body: RequestBody(addServicesModel.toJson()),
        method: Method.PUT,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(UpdateServicesSuccessState());
      } else {
        emit(UpdateServicesErrorState(message: response?.message ?? 'failed'));
      }
    } catch (e) {
      emit(UpdateServicesErrorState(
          message:
          e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  updateModels({required AddModelsModel addModelsModel}) async {
    emit(UpdateWorkshopLoadingState());
    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'workshop/new/models',
        body: RequestBody(addModelsModel.toJson()),
        method: Method.PUT,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(UpdateModelsSuccessState());
      } else {
        emit(UpdateModelsErrorState(message: response?.message ?? 'failed'));
      }
    } catch (e) {
      emit(UpdateModelsErrorState(
          message:
          e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }
  String getPlatformFromUrl(String url) {
    try {
      // Add "https://" if the URL doesn't have a scheme
      if (!url.startsWith('http://') && !url.startsWith('https://')) {
        url = 'https://$url';
      }

      Uri uri = Uri.parse(url);
      String host = uri.host;

      if (host.contains('facebook.com')) return 'Facebook';
      if (host.contains('twitter.com')) return 'Twitter';
      if (host.contains('instagram.com')) return 'Instagram';
      if (host.contains('linkedin.com')) return 'LinkedIn';
      if (host.contains('youtube.com')) return 'YouTube';
      if (host.contains('tiktok.com')) return 'TikTok';
      return 'Web';
    } catch (e) {
      print("Error parsing URL: $url, Error: $e");
      return 'Unknown Platform';
    }
  }

  updateSocials({required AddSocialsModel addSocialsModel}) async {
    emit(UpdateSocialsLoadingState());
    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'workshop/new/socials',
        body: RequestBody(addSocialsModel.toJson()),
        method: Method.PUT,

      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(UpdateSocialsSuccessState());
      } else {
        emit(UpdateSocialsErrorState(message: response?.message ?? 'failed'));
      }
    } catch (e) {
      emit(UpdateSocialsErrorState(
          message:
          e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  void sendSocialsData(BuildContext context) {
    final updateCenterCubit = getIt<UpdateCenterCubit>();

    // Prepare the list of Socials
    List<Socials> socialsList = updateCenterCubit.workshopSocialControllers
        .where((controller) => controller.text.trim().isNotEmpty)
        .map((controller) {
      String url = controller.text.trim();
      String platform = getPlatformFromUrl(url);
      return Socials(platform: platform, url: url);
    })
        .toList();

    // Create the AddSocialsModel
    AddSocialsModel addSocialsModel = AddSocialsModel(
      socials: socialsList,
    );

    // Send the data
    updateCenterCubit.updateSocials(addSocialsModel: addSocialsModel);

    // Debug log
    print("Sending Socials Data: ${addSocialsModel.toJson()}");

  }

  deleteAlbum({required int id}) async {
    emit(DeleteAlbumLoadingState());
    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'workshop/images/$id',
        method: Method.DELETE,
      );
      if (response != null && response.statusCode == 200) {
        emit(DeleteAlbumSuccessState(
            data: UpdateResponse.fromJson(response.data!)));
      } else {
        emit(DeleteAlbumErrorState(
            message: response?.message ?? 'Failed'));
      }
    } catch (e) {
      emit(DeleteAlbumErrorState(
          message:
          e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }


}
