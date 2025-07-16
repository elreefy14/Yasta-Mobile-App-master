import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yasta/core/app_cubit/app_cubit.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/features/auth/auth_layput_screen.dart';
import 'package:yasta/features/auth/data/models/add_models.dart';
import 'package:yasta/features/auth/data/models/add_services_model.dart';
import 'package:yasta/features/auth/data/models/add_socials_model.dart';
import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';
import '../../../../../../core/app_local/app_local.dart';
import '../../../../../../core/componant/default_button.dart';
import '../../../../../../core/helper/cache_helper/cache_helper.dart';
import '../../../../../../core/route/route_strings/route_strings.dart';
import '../../../../data/models/add_workshop_model.dart';
import '../../../../data/models/schedule_model.dart';
import '../../../../data/models/workshop_schedules_request_body.dart';
import '../../logic/select_location_map_cubit.dart';
import '../widgets/appointments_widget.dart';
import '../widgets/available_brand_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/photo_album.dart';
import '../widgets/social_media_widget.dart';
import '../widgets/workshop_details_widget.dart';
import '../../../../../../core/di/dependency_injection.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      children: [
        const HeaderWidget(),
        verticalSpace(40),
        WorkshopDetailsWidget(
          selectLocationMapCubit: SelectLocationMapCubit(),
          selectedDestination: getIt<AuthCubit>().selectedDestination,
        ),
        verticalSpace(30),
        const Divider(),
        verticalSpace(30),
        const ServicesAndAvailableBrandWidget(),
        verticalSpace(30),
        const Divider(),
        verticalSpace(30),
        PhotoAlbum(),
        verticalSpace(40),
        const Divider(),
        verticalSpace(40),
        AppointmentsWidget(),
        verticalSpace(30),
        const Divider(),
        verticalSpace(30),
        const SocialMediaWidget(),
        verticalSpace(40),
        DefaultButton(
          label: getLang(context, "Save data").toString(),
          onPressed: () {
            getIt<AuthCubit>().addWorkshop(
                workshop: Workshop(
              name: getIt<AuthCubit>().WorkshopNameController.text,
              description:
                  getIt<AuthCubit>().WorkshopDescriptionController.text,
              imageFile: getIt<AuthCubit>().selectedLogo!,
              address: getIt<AuthCubit>().WorkshopAddressController.text,
              phone: getIt<AuthCubit>().WorkshopphoneNumberController.text,
              images: getIt<AuthCubit>().selectedImages,
              latitude: getIt<AuthCubit>()
                  .selectedDestination!
                  .latitude
                  .toString(),
              longitude: getIt<AuthCubit>()
                  .selectedDestination!
                  .longitude
                  .toString(),
            ),
            );
          },
        ),
        BlocListener<AuthCubit, AuthState>(
          listenWhen: (context, state) =>
              state is AddWorkshopSuccessState ||
              state is AddWorkshopErrorState ||
              state is AddServicesSuccessState ||
              state is AddScheduleSuccessState ||
              state is AddSocialsSuccessState ||
              state is AddModelsSuccessState,
          listener: (context, state) {
            if (state is AddWorkshopSuccessState) {
              getIt<AuthCubit>().sendSocialsData(context);
              // getIt<AuthCubit>().addServices(
              //   addServicesModel: AddServicesModel(
              //     services: getIt<AuthCubit>().workshopServicesList,
              //   ),
              // );
            }
            if (state is AddWorkshopErrorState) {
              getIt<AuthCubit>().sendSocialsData(context);

            }
            if (state is AddServicesSuccessState) {
              getIt<AuthCubit>().addModels(
                addModelsModel: AddModelsModel(
                  models: getIt<AuthCubit>().allModelsList,
                ),
              );
            }
            if (state is AddModelsSuccessState) {
              Navigator.pushNamed(
                context,
                RouteStrings.accountCreatedSuccessfullyScreen,
                arguments: {
                  "isGuest": false,
                  "isUser": false,
                },
              );
            }
            if (state is AddScheduleSuccessState) {
              getIt<AuthCubit>().addServices(
                addServicesModel: AddServicesModel(
                  services: getIt<AuthCubit>().workshopServicesList,
                ),
              );
            }
            if(state is AddScheduleErrorState){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            if(state is AddSocialsErrorState){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            if (state is AddSocialsSuccessState) {
              List<ScheduleModel> schedules =
              getIt<AuthCubit>().workingHours.map((workingHour) {
                return ScheduleModel(
                  dayWeek: workingHour['dayController'],
                  // Ensure it's a compatible type
                  openingTime:
                  "${workingHour['fromHourController'].text}:${workingHour['fromMinuteController'].text==""?"00":workingHour['fromMinuteController'].text}",
                  closingTime:
                  "${workingHour['toHourController'].text}:${workingHour['toMinuteController'].text==""?"00":workingHour['fromMinuteController'].text}",
                );
              }).toList();

              getIt<AuthCubit>().addSchedules(
                schedules: WorkshopSchedulesRequestBody(schedules: schedules),
              );

            }

          },
          child: const SizedBox.shrink(),
        ),
        verticalSpace(40),
      ],
    );
  }
}

String getPlatformFromLink(String link) {
  try {
    Uri uri = Uri.parse(link);

    // Extract the host from the URL
    String host = uri.host;

    // Determine the platform based on the host
    if (host.contains("facebook.com")) {
      return "Facebook";
    } else if (host.contains("instagram.com")) {
      return "Instagram";
    } else if (host.contains("twitter.com")) {
      return "Twitter";
    } else if (host.contains("linkedin.com")) {
      return "LinkedIn";
    } else if (host.contains("youtube.com")) {
      return "YouTube";
    } else if (host.contains("web.whatsapp.com")) {
      return "WhatsApp Web";
    } else {
      return "Unknown Platform";
    }
  } catch (e) {
    return "Invalid URL";
  }
}
