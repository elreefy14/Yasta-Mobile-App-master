import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/componant.dart';
import 'package:yasta/core/componant/custom_text_form_field_with_label.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/features/auth/auth_layput_screen.dart';
import 'package:country_picker/country_picker.dart';
import 'package:yasta/features/auth/data/models/resend_otp.dart';
import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';

import '../../../../core/componant/password_text_form_field_with_lable.dart';
import '../../../../core/componant/phone_number_Input.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helper/app_color/app_color.dart';
import '../../../../core/route/route_strings/route_strings.dart';
import '../../../../core/theme/text_styles.dart';

class AddPhoneInForgetPassword extends StatefulWidget {
  const AddPhoneInForgetPassword({super.key});

  @override
  State<AddPhoneInForgetPassword> createState() =>
      _AddPhoneInForgetPasswordState();
}

class _AddPhoneInForgetPasswordState extends State<AddPhoneInForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      children: [
        Text(
          getLang(context, "Enter the phone number.").toString(),
          style: TextStyles.blackFS18FW700CandaraTextStyle,
          textAlign: TextAlign.center,
        ),
        Text(
          getLang(context,
                  "A code will be sent to your phone number to confirm your identity and reset your password.")
              .toString(),
          style: TextStyles.gray100FS14FW400CairoTextStyle,
          textAlign: TextAlign.center,
        ),
        verticalSpace(33.h),
        PhoneNumberInput(
          controller: getIt<AuthCubit>().userPhoneController,
          onPhoneCodeChanged: getIt<AuthCubit>().onPhoneCodeChanged,
        ),
        verticalSpace(24.h),
        DefaultButton(
            color: ColorsManager.blackColor,
            onPressed: () {
              // CacheHelper.saveData(key: "phone", value: phoneController.text);
              // CacheHelper.saveData(key: "password", value: passwordController.text);
              Navigator.pushNamed(context, RouteStrings.verificationCodeScreen,
                  arguments: {
                    "phone": getIt<AuthCubit>().userPhoneController.text,
                    "userType": "Change Password"
                  });
              getIt<AuthCubit>().reSendOtp(reSendOTPModel: ReSendOTPModel(
                phone: getIt<AuthCubit>().userPhoneController.text,
              ));
            },
            child: Text(
              getLang(context, "next").toString(),
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            )),
      ],
    );
  }
}
