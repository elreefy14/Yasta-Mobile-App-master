
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:yasta/core/componant/custom_app_bar.dart';
import 'package:yasta/core/componant/custom_multi_select_dropdown_field.dart';
import 'package:yasta/core/componant/success_bottom_sheet_widget.dart';

import 'package:yasta/core/constants/constants.dart';
import 'package:yasta/core/di/dependency_injection.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/core/route/route_strings/route_strings.dart';
import 'package:yasta/features/auth/data/models/add_models.dart';
import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';

import 'package:yasta/features/update_workshop_center_profile/data/logic/update_center_cubit.dart';

import '../../../../core/app_local/app_local.dart';

import '../../../../core/componant/save_cancel_buttons.dart';

import '../../../../core/theme/colors.dart';

import '../widgets/card_template.dart';

class UpdateWorkshopModel extends StatefulWidget {
  const UpdateWorkshopModel({super.key,
  });


  // ShowWorkshopSchedulesResponse showWorkshopSchedulesResponse ;
  // ShowWorkshopServicesResponse showWorkshopServicesResponse ;
  // ShowWorkshopModelsResponse showWorkshopModelsResponse ;
  //
  // ShowWorkshopSocialsResponse showWorkshopSocialsResponse ;
  @override
  State<UpdateWorkshopModel> createState() =>
      _UpdateWorkshopModelState();
}

class _UpdateWorkshopModelState
    extends State<UpdateWorkshopModel> {


  @override
  void initState() {
    super.initState();

    getIt<AuthCubit>().getAllModels();
    print(getIt<UpdateCenterCubit>().selectedAllModel) ;

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
                      if (state is GetAllModelsSuccessState) {
                        getIt<UpdateCenterCubit>().allModels = state.data!.data!
                            .map((e) => {'name': e.name!, 'id': e.id.toString()})
                            .toList();
                      }
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      return CustomMultiSelectDropdownField<String>(
                        label: getLang(context, "Model:").toString(),
                        hintText: getLang(context, "Choose the brands available to you").toString(),
                        selectedValues: getIt<UpdateCenterCubit>().selectedAllModel.toSet().toList(),
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
              verticalSpace(20),
              BlocConsumer<UpdateCenterCubit, UpdateCenterState>(
                listener: (context, state) {
                  if (state is UpdateModelsSuccessState) {
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
                  getIt<UpdateCenterCubit>().updateModels(
                    addModelsModel: AddModelsModel(
                      models: getIt<UpdateCenterCubit>().allModelsList,
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
