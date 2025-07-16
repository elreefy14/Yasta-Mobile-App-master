import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/componant/custom_app_bar.dart';
import 'package:yasta/core/componant/custom_multi_select_dropdown_field.dart';
import 'package:yasta/core/componant/edit_user_image_widget.dart';
import 'package:yasta/core/componant/error_bottom_sheet_widget.dart';
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
import 'package:yasta/features/update_workshop_center_profile/presentation/widgets/workshop_date_widget.dart';
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

class UpdateWorkshopData extends StatefulWidget {
  UpdateWorkshopData({
    super.key,
    required this.showWorkshopDataResponse,
    //  required this.showWorkshopModelsResponse,required this.showWorkshopSchedulesResponse,required this.showWorkshopServicesResponse,required this.showWorkshopSocialsResponse
  });

  GetWorkshopByIdResponse showWorkshopDataResponse;

  // ShowWorkshopSchedulesResponse showWorkshopSchedulesResponse ;
  // ShowWorkshopServicesResponse showWorkshopServicesResponse ;
  // ShowWorkshopModelsResponse showWorkshopModelsResponse ;
  //
  // ShowWorkshopSocialsResponse showWorkshopSocialsResponse ;
  @override
  State<UpdateWorkshopData> createState() => _UpdateWorkshopDataState();
}

class _UpdateWorkshopDataState extends State<UpdateWorkshopData> {
  @override
  void initState() {
    super.initState();
    getIt<UpdateCenterCubit>().workShopImage =
        widget.showWorkshopDataResponse.data!.image!;
    getIt<UpdateCenterCubit>().WorkshopNameController.text =
        widget.showWorkshopDataResponse.data!.name ?? "";
    getIt<UpdateCenterCubit>().WorkshopAddressController.text =
        widget.showWorkshopDataResponse.data!.address!;
    getIt<UpdateCenterCubit>().WorkshopphoneNumberController.text =
        widget.showWorkshopDataResponse.data!.phone!;
    getIt<UpdateCenterCubit>().WorkshopDescriptionController.text =
        widget.showWorkshopDataResponse.data!.description!;
    // getIt<UpdateCenterCubit>().workshopServicesList=widget.showWorkshopServicesResponse.data[]!.name;

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
                  EditWorkshowLogo(
                    imageUrl:
                        getIt<UpdateCenterCubit>().workShopImage.toString(),
                    width: 120.w,
                    height: 120.h,
                  ),
                  verticalSpace(10),
                  WorkshopDateWidget(
                    isMandatory: true,
                  ),
                ],
              ),
              BlocConsumer<UpdateCenterCubit, UpdateCenterState>(
                listener: (context, state) {
                  if (state is UpdateWorkshopSuccessState) {
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
                    ).then((_) {
                      Navigator.pop(context);
                    });
                  }
                  if (state is UpdateWorkshopErrorState) {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(45.0.r)),
                      ),
                      builder: (context) {
                        return ErrorBottomSheetWidget(
                          errorText: state.message.toString(),
                        );
                      },
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
                      print(
                        getIt<UpdateCenterCubit>().WorkshopNameController.text,
                      );

                      print(getIt<UpdateCenterCubit>().selectedLogo);
                      print(getIt<UpdateCenterCubit>().workShopImage);

                      if (getIt<UpdateCenterCubit>()
                          .WorkshopNameController
                          .text
                          .isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                getLang(context, "Please enter your place name")
                                    .toString()),
                          ),
                        );
                      }
                      if (getIt<UpdateCenterCubit>()
                          .WorkshopDescriptionController
                          .text
                          .isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(getLang(context,
                                    "Add a short and clear description of your services")
                                .toString()),
                          ),
                        );
                      }
                      if (getIt<UpdateCenterCubit>()
                          .WorkshopAddressController
                          .text
                          .isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                getLang(context, "Please enter your address")
                                    .toString()),
                          ),
                        );
                      }
                      if (getIt<UpdateCenterCubit>()
                          .WorkshopphoneNumberController
                          .text
                          .isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                getLang(context, "Please enter phone number")
                                    .toString()),
                          ),
                        );
                      }

                      if(getIt<UpdateCenterCubit>()
                          .WorkshopphoneNumberController
                          .text
                          .isNotEmpty&& getIt<UpdateCenterCubit>()
                          .WorkshopAddressController
                          .text
                          .isNotEmpty &&getIt<UpdateCenterCubit>()
                          .WorkshopDescriptionController
                          .text
                          .isNotEmpty && getIt<UpdateCenterCubit>()
                          .WorkshopNameController
                          .text
                          .isNotEmpty ) {
                        getIt<UpdateCenterCubit>().selectedLogo == null
                            ? getIt<UpdateCenterCubit>().updateWorkshop(
                                workshop: UpdateWorkshop(
                                  name: getIt<UpdateCenterCubit>()
                                      .WorkshopNameController
                                      .text,
                                  description: getIt<UpdateCenterCubit>()
                                      .WorkshopDescriptionController
                                      .text,
                                  // imageFile: getIt<UpdateCenterCubit>().selectedLogo,
                                  address: getIt<UpdateCenterCubit>()
                                      .WorkshopAddressController
                                      .text,
                                  phone: getIt<UpdateCenterCubit>()
                                      .WorkshopphoneNumberController
                                      .text,
                                ),
                              )
                            : getIt<UpdateCenterCubit>().updateWorkshop(
                                workshop: UpdateWorkshop(
                                  name: getIt<UpdateCenterCubit>()
                                      .WorkshopNameController
                                      .text,
                                  description: getIt<UpdateCenterCubit>()
                                      .WorkshopDescriptionController
                                      .text,
                                  imageFile:
                                      getIt<UpdateCenterCubit>().selectedLogo,
                                  address: getIt<UpdateCenterCubit>()
                                      .WorkshopAddressController
                                      .text,
                                  phone: getIt<UpdateCenterCubit>()
                                      .WorkshopphoneNumberController
                                      .text,
                                ),
                              );
                      }
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
