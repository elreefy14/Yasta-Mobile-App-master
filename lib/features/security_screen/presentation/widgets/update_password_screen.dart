import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/custom_text_form_field_with_label.dart';
import 'package:yasta/core/componant/edit_user_image_widget.dart';
import 'package:yasta/core/componant/password_text_form_field_with_lable.dart';
import 'package:yasta/features/user_profile_screen/data/models/updated_password_request_body.dart';
import 'package:yasta/features/user_profile_screen/logic/user_profile_cubit.dart';
import '../../../../core/componant/error_bottom_sheet_widget.dart';
import '../../../../core/componant/success_bottom_sheet_widget.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helper/spacing/spacing.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../preview_data_layout/presentation/screen/preview_data_layout.dart';
import '../../../preview_data_layout/presentation/widgets/preview_data_update_item.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  TextEditingController currentPasswordController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PreviewDataLayout(
        appBarTitle: getLang(context, "Change password").toString(),
        children: [
          PreviewDataUpdateItem(
            onSavedPressed: () {
              // Show BottomSheet on save
              getIt<UserProfileCubit>().updatePassword(
                updatedPasswordRequestBody: UpdatedPasswordRequestBody(
                    passwordCurrent: currentPasswordController.text,
                    password: newPasswordController.text,
                    passwordConfirmation: confirmPasswordController.text),
              );
              // showModalBottomSheet(
              //   isScrollControlled: true,
              //   context: context,
              //   shape: RoundedRectangleBorder(
              //     borderRadius:
              //         BorderRadius.vertical(top: Radius.circular(45.0.r)),
              //   ),
              //   builder: (context) {
              //     return SuccessBottomSheetWidget(
              //       successText: getLang(context,
              //               "Your profile has been updated successfully.")
              //           .toString(),
              //     );
              //   },
              // );
            },
            onCancelPressed: () {
              Navigator.pop(context);
            },
            children: [
              Text(
                getLang(context, "Change password").toString(),
                style: TextStyles.gray900FS16FW500CairoTextStyle,
              ),
              verticalSpace(30),
              PasswordTextFormFieldWithLable(
                label: getLang(context, "Current password").toString(),
                hintText: getLang(context, "Enter Current password").toString(),
                controller: currentPasswordController,
              ),
              verticalSpace(20),
              PasswordTextFormFieldWithLable(
                label: getLang(context, "New password").toString(),
                hintText: getLang(context, "Enter New password").toString(),
                controller: newPasswordController,
              ),
              verticalSpace(20),
              PasswordTextFormFieldWithLable(
                label: getLang(context, "Confirm new password").toString(),
                hintText:
                    getLang(context, "Enter Confirm new password").toString(),
                controller: confirmPasswordController,
              ),
              BlocListener<UserProfileCubit, UserProfileState>(
                listener: (context, state) {
                  if (state is UpdatePasswordSuccessState) {
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
                                  "Your profile has been updated successfully.")
                              .toString(),
                        );
                      },
                    ).then((_){
                      Navigator.pop(context);
                    });
                  } else if (state is UpdatePasswordErrorState) {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(45.0.r)),
                      ),
                      builder: (context) {
                        return ErrorBottomSheetWidget(
                          errorText: state.message,
                        );
                      },
                    );
                  }
                },
                child: const SizedBox.shrink(),
              )
            ],
          ),
        ],
      ),
    );
  }
}
