import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/componant.dart';
import 'package:yasta/core/componant/custom_text_form_field_with_label.dart';
import 'package:yasta/core/componant/success_bottom_sheet_widget.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/features/auth/auth_layput_screen.dart';
import 'package:country_picker/country_picker.dart';
import 'package:yasta/features/auth/data/models/forget_password.dart';
import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';

import '../../../../core/componant/password_text_form_field_with_lable.dart';
import '../../../../core/componant/phone_number_Input.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helper/app_color/app_color.dart';
import '../../../../core/route/route_strings/route_strings.dart';
import '../../../../core/theme/text_styles.dart';
class ChangePassword extends StatelessWidget {
   ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      children: [
        Text(
          getLang(context, "Change password").toString(),
          style: TextStyles.blackFS18FW700CandaraTextStyle,
          textAlign: TextAlign.center,
        ),
        Text(
          getLang(context, "Be sure to choose a strong password that contains a combination of uppercase and lowercase letters, numbers, and symbols").toString(),
          style: TextStyles.gray100FS14FW400CairoTextStyle,
          textAlign: TextAlign.center,
        ),
        verticalSpace(33.h),
        PasswordTextFormFieldWithLable(
          controller:  getIt<AuthCubit>().newPasswordController,
          hintText: getLang(context, "Enter New password").toString(),
          label: getLang(context, "New password").toString(),
        ),
        verticalSpace(33.h),
        PasswordTextFormFieldWithLable(
          controller:  getIt<AuthCubit>().ConfirmPasswordController,
          hintText: getLang(context, "Enter Confirm new password").toString(),
          label: getLang(context, "Confirm new password").toString(),
        ),
        verticalSpace(33.h),
        DefaultButton(
            color: ColorsManager.blackColor,
            onPressed: () {
              print(getIt<AuthCubit>().userPhoneController.text);
              getIt<AuthCubit>().forgetPassword(forgetPassWordModel: ForgetPassWordModel(
                phone: getIt<AuthCubit>().userPhoneController.text,
                token: getIt<AuthCubit>().VerifyOTPForgetPassword,
                password: getIt<AuthCubit>().newPasswordController.text,
                passwordConfirmation: getIt<AuthCubit>().ConfirmPasswordController.text
              ));
            },
            child: Text(
              getLang(context, "Change password").toString(),
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            )),

        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {

            if (state is ForgetPasswordSuccessState) {
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
                        "Your Password has been updated successfully.")
                        .toString(),
                  );
                },
              ).then((_){
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteStrings.loginScreen,
                      (Route<dynamic> route) => false,
                );
              });

            }
            if (state is ForgetPasswordErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }

          },
          child: const SizedBox.shrink(),
        )
      ],
    );
  }
}
