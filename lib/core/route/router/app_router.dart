import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yasta/core/di/dependency_injection.dart';
import 'package:yasta/features/E-wallet/presentation/screen/E-wallet.dart';
import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:yasta/features/auth/service_provider_screens/sign_up_screen/presentation/screen/add_schedule_data.dart';
import 'package:yasta/features/auth/service_provider_screens/sign_up_screen/presentation/screen/add_service_and_model.dart';
import 'package:yasta/features/auth/service_provider_screens/sign_up_screen/presentation/screen/add_socials_data.dart';
import 'package:yasta/features/auth/service_provider_screens/sign_up_screen/presentation/screen/add_workshop_data.dart';
import 'package:yasta/features/auth/ui/screen/change_password.dart';
import 'package:yasta/features/auth/ui/screen/sign_up_personal_data.dart';
import 'package:yasta/features/center_profile/data/models/show_workshop_data_response.dart';
import 'package:yasta/features/center_profile/data/models/show_workshop_models_response.dart';
import 'package:yasta/features/center_profile/data/models/show_workshop_socials_response.dart';
import 'package:yasta/features/center_profile/presentation/screen/center_profile.dart';
import 'package:yasta/features/chat_screen/data/logic/chat_cubit.dart';
import 'package:yasta/features/chat_screen/presentation/screen/chat_screen.dart';
import 'package:yasta/features/favourite_screen/logic/favorite_cubit.dart';
import 'package:yasta/features/messages_screen/data/logic/message_cubit.dart';
import 'package:yasta/features/my_car_screen/logic/cubit/car_cubit.dart';
import 'package:yasta/features/notification/data/logic/notifications_cubit.dart';
import 'package:yasta/features/notification/presentation/screen/notification.dart';
import 'package:yasta/features/payment_method/presentation/screen/payment_method_screen.dart';

import 'package:yasta/features/search/ui/screen/search_screen.dart';
import 'package:yasta/features/update_workshop_center_profile/data/logic/update_center_cubit.dart';
import 'package:yasta/features/update_workshop_center_profile/presentation/screen/uodate_services.dart';
import 'package:yasta/features/update_workshop_center_profile/presentation/screen/update_model.dart';
import 'package:yasta/features/update_workshop_center_profile/presentation/screen/update_photo_album.dart';
import 'package:yasta/features/update_workshop_center_profile/presentation/screen/update_social_data.dart';
import 'package:yasta/features/update_workshop_center_profile/presentation/screen/update_workshop_center_profile.dart';
import 'package:yasta/features/update_workshop_center_profile/presentation/screen/update_workshop_data.dart';
import 'package:yasta/features/workshop_profile/logic/work_shop_for_reviews_cubit.dart';
import 'package:yasta/features/workshop_profile/model/get_workshop_byId_response.dart';
import '../../../features/about_us/presentation/screen/about_us.dart';

import '../../../features/auth/service_provider_screens/sign_up_screen/logic/select_location_map_cubit.dart';
import '../../../features/auth/service_provider_screens/sign_up_screen/presentation/screen/sign_up_screen.dart';
import '../../../features/auth/service_provider_screens/sign_up_screen/presentation/widgets/select_location_map_screen.dart';
import '../../../features/auth/ui/screen/add_car_data.dart';
import '../../../features/auth/ui/screen/add_phone_in_forget_password.dart';
import '../../../features/auth/ui/screen/login_screen.dart';
import '../../../features/auth/widgets/account_created_successfully_screen.dart';
import '../../../features/auth/widgets/verification_code_screen.dart';
import '../../../features/center_profile/data/models/show_workshop_schedules_response.dart';
import '../../../features/center_profile/data/models/show_workshop_services_response.dart';
import '../../../features/center_profile/logic/center_profile_cubit.dart';
import '../../../features/favourite_screen/presentation/screen/favourite_screen.dart';
import '../../../features/home_layout/presentation/screen/home_layout_screen.dart';
import '../../../features/map_screen/logic/map_cubit.dart';
import '../../../features/messages_screen/presentation/screen/messages_screen.dart';
import '../../../features/my_car_screen/presentation/screen/add_car_data_screen.dart';
import '../../../features/my_car_screen/presentation/screen/user_car_screen.dart';
import '../../../features/my_car_screen/presentation/screen/user_not_registered_car_data.dart';
import '../../../features/my_car_screen/presentation/widgets/update_car_data_screen.dart';
import '../../../features/on_boarding_screen/ui/screen/on_boarding_screen.dart';

import '../../../features/search/logic/search_cubit.dart';
import '../../../features/search_results/ui/screen/map_result_screen.dart';
import '../../../features/search_results/ui/screen/search_results_screen.dart';

import '../../../features/select_languages/presentation/screen/select_languages.dart';

import '../../../features/security_screen/presentation/screen/security_screen.dart';
import '../../../features/security_screen/presentation/widgets/update_password_screen.dart';

import '../../../features/service_provider/ui/screen/service_type.dart';
import '../../../features/splash_screen/screen/splash_screen.dart';
import '../../../features/update_workshop_center_profile/presentation/screen/update_schedule.dart';
import '../../../features/user_profile_screen/logic/user_profile_cubit.dart';
import '../../../features/user_profile_screen/presentation/screen/user_profile_screen.dart';
import '../../../features/user_profile_screen/presentation/widgets/update_personal_information_screen.dart';
import '../../../features/user_profile_screen/presentation/widgets/update_phone_number_screen.dart';
import '../../../features/workshop_feedbacks/presentation/screen/workshop_feedbacks_screen.dart';
import '../../../features/workshop_profile/presentation/screen/workshop_profile_screen.dart';
import '../route_strings/route_strings.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteStrings.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RouteStrings.onboardingScreen:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );
      case RouteStrings.signUpPersonalData:
        final userType = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<AuthCubit>(),
            child: SignUpPersonalData(
              userType: userType,
            ),
          ),
        );
      case RouteStrings.addCarData:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<AuthCubit>(),
            child: const AddCarData(),
          ),
        );
      case RouteStrings.loginScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<AuthCubit>(),
            child: const LoginScreen(),
          ),
        );
      case RouteStrings.addPhoneInForgetPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<AuthCubit>(),
            child: const AddPhoneInForgetPassword(),
          ),
        );

      case RouteStrings.verificationCodeScreen:
        final data = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<AuthCubit>(),
            child: VerificationCodeScreen(
              userType: data["userType"],
              phone: data["phone"],
            ),
          ),
        );

      case RouteStrings.searchScreen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<AuthCubit>(),
              ),
              BlocProvider.value(
                value: getIt<SelectLocationMapCubit>()..getMyLocation(),
              ),
              BlocProvider(
                create: (context) => SearchCubit(),
              ),
            ],
            child: SearchScreen(),
          ),
        );

      case RouteStrings.changePassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<AuthCubit>(),
            child: ChangePassword(),
          ),
        );
      case RouteStrings.searchResultsScreen:
        final data = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SearchCubit(),
              ),
              BlocProvider(
                create: (context) => ChatCubit(),
              ),
            ],
            child: SearchResultsScreen(
              data: data['data'],
            ),
          ),
        );
      case RouteStrings.mapResultScreen:
        final data = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<SearchCubit>(),
              ),
              BlocProvider.value(
                value: getIt<MapCubit>(),
              ),
              BlocProvider.value(
                value: getIt<ChatCubit>(),
              ),
            ],
            child: MapResultScreen(
              data: data['data'],
            ),
          ),
        );

      case RouteStrings.userProfileScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<UserProfileCubit>(),
            child: UserProfileScreen(),
          ),
        );
      case RouteStrings.updateSchedule:
        final data = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<UserProfileCubit>(),
            child: BlocProvider.value(
              value: getIt<AuthCubit>(),
              child: UpdateSchedule(
                schedules: data['schedules'],
              ),
            ),
          ),
        );
      case RouteStrings.serviceProviderSignUpScreen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<AuthCubit>(),
              ),
              BlocProvider.value(
                value: getIt<SelectLocationMapCubit>()..getMyLocation(),
              ),
            ],
            child: const SignUpScreen(),
          ),
        );

      case RouteStrings.addWorkshopData:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<AuthCubit>(),
              ),
              BlocProvider.value(
                value: getIt<SelectLocationMapCubit>()..getMyLocation(),
              ),
            ],
            child: const AddWorkshopData(),
          ),
        );

      case RouteStrings.addServiceAndModel:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<AuthCubit>(),
              ),
              BlocProvider.value(
                value: getIt<SelectLocationMapCubit>()..getMyLocation(),
              ),
            ],
            child: const AddServiceAndModel(),
          ),
        );

      case RouteStrings.addSocialsData:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<AuthCubit>(),
              ),
              BlocProvider.value(
                value: getIt<SelectLocationMapCubit>()..getMyLocation(),
              ),
            ],
            child: const AddSocialsData(),
          ),
        );

      case RouteStrings.addScheduleData:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<AuthCubit>(),
              ),
              BlocProvider.value(
                value: getIt<SelectLocationMapCubit>()..getMyLocation(),
              ),
            ],
            child: const AddScheduleData(),
          ),
        );

      case RouteStrings.serviceType:
        return MaterialPageRoute(
          builder: (context) => const ServiceType(),
        );
      case RouteStrings.homeLayoutScreen:
        final data = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<UserProfileCubit>(),
            child: HomeLayoutScreen(
              isGuest: data["isGuest"],
              isUser: data["isUser"],
            ),
          ),
        );
      case RouteStrings.updatePersonalInformationScreen:
        final data = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<UserProfileCubit>(),
            child: UpdatePersonalInformationScreen(
              userName: data["userName"],
            ),
          ),
        );
      case RouteStrings.updatePhoneNumberScreen:
        final data = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<UserProfileCubit>(),
            child: UpdatePhoneNumberScreen(
              phoneNumber: data["phoneNumber"],
            ),
          ),
        );
      case RouteStrings.userCarScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<CarCubit>(),
            child: const UserCarScreen(),
          ),
        );
      case RouteStrings.updateCarDataScreen:
        final data = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<AuthCubit>(),
            child:  UpdateCarDataScreen(
              showCarResponse: data["showCarResponse"],
            ),
          ),
        );
      case RouteStrings.userNotRegisteredCarData:
        return MaterialPageRoute(
          builder: (context) => const UserNotRegisteredCarData(),
        );
      case RouteStrings.addCarDataScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<AuthCubit>(),
            child: const AddCarDataScreen(),
          ),
        );
      case RouteStrings.aboutUsScreen:
        return MaterialPageRoute(
          builder: (context) => const AboutUsScreen(),
        );
      case RouteStrings.selectLocationMapScreen:
        final data = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<SelectLocationMapCubit>()..getMyLocation(),
            child: SelectLocationMapScreen(
              selectLocationMapCubit: data["selectLocationMapCubit"],
              selectedDestination: data["selectedDestination"],
            ),
          ),
        );
      case RouteStrings.languageSelectionPage:
        return MaterialPageRoute(
            builder: (context) => const LanguageSelectionPage());

      case RouteStrings.messagesScreen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<MessageCubit>(),
              ),
              BlocProvider(
                create: (context) => ChatCubit(),
              ),
            ],
            child: const MessagesScreen(),
          ),
        );

      case RouteStrings.accountCreatedSuccessfullyScreen:
        final data = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => AccountCreatedSuccessfullyScreen(
            isGuest: data["isGuest"],
            isUser: data["isUser"],
          ),
        );

      case RouteStrings.workshopProfileScreen:
        final data = settings.arguments as Map<String, dynamic>;
        final workshopId = data['workshopId'] as int;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => WorkShopForReviewsCubit(),
              ),
              BlocProvider.value(
                value: getIt<ChatCubit>(),
              ),
            ],
            child: WorkshopProfileScreen(
              id: workshopId,
            ),
          ),
        );
      case RouteStrings.workshopFeedbacksScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => WorkShopForReviewsCubit(),
            child: WorkshopFeedbacksScreen(),
          ),
        );
      case RouteStrings.paymentMethodScreen:
        return MaterialPageRoute(
          builder: (context) => const PaymentMethodScreen(),
        );
      case RouteStrings.eWalletScreen:
        return MaterialPageRoute(
          builder: (context) => const EWalletScreen(),
        );
      case RouteStrings.notificationScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => NotificationsCubit(),
            child: NotificationScreen(),
          ),
        );
      case RouteStrings.chatScreen:
        final data = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ChatCubit(),
            child: ChatScreen(
              conversationsId: data["conversationsId"],
            ),
          ),
        );
      case RouteStrings.securityScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<UserProfileCubit>(),
            child: const SecurityScreen(),
          ),
        );
      case RouteStrings.centerProfile:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => CenterProfileCubit(),
              ),
              BlocProvider(
                create: (context) => UpdateCenterCubit(),
              ),
              BlocProvider(
                create: (context) => WorkShopForReviewsCubit(),
              ),
            ],
            child: const CenterProfile(),
          ),
        );
      case RouteStrings.updatePasswordScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<UserProfileCubit>(),
            child: const UpdatePasswordScreen(),
          ),
        );
      case RouteStrings.updateWorkshopCenterProfile:
        final data = settings.arguments as GetWorkshopByIdResponse;
        // final data1 = settings.arguments as ShowWorkshopSchedulesResponse;
        // final data2 = settings.arguments as ShowWorkshopServicesResponse;
        // final data3 = settings.arguments as ShowWorkshopModelsResponse;
        // final data4 = settings.arguments as ShowWorkshopSocialsResponse;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<AuthCubit>(),
              ),
              BlocProvider.value(
                value: getIt<UpdateCenterCubit>(),
              ),
            ],
            child: UpdateWorkshopCenterProfile(
              showWorkshopDataResponse: data,
              // showWorkshopSocialsResponse: data4,
              // showWorkshopServicesResponse: data2,
              // showWorkshopModelsResponse: data3,
              // showWorkshopSchedulesResponse: data1,
            ),
          ),
        );

      case RouteStrings.updateWorkshopServices:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<AuthCubit>(),
              ),
              BlocProvider.value(
                value: getIt<UpdateCenterCubit>(),
              ),
            ],
            child: const UpdateWorkshopServices(),
          ),
        );

      case RouteStrings.updateWorkshopModel:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<AuthCubit>(),
              ),
              BlocProvider.value(
                value: getIt<UpdateCenterCubit>(),
              ),
            ],
            child: const UpdateWorkshopModel(),
          ),
        );

      case RouteStrings.updateSocialData:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<AuthCubit>(),
              ),
              BlocProvider.value(
                value: getIt<UpdateCenterCubit>(),
              ),
            ],
            child: UpdateSocialData(),
          ),
        );

        case RouteStrings.updatePhotoAlbum:
          final data = settings.arguments as  dynamic;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<AuthCubit>(),
              ),
              BlocProvider.value(
                value: getIt<UpdateCenterCubit>(),
              ),
            ],
            child:  UpdatePhotoAlbum(

            ),
          ),
        );

      case RouteStrings.updateWorkshopData:
        final data = settings.arguments as GetWorkshopByIdResponse;
        // final data1 = settings.arguments as ShowWorkshopSchedulesResponse;
        // final data2 = settings.arguments as ShowWorkshopServicesResponse;
        // final data3 = settings.arguments as ShowWorkshopModelsResponse;
        // final data4 = settings.arguments as ShowWorkshopSocialsResponse;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<AuthCubit>(),
              ),
              BlocProvider.value(
                value: getIt<UpdateCenterCubit>(),
              ),
            ],
            child: UpdateWorkshopData(
              showWorkshopDataResponse: data,
              // showWorkshopSocialsResponse: data4,
              // showWorkshopServicesResponse: data2,
              // showWorkshopModelsResponse: data3,
              // showWorkshopSchedulesResponse: data1,
            ),
          ),
        );
      case RouteStrings.favouriteScreen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<FavoriteCubit>(),
              ),
              BlocProvider.value(
                value: getIt<ChatCubit>(),
              ),
            ],
            child: const FavouriteScreen(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }
}
