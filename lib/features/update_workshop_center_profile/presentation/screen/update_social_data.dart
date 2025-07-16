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

class UpdateSocialData extends StatefulWidget {
const  UpdateSocialData({super.key,
    //  required this.showWorkshopModelsResponse,required this.showWorkshopSchedulesResponse,required this.showWorkshopServicesResponse,required this.showWorkshopSocialsResponse

  });

  // ShowWorkshopSchedulesResponse showWorkshopSchedulesResponse ;
  // ShowWorkshopServicesResponse showWorkshopServicesResponse ;
  // ShowWorkshopModelsResponse showWorkshopModelsResponse ;
  //
  // ShowWorkshopSocialsResponse showWorkshopSocialsResponse ;
  @override
  State<UpdateSocialData> createState() =>
      _UpdateSocialDataState();
}

class _UpdateSocialDataState
    extends State<UpdateSocialData> {



List<Widget>socialMediaLinks=[];
  @override
  void initState() {
    print(getIt<UpdateCenterCubit>().socialMediaLink);
    getIt<UpdateCenterCubit>().workshopSocialControllers.clear();
    super.initState();
    // Remove getLang calls from initState
  }

@override
void didChangeDependencies() {
  super.didChangeDependencies();

  // Initialize controllers for each valid link
  for (var link in getIt<UpdateCenterCubit>().socialMediaLink) {
    if (link.isNotEmpty) { // Check if the link is not empty
      if (!getIt<UpdateCenterCubit>().workshopSocialControllers
          .any((controller) => controller.text == link)) {
        getIt<UpdateCenterCubit>().workshopSocialControllers
            .add(TextEditingController(text: link));
      }
    }
  }

  // Initialize social media links widgets
  for (var controller in getIt<UpdateCenterCubit>().workshopSocialControllers) {
    socialMediaLinks.add(
      Column(
        children: [
          verticalSpace(20),
          CustomTextFormFieldWithLabel(
            label: getLang(context, "Social media").toString(),
            hintText: getLang(context, "Add link here").toString(),
            controller: controller,
          ),
        ],
      ),
    );
  }
}


  // Method to add a new CustomTextFormFieldWithLabel for social media links
void addSocialMediaLink() {
  setState(() {
    var newController = TextEditingController();
     getIt<UpdateCenterCubit>().workshopSocialControllers.add(newController);
    socialMediaLinks.add(
      Column(
        children: [
          verticalSpace(20),
          CustomTextFormFieldWithLabel(
            label: getLang(context, "Social media").toString(),
            hintText: getLang(context, "Add link here").toString(),
            controller: newController,
          ),
        ],
      ),
    );
  });
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
                  ...socialMediaLinks,
                  verticalSpace(30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gray100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        side: const BorderSide(color: Color(0xFF9CA3AF)),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 15.h,
                      ),
                    ),
                    onPressed: addSocialMediaLink,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add, color: AppColors.gray600),
                        horizontalSpace(10),
                        Text(
                          getLang(context, "Add another link").toString(),
                          style: TextStyles.gray600FS14FW400CairoTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              verticalSpace(20),
              SaveCancelButtons(
                onCancelPressed: () {
                  Navigator.pop(context);
                },
                onSavedPressed: () {
                  getIt<UpdateCenterCubit>().sendSocialsData(context);


                },
              ),

              BlocListener<UpdateCenterCubit, UpdateCenterState>(
                listener: (context, state) {
                  if(state is UpdateSocialsErrorState){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                  if (state is UpdateSocialsSuccessState) {
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

                },
                child: const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
