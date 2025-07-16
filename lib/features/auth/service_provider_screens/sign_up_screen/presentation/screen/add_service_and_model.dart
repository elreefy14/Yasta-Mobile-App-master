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

class AddServiceAndModel extends StatefulWidget {
  const AddServiceAndModel({super.key});

  @override
  State<AddServiceAndModel> createState() => _AddServiceAndModelState();
}

class _AddServiceAndModelState extends State<AddServiceAndModel> {
  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      children: [
        HeaderWidget1(
          headerTitle:
              getLang(context, "Add your available services and brands")
                  .toString(),
          title:"",
          greenIndicators: 1, // Number of green indicators
          totalIndicators: 4, // Optional, defaults to 5
        ),
        verticalSpace(40),
        const ServicesAndAvailableBrandWidget(),
        verticalSpace(30),
        const Divider(),
        DefaultButton(
          label: getLang(context, "Save data").toString(),
          onPressed: () {
            getIt<AuthCubit>().addServices(
              addServicesModel: AddServicesModel(
                services: getIt<AuthCubit>().workshopServicesList,
              ),
            );
          },
        ),
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AddServicesSuccessState) {
              getIt<AuthCubit>().addModels(
                addModelsModel: AddModelsModel(
                  models: getIt<AuthCubit>().allModelsList,
                ),
              );
            }
            if (state is AddServicesErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            if (state is AddModelsErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            if (state is AddModelsSuccessState) {
              CacheHelper.saveData(
                  key: "stage",
                  value:  "3")
                  .then((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteStrings.addScheduleData,
                      (Route<dynamic> route) => false,
                );
              });

            }
          },
          child: const SizedBox.shrink(),
        ),
        verticalSpace(40),
      ],
    );
  }
}
