import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/componant/custom_app_bar.dart';
import 'package:yasta/core/componant/custom_multi_select_dropdown_field.dart';
import 'package:yasta/core/componant/edit_user_image_widget.dart';
import 'package:yasta/core/constants/constants.dart';
import 'package:yasta/core/di/dependency_injection.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/core/route/route_strings/route_strings.dart';
import 'package:yasta/features/auth/data/models/add_services_model.dart';
import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:yasta/features/center_profile/data/models/show_workshop_data_response.dart';
import 'package:yasta/features/center_profile/data/models/show_workshop_models_response.dart';
import 'package:yasta/features/center_profile/data/models/show_workshop_schedules_response.dart';
import 'package:yasta/features/center_profile/data/models/show_workshop_services_response.dart';
import 'package:yasta/features/center_profile/data/models/show_workshop_socials_response.dart';
import 'package:yasta/features/update_workshop_center_profile/data/logic/update_center_cubit.dart';
import 'package:yasta/features/update_workshop_center_profile/data/model/update_workShop.dart';
import 'package:yasta/features/update_workshop_center_profile/presentation/widgets/edit_workShow_logo.dart';
import 'package:yasta/features/workshop_profile/model/get_workshop_byId_response.dart';
import '../../../../core/app_local/app_local.dart';
import '../../../../core/componant/custom_dropdown_field_with_label.dart';
import '../../../../core/componant/custom_text_form_field_with_label.dart';
import '../../../../core/componant/save_cancel_buttons.dart';
import '../../../../core/componant/success_bottom_sheet_widget.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../auth/data/models/add_workshop_model.dart';
import '../../../auth/service_provider_screens/sign_up_screen/presentation/widgets/appointments_widget.dart';
import '../../../auth/service_provider_screens/sign_up_screen/presentation/widgets/photo_album.dart';
import '../../../auth/service_provider_screens/sign_up_screen/presentation/widgets/workshop_details_widget.dart';
import '../widgets/card_template.dart';

class UpdateWorkshopServices extends StatefulWidget {
  const UpdateWorkshopServices({
    super.key,
  });

  // ShowWorkshopSchedulesResponse showWorkshopSchedulesResponse ;
  // ShowWorkshopServicesResponse showWorkshopServicesResponse ;
  // ShowWorkshopModelsResponse showWorkshopModelsResponse ;
  //
  // ShowWorkshopSocialsResponse showWorkshopSocialsResponse ;
  @override
  State<UpdateWorkshopServices> createState() => _UpdateWorkshopServicesState();
}

class _UpdateWorkshopServicesState extends State<UpdateWorkshopServices> {
  @override
  void initState() {
    super.initState();

    getIt<AuthCubit>().getServices();
    print(getIt<UpdateCenterCubit>().selectedWorkshopServices);

    // Remove getLang calls from initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray100,
      appBar: CustomAppBar(
        title: getLang(context, "Edit Workshop Center Profile").toString(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Constants.hPadding,
          vertical: Constants.hPadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardTemplate(
                children: [
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is GetServicesSuccessState) {
                        getIt<UpdateCenterCubit>().workshopServices = state.data!.data!
                            .map((e) => {'name': e.name!, 'id': e.id.toString()})
                            .toList();

                      }
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      return CustomMultiSelectDropdownField<String>(
                        label: getLang(context, "Services").toString(),
                        hintText: getLang(context, "Choose your service").toString(),
                        selectedValues: getIt<UpdateCenterCubit>().selectedWorkshopServices.toSet().toList(),
                        items: getIt<UpdateCenterCubit>()
                            .workshopServices
                            .map((item) => item['name']!)
                            .toList(),
                        onChanged: (selectedItems) {
                          getIt<UpdateCenterCubit>().workshopServicesList = getIt<UpdateCenterCubit>()
                              .workshopServices
                              .where((item) => selectedItems.contains(item['name'])) // Match based on 'name'
                              .map((item) => item['id']!) // Extract 'id'
                              .toList();

                          // getIt<AuthCubit>().workshopServicesList.add(selectedItems.toString());
                          print("Selected items: $selectedItems");
                          print(getIt<UpdateCenterCubit>().workshopServicesList);
                        },
                      );
                      // return CustomDropdownField(
                      //   isMandatory: true,
                      //   label: getLang(context, "Services").toString(),
                      //   hintText: getLang(context, "Choose your service").toString(),
                      //   items: AuthCubit
                      //       .get(context)
                      //       .workshopServices,
                      //
                      // );
                    },
                  ),
                ],
              ),
              verticalSpace(20),
              BlocConsumer<UpdateCenterCubit, UpdateCenterState>(
                listener: (context, state) {
                  if (state is UpdateServicesSuccessState) {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(45.0.r)),
                      ),
                      builder: (context) {
                        return SuccessBottomSheetWidget(
                          successText: getLang(context,
                              "Your center profile data has been updated successfully.")
                              .toString(),
                        );
                      },
                    ).then((_){
                      Navigator.pop(context);
                    });
                  }
                  if (state is UpdateServicesErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                  // TODO: implement listener
                },
                builder: (context, state) {
                  return SaveCancelButtons(
                    onCancelPressed: () {
                      Navigator.pop(context);
                    },
                    onSavedPressed: () {
                      getIt<UpdateCenterCubit>().updateServices(
                        addServicesModel: AddServicesModel(
                          services:
                              getIt<UpdateCenterCubit>().workshopServicesList,
                        ),
                      );
                      // showModalBottomSheet(
                      //   isScrollControlled: true,
                      //   context: context,
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius:
                      //     BorderRadius.vertical(top: Radius.circular(45.0.r)),
                      //   ),
                      //   builder: (context) {
                      //     return SuccessBottomSheetWidget(
                      //       successText: getLang(context,
                      //           "Your center profile data has been updated successfully.")
                      //           .toString(),
                      //     );
                      //   },
                      // );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
