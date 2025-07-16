import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import 'package:yasta/features/auth/data/models/add_ful_workshop.dart';
import 'package:yasta/features/auth/data/models/add_models.dart';
import 'package:yasta/features/auth/data/models/add_services_model.dart';
import 'package:yasta/features/auth/data/models/add_socials_model.dart';
import 'package:yasta/features/auth/data/models/add_workshop_model.dart';
import 'package:yasta/features/auth/data/models/add_workshop_response.dart';
import 'package:yasta/features/auth/data/models/forget_password.dart';
import 'package:yasta/features/auth/data/models/login_request_body.dart';
import 'package:yasta/features/auth/data/models/login_response.dart';
import 'package:yasta/features/auth/data/models/register_request_body.dart';
import 'package:yasta/features/auth/data/models/register_response.dart';
import 'package:yasta/features/auth/data/models/verfication_model.dart';
import 'package:yasta/features/user_profile_screen/data/models/update_response.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/networks/api_exception.dart';
import '../../../../core/networks/api_manager.dart';
import '../../../../core/networks/api_response.dart';
import '../../../../core/networks/request_body.dart';
import '../../../update_workshop_center_profile/presentation/screen/update_schedule.dart';
import '../../data/models/add_car_request_body.dart';
import '../../data/models/add_car_response.dart';
import '../../data/models/brands_response.dart';
import '../../data/models/get_all_models.dart';
import '../../data/models/get_services_response.dart';
import '../../data/models/resend_otp.dart';
import '../../data/models/schedule_model.dart';
import '../../data/models/verify_request_body.dart';
import '../../data/models/verify_response.dart';
import '../../data/models/workshop_schedules_request_body.dart';
import '../../data/models/years_response.dart';
import 'package:http/http.dart' as http;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  // static AuthCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  String phoneCode = "20";
  String? otp;

  onPhoneCodeChanged(value) {
    phoneCode = value;
  }

  File? selectedLogo;
  String? userModelValue;
  String? searchTypeValue;
  String? selectedModelId;
  String? userBrandValue;
  String? workshopBrandValue;
  String? workshopServiceValue;
  String? userYearValue;
  String? VerifyOTPForgetPassword;
  List<File> selectedImages = [];
  List<Widget> socialMediaLinks = [];
  List<String> workshopServicesList = [];
  List<String> typeSearch = ["map", "normal"];
  List<String> allModelsList = [];
  List<dynamic> workingHours = [
    {
      'dayController': <String>[], // Days selected
      'fromHourController': TextEditingController(),
      'fromMinuteController': TextEditingController(),
      'toHourController': TextEditingController(),
      'toMinuteController': TextEditingController(),
    }
  ];
  List<String> workshopBrands = [];
  List<TextEditingController> WorkshopSocialControllerList = [
    TextEditingController()
  ];
  List<String> selectedValues = [];
  List<String> selectedWorkshopServices = [];
  List<String> selectedAllModel = [];
  List<Map<String, String>> modelList = [];
  List<Map<String, String>> workshopServices = [];
  List<Map<String, String>> allModels = [];
  List<Map<String, String>> brandList = [];
  List<Map<String, String>> yearList = [];
  List<String> items = [
    'السبت',
    'الاحد',
    'الاثنين',
    'الثلاثاء',
    'الاربعاء',
    'الخميس',
    'الجمعة'
  ];
  TextEditingController WorkshopNameController = TextEditingController();
  TextEditingController searchKeyController = TextEditingController();
  TextEditingController WorkshopAddressController = TextEditingController();
  TextEditingController WorkshopDescriptionController = TextEditingController();
  TextEditingController WorkshopphoneNumberController = TextEditingController();
  List<TextEditingController> workshopSocialControllers = [
    TextEditingController()
  ];
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

  login({required LoginRequestBody loginRequestBody}) async {
    emit(LoginLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'auth/user/login',
        body: RequestBody(loginRequestBody.toJson()),
        method: Method.POST,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(LoginSuccessState(data: LoginResponse.fromJson(response.data!)));
      }
      else {
        emit(LoginErrorState(message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(LoginErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  register({required RegisterRequestBody registerRequestBody}) async {
    emit(RegisterLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'auth/user/register',
        body: RequestBody(registerRequestBody.toJson()),
        method: Method.POST,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(RegisterSuccessState(
            data: RegisterResponse.fromJson(response.data!)));
      } else {
        emit(RegisterErrorState(message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(RegisterErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  verify({required VerifyRequestBody verifyRequestBody}) async {
    emit(VerifyLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'auth/user/verify',
        body: RequestBody(verifyRequestBody.toJson()),
        method: Method.POST,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(VerifySuccessState(data: VerifyResponse.fromJson(response.data!)));
      } else {
        emit(VerifyErrorState(message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(VerifyErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  forgetPassword({required ForgetPassWordModel forgetPassWordModel}) async {
    emit(VerifyLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'auth/user/forgot-password/reset',
        body: RequestBody(forgetPassWordModel.toJson()),
        method: Method.POST,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(ForgetPasswordSuccessState());
      } else {
        emit(ForgetPasswordErrorState(message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(ForgetPasswordErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  verifyOtp({required VerifyRequestBody verifyRequestBody}) async {
    emit(VerifyOTPLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'auth/user/forgot-password/verify-otp',
        body: RequestBody(verifyRequestBody.toJson()),
        method: Method.POST,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(VerifyOTPSuccessState(data: VerifyResponse.fromJson(response.data!)));
      } else {
        emit(VerifyOTPErrorState(message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(VerifyOTPErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  reSendOtp({required ReSendOTPModel reSendOTPModel}) async {
    emit(ReSendLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'auth/user/resend',
        body: RequestBody(reSendOTPModel.toJson()),
        method: Method.POST,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(ReSendSuccessState(data: ReSendOTPModel.fromJson(response.data!)));
      } else {
        emit(ReSendErrorState(message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(ReSendErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  logout() async {
    emit(LogoutLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'auth/user/logout',
        method: Method.POST,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(LogoutSuccessState(data: response.data));
      } else {
        emit(LogoutErrorState(message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(LogoutErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  getBrands() async {
    emit(GetBrandsLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'brands',
        method: Method.GET,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(GetBrandsSuccessState(
            data: BrandsResponse.fromJson(response.data!)));
      } else {
        emit(GetBrandsErrorState(message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(GetBrandsErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  getModels({required String brandId}) async {
    emit(GetModelsLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'brand/$brandId/models',
        method: Method.GET,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(GetModelsSuccessState(
            data: BrandsResponse.fromJson(response.data!)));
      } else {
        emit(GetModelsErrorState(message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(GetModelsErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  getYears({required String modelId}) async {
    emit(GetYearsLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'model/$modelId/years',
        method: Method.GET,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(
            GetYearsSuccessState(data: YearsResponse.fromJson(response.data!)));
      } else {
        emit(GetYearsErrorState(message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(GetYearsErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  addCarForUser({required AddCarRequestBody addCarRequestBody}) async {
    emit(AddCarForUserLoadingState());
    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'user/add/car-year',
        body: RequestBody(addCarRequestBody.toJson()),
        method: Method.POST,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(AddCarForUserSuccessState(
            data: AddCarResponse.fromJson(response.data!)));
      } else {
        emit(AddCarForUserErrorState(
            message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(AddCarForUserErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  updateCarForUser({required AddCarRequestBody addCarRequestBody}) async {
    emit(UpdateCarForUserLoadingState());
    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'user/update/car',
        body: RequestBody(addCarRequestBody.toJson()),
        method: Method.PUT,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(UpdateCarForUserSuccessState(
            data: UpdateResponse.fromJson(response.data!)));
      } else {
        emit(UpdateCarForUserErrorState(
            message: response?.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(UpdateCarForUserErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  addWorkshop({required Workshop workshop}) async {
    emit(AddWorkshopLoadingState());

// try{
//   var headers = {
//     'Authorization': 'Bearer ${CacheHelper.getdata(key: 'token')}'
//   };
//   var request = http.MultipartRequest('POST', Uri.parse('https://Yasta.megatron-soft.com/api/v1/workshop'));
//   request.fields.addAll({
//     'name': workshop.name,
//     'address': workshop.address,
//     'latitude':  workshop.latitude,
//     'longitude': workshop.longitude,
//     'phone': workshop.phone,
//     'description': workshop.description
//   });
//   request.files.add(await http.MultipartFile.fromPath('image_file', workshop.imageFile.path));
//   for( File file in workshop.images) {
//     request.files.add(await http.MultipartFile.fromPath('images[]', file.path));
//   }
//   request.headers.addAll(headers);
//
//   http.StreamedResponse response = await request.send();
//
//   if (response.statusCode == 200) {
//     emit(AddWorkshopSuccessState(
//         data: AddWorkshopResponse.fromJson(json.decode(await response.stream.bytesToString()))));
//     print(await response.stream.bytesToString());
//   }
//   else {
//     emit(AddWorkshopErrorState(message: response.reasonPhrase ?? 'Failed'));
//     print(response.reasonPhrase);
//   }
//
// }catch (e) {
//   emit(AddWorkshopErrorState(
//       message: e is ApiException ? e.message : 'An unexpected error occurred'));
// }

    try {
      // Create a list of MultipartFile for the images
      List<MultipartFile> imageFiles = [];
      for (File imagePath in workshop.images) {
        imageFiles.add(await MultipartFile.fromFile(
          imagePath.path,
          filename: imagePath.path.split('/').last,
        ));
      }

      // Build the form data
      FormData formData = FormData.fromMap({
        'name': workshop.name,
        'address': workshop.address,
        'latitude': workshop.latitude,
        'longitude': workshop.longitude,
        'phone': workshop.phone,
        'description': workshop.description,
        'image_file': await MultipartFile.fromFile(
          workshop.imageFile.path,
          filename: workshop.imageFile.path.split('/').last,
        ),
        'images[]': imageFiles, // Attach the list of images
      });

      // Send the API request
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'workshop',
        formData: formData,
        method: Method.POST,
      );

      // Debugging for response
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');

      if (response != null && response.statusCode == 200) {
        emit(AddWorkshopSuccessState(
            data: AddWorkshopResponse.fromJson(response.data!)));
      } else {
        emit(AddWorkshopErrorState(message: response?.message ?? 'Failed'));
      }
    } catch (e) {
      emit(AddWorkshopErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  addWorkshopFul({required WorkshopModel workshop}) async {
    emit(AddWorkshopLoadingState());

// try{
//   var headers = {
//     'Authorization': 'Bearer ${CacheHelper.getdata(key: 'token')}'
//   };
//   var request = http.MultipartRequest('POST', Uri.parse('https://Yasta.megatron-soft.com/api/v1/workshop'));
//   request.fields.addAll({
//     'name': workshop.name,
//     'address': workshop.address,
//     'latitude':  workshop.latitude,
//     'longitude': workshop.longitude,
//     'phone': workshop.phone,
//     'description': workshop.description
//   });
//   request.files.add(await http.MultipartFile.fromPath('image_file', workshop.imageFile.path));
//   for( File file in workshop.images) {
//     request.files.add(await http.MultipartFile.fromPath('images[]', file.path));
//   }
//   request.headers.addAll(headers);
//
//   http.StreamedResponse response = await request.send();
//
//   if (response.statusCode == 200) {
//     emit(AddWorkshopSuccessState(
//         data: AddWorkshopResponse.fromJson(json.decode(await response.stream.bytesToString()))));
//     print(await response.stream.bytesToString());
//   }
//   else {
//     emit(AddWorkshopErrorState(message: response.reasonPhrase ?? 'Failed'));
//     print(response.reasonPhrase);
//   }
//
// }catch (e) {
//   emit(AddWorkshopErrorState(
//       message: e is ApiException ? e.message : 'An unexpected error occurred'));
// }

    try {
      // Create a list of MultipartFile for the images
      List<MultipartFile> imageFiles = [];
      for (File imagePath in workshop.images) {
        imageFiles.add(await MultipartFile.fromFile(
          imagePath.path,
          filename: imagePath.path.split('/').last,
        ));
      }

      // Build the form data
      FormData formData = FormData.fromMap({
        'name': workshop.name,
        'address': workshop.address,
        'latitude': workshop.latitude,
        'longitude': workshop.longitude,
        'phone': workshop.phone,
        'description': workshop.description,
        'socials': workshop.socials,
        'image_file': await MultipartFile.fromFile(
          workshop.imageFile.path,
          filename: workshop.imageFile.path.split('/').last,
        ),
        'images[]': imageFiles, // Attach the list of images
      });

      // Send the API request
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'workshop',
        formData: formData,
        method: Method.POST,
      );

      // Debugging for response
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');

      if (response != null && response.statusCode == 200) {
        emit(AddWorkshopSuccessState(
            data: AddWorkshopResponse.fromJson(response.data!)));
      } else {
        emit(AddWorkshopErrorState(message: response?.message ?? 'Failed'));
      }
    } catch (e) {
      emit(AddWorkshopErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  addSocials({required AddSocialsModel addSocialsModel}) async {
    emit(AddSocialsLoadingState());
    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'workshop/socials',
        body: RequestBody(addSocialsModel.toJson()),
        method: Method.POST,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(AddSocialsSuccessState());
      } else {
        emit(AddSocialsErrorState(message: response?.message ?? 'failed'));
      }
    } catch (e) {
      emit(AddSocialsErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  addServices({required AddServicesModel addServicesModel}) async {
    emit(AddServicesLoadingState());
    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'workshop/services',
        body: RequestBody(addServicesModel.toJson()),
        method: Method.POST,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(AddServicesSuccessState());
      } else {
        emit(AddServicesErrorState(message: response?.message ?? 'failed'));
      }
    } catch (e) {
      emit(AddServicesErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  addModels({required AddModelsModel addModelsModel}) async {
    emit(AddModelsLoadingState());
    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'workshop/models',
        body: RequestBody(addModelsModel.toJson()),
        method: Method.POST,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(AddModelsSuccessState());
      } else {
        emit(AddModelsErrorState(message: response?.message ?? 'failed'));
      }
    } catch (e) {
      emit(AddModelsErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  addSchedules({required WorkshopSchedulesRequestBody schedules}) async {
    emit(AddScheduleLoadingState());
    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'workshop/schedules',
        body: RequestBody(schedules.toJson()),
        method: Method.POST,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(AddScheduleSuccessState(
            data: AddWorkshopResponse.fromJson(response.data!)));
      } else {
        emit(AddScheduleErrorState(message: response?.message ?? 'failed'));
      }
    } catch (e) {
      emit(AddScheduleErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  updateSchedules({required UpdateScheduleModel schedules}) async {
    emit(UpdateScheduleLoadingState());
    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'workshop/new/schedules',
        body: RequestBody(schedules.toJson()),
        method: Method.PUT,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(UpdateScheduleSuccessState(
            data: AddWorkshopResponse.fromJson(response.data!)));
      } else {
        emit(UpdateScheduleErrorState(message: response?.message ?? 'failed'));
      }
    } catch (e) {
      emit(UpdateScheduleErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  getServices() async {
    emit(GetServicesLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'services',
        method: Method.GET,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(GetServicesSuccessState(
            data: GetServicesResponse.fromJson(response.data!)));
      } else {
        emit(GetServicesErrorState(message: response?.message ?? ''));
      }
    } catch (e) {
      emit(GetServicesErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }

  getAllModels() async {
    emit(GetAllModelsLoadingState());

    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'models',
        method: Method.GET,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(GetAllModelsSuccessState(
            data: GetAllModelsResponse.fromJson(response.data!)));
      } else {
        emit(GetAllModelsErrorState(message: response?.message ?? ''));
      }
    } catch (e) {
      emit(GetAllModelsErrorState(
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

  void sendSocialsData(BuildContext context) {
    final authCubit = getIt<AuthCubit>();

    // Prepare the list of Socials
    List<Socials> socialsList = authCubit.workshopSocialControllers
        .where((controller) => controller.text.trim().isNotEmpty)
        .map((controller) {
      String url = controller.text.trim();
      String platform = getPlatformFromUrl(url);
      return Socials(platform: platform, url: url);
    }).toList();

    // Create the AddSocialsModel
    AddSocialsModel addSocialsModel = AddSocialsModel(
      socials: socialsList,
    );

    // Send the data
    authCubit.addSocials(addSocialsModel: addSocialsModel);

    // Debug log
    print("Sending Socials Data: ${addSocialsModel.toJson()}");
    // print("Sending Socials Data: ${controller}");
  }
}
