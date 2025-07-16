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

class UpdateWorkshopCenterProfile extends StatefulWidget {
  UpdateWorkshopCenterProfile({super.key, required this.showWorkshopDataResponse,
  //  required this.showWorkshopModelsResponse,required this.showWorkshopSchedulesResponse,required this.showWorkshopServicesResponse,required this.showWorkshopSocialsResponse

  });

  GetWorkshopByIdResponse showWorkshopDataResponse;
  // ShowWorkshopSchedulesResponse showWorkshopSchedulesResponse ;
  // ShowWorkshopServicesResponse showWorkshopServicesResponse ;
  // ShowWorkshopModelsResponse showWorkshopModelsResponse ;
  //
  // ShowWorkshopSocialsResponse showWorkshopSocialsResponse ;
  @override
  State<UpdateWorkshopCenterProfile> createState() =>
      _UpdateWorkshopCenterProfileState();
}

class _UpdateWorkshopCenterProfileState
    extends State<UpdateWorkshopCenterProfile> {
  List<Widget> socialMediaLinks = [];
  List<String> socialMediaLink = ["link 1", "link 2"];
  List<TextEditingController> socialMediaControllers = [];

  @override
  void initState() {
    super.initState();
    getIt<UpdateCenterCubit>().workShopImage=widget.showWorkshopDataResponse.data!.image!;
    getIt<UpdateCenterCubit>().WorkshopNameController.text=widget.showWorkshopDataResponse.data!.name??"";
    getIt<UpdateCenterCubit>().WorkshopAddressController.text=widget.showWorkshopDataResponse.data!.address!;
    getIt<UpdateCenterCubit>().WorkshopphoneNumberController.text=widget.showWorkshopDataResponse.data!.phone!;
    getIt<UpdateCenterCubit>().WorkshopDescriptionController.text=widget.showWorkshopDataResponse.data!.description!;
   // getIt<UpdateCenterCubit>().workshopServicesList=widget.showWorkshopServicesResponse.data[]!.name;

    getIt<AuthCubit>().getServices();
    getIt<AuthCubit>().getAllModels();
   print(getIt<UpdateCenterCubit>().selectedWorkshopServices) ;
   print(getIt<UpdateCenterCubit>().selectedAllModel) ;
    // Remove getLang calls from initState
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Populate `socialMediaLinks` in didChangeDependencies with localized values
    // Initialize controllers for each link
    for (var link in socialMediaLink) {
      socialMediaControllers.add(TextEditingController(text: link));
    }

    // Initialize social media links widgets
    for (var controller in socialMediaControllers) {
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
    var newController = TextEditingController();
    socialMediaControllers.add(newController);
    setState(() {
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
                  EditWorkshowLogo(
                    imageUrl: getIt<UpdateCenterCubit>().workShopImage.toString(),
                    width: 120.w,
                    height: 120.h,
                  ),
                  verticalSpace(10),
                  WorkshopDetailsWidget(
                    isMandatory: true,
                  ),
                ],
              ),
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
                    // return  CustomMultiSelectDropdownField<String>(
                    //     label: "Select Services",
                    //     hintText: "Choose services",
                    //     selectedValues: getIt<AuthCubit>().selectedWorkshopServices, // Pre-selected items
                    //     items: getIt<AuthCubit>()
                    //           .workshopServices
                    //           .map((item) => item['name']!)
                    //           .toList(), // List of all items
                    //     isMandatory: true, // Optional: mark as mandatory
                    //     onChanged: (selectedItems) {
                    //       setState(() {
                    //         getIt<AuthCubit>().selectedWorkshopServices = selectedItems;
                    //         print(getIt<AuthCubit>().selectedWorkshopServices);// Update the selected list
                    //         print(selectedItems);// Update the selected list
                    //       });
                    //     },
                    //   );
                      return CustomMultiSelectDropdownField<String>(
                        label: getLang(context, "Services").toString(),
                        hintText: getLang(context, "Choose your service").toString(),
                        selectedValues: getIt<UpdateCenterCubit>().selectedWorkshopServices, // Pre-selected items
                        items: getIt<UpdateCenterCubit>()
                            .workshopServices
                            .map((item) => item['name']!)
                            .toList(), // All available items
                        onChanged: (selectedItems) {
                          // Update selectedWorkshopServices with the newly selected items
                          //getIt<AuthCubit>().selectedWorkshopServices = selectedItems;

                          // Map the selected names to their corresponding IDs
                          setState(() {
                            getIt<UpdateCenterCubit>().workshopServicesList.add(getIt<UpdateCenterCubit>()
                                .workshopServices
                                .where((item) => selectedItems.contains(item['name'])) // Match names
                                .map((item) => item['id']!) // Extract IDs
                                .toString());
                          });
                          // Debugging logs
                          print("Selected items: $selectedItems");
                          print("Workshop services IDs: ${getIt<UpdateCenterCubit>().workshopServicesList}");
                        },
                      );
                    },
                  ),


                ],
              ),
              CardTemplate(
                children: [
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is GetAllModelsSuccessState) {
                        getIt<UpdateCenterCubit>().allModels = state.data!.data!
                            .map((e) => {'name': e.name!, 'id': e.id.toString()})
                            .toList();
                      }
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      return CustomMultiSelectDropdownField<String>(
                        label: getLang(context, "Brand").toString(),
                        hintText: getLang(context, "Choose the brands available to you").toString(),
                        selectedValues: getIt<UpdateCenterCubit>().selectedAllModel,
                        items: getIt<UpdateCenterCubit>()
                            .allModels
                            .map((item) => item['name']!)
                            .toList(),
                        onChanged: (selectedItems) {

                          getIt<UpdateCenterCubit>().allModelsList = getIt<UpdateCenterCubit>()
                              .allModels
                              .where((item) => selectedItems.contains(item['name'])) // Match based on 'name'
                              .map((item) => item['id']!) // Extract 'id'
                              .toList();

                          // getIt<AuthCubit>().workshopServicesList.add(selectedItems.toString());
                          print("Selected items: $selectedItems");
                          print(getIt<UpdateCenterCubit>().allModelsList);
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
                  // verticalSpace(20),
                  // ListView.separated(
                  //   shrinkWrap: true,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   itemBuilder: (context, index) {
                  //     return CustomDropdownField(
                  //       label:
                  //           "${getLang(context, "Models")} ${index + 1} ${getLang(context, "Available").toString()} :",
                  //       hintText:
                  //           getLang(context, "Choose the brands available to you")
                  //               .toString(),
                  //       items: [],
                  //     );
                  //   },
                  //   separatorBuilder: (context, index) => verticalSpace(20),
                  //   itemCount: 2,
                  // ),
                ],
              ),
              CardTemplate(
                children: [
                  PhotoAlbum(),
                ],
              ),
              CardTemplate(
                children: [
                  AppointmentsWidget(),
                ],
              ),
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
                  getIt<UpdateCenterCubit>().updateWorkshop(
                    workshop: UpdateWorkshop(
                      name: getIt<UpdateCenterCubit>().WorkshopNameController.text,
                      description:
                      getIt<UpdateCenterCubit>().WorkshopDescriptionController.text,
                      imageFile: getIt<UpdateCenterCubit>().selectedLogo!,
                      address: getIt<UpdateCenterCubit>().WorkshopAddressController.text,
                      phone: getIt<UpdateCenterCubit>().WorkshopphoneNumberController.text,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
