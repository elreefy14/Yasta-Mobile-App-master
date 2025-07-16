import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/componant.dart';
import 'package:yasta/core/componant/custom_text_form_field_with_label.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/features/auth/auth_layput_screen.dart';
import 'package:country_picker/country_picker.dart';
import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:yasta/features/service_provider/ui/widget/or_widget.dart';

import '../../../../core/componant/error_bottom_sheet_widget.dart';
import '../../../../core/componant/password_text_form_field_with_lable.dart';
import '../../../../core/componant/phone_number_Input.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helper/app_color/app_color.dart';
import '../../../../core/helper/cache_helper/cache_helper.dart';
import '../../../../core/route/route_strings/route_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../data/models/register_request_body.dart';

class SignUpPersonalData extends StatefulWidget {
  SignUpPersonalData({super.key, required this.userType});

  final String userType;

  @override
  State<SignUpPersonalData> createState() => _SignUpPersonalDataState();
}

class _SignUpPersonalDataState extends State<SignUpPersonalData> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: AuthLayout(
        children: [
          Text(
            getLang(context, "join us").toString(),
            style: TextStyles.blackFS18FW700CandaraTextStyle,
            textAlign: TextAlign.center,
          ),
          Text(
            getLang(context, "Log in to access all our services").toString(),
            style: TextStyles.gray100FS14FW400CairoTextStyle,
            textAlign: TextAlign.center,
          ),
          verticalSpace(33.h),
          CustomTextFormFieldWithLabel(
            controller: getIt<AuthCubit>().firstUserNameController,
            hintText: getLang(context, "Enter your first name").toString(),
            label: getLang(context, "your first name").toString(),
            validator: (value) {
              if (value!.isEmpty) {
                return "First name can not be empty";
              }
              return null;
            },
          ),
          verticalSpace(24.h),
          CustomTextFormFieldWithLabel(
            controller: getIt<AuthCubit>().lastUserNameController,
            hintText: getLang(context, "Enter your last name").toString(),
            label: getLang(context, "your last name").toString(),
            validator: (value) {
              if (value!.isEmpty) {
                return "Last name can not be empty";
              }
              return null;
            },
          ),
          verticalSpace(24.h),
          PhoneNumberInput(
            controller: getIt<AuthCubit>().userSignUpPhone,
            onPhoneCodeChanged: (value) {
              getIt<AuthCubit>().onPhoneCodeChanged(value);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return getLang(context, "Please enter phone number");
              }
              else if (value.length != 11) {
                return getLang(context, "Please enter valid phone number");
              }
              return null;
            },
            // validator: (value) {
            //   if (value!.isEmpty &&
            //       getIt<AuthCubit>().userSignUpPhone.text.isEmpty) {
            //     return "Phone number can not be empty";
            //   } else if (getIt<AuthCubit>().userSignUpPhone.text.length !=
            //       10) {
            //     return "Phone number must be 10 digits";
            //   }
            //   return null;
            // },
          ),
          verticalSpace(24.h),
          PasswordTextFormFieldWithLable(
            controller: getIt<AuthCubit>().userSignUpPassword,
            hintText: getLang(context, "Enter your password:").toString(),
            label: getLang(context, "your password:").toString(),
            validator: (value) {
              if (value!.isEmpty) {
                return "Password can not be empty";
              }
              return null;
            },
          ),
          verticalSpace(24.h),
          PasswordTextFormFieldWithLable(
            controller: getIt<AuthCubit>().userSignUpConfirmPassword,
            hintText: getLang(context, "Retype your password").toString(),
            label: getLang(context, "Confirm password").toString(),
            validator: (value) {
              if (value != getIt<AuthCubit>().userSignUpPassword.text) {
                return "Password not match";
              }
              return null;
            },
          ),
          verticalSpace(24.h),
          DefaultButton(
              color: ColorsManager.blackColor,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  getIt<AuthCubit>().register(
                      registerRequestBody: RegisterRequestBody(
                    firstName: getIt<AuthCubit>()
                        .firstUserNameController
                        .text
                        .trim(),
                    lastName: getIt<AuthCubit>()
                        .lastUserNameController
                        .text
                        .trim(),
                    phone:
                        "${getIt<AuthCubit>().userSignUpPhone.text}",
                    type: widget.userType,
                    password:
                        getIt<AuthCubit>().userSignUpPassword.text.trim(),
                    passwordConfirmation: getIt<AuthCubit>()
                        .userSignUpConfirmPassword
                        .text
                        .trim(),
                  ));

                }
              },
              child: Text(
                getLang(context, "next").toString(),
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              )),
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is RegisterSuccessState) {
                CacheHelper.saveData(
                        key: "phone",
                        value: getIt<AuthCubit>().userSignUpPhone.text)
                    .then((value) {
                  Navigator.pushNamed(
                    context,
                    RouteStrings.verificationCodeScreen,
                    arguments: {
                      "userType": widget.userType,
                      "phone": "${getIt<AuthCubit>().userSignUpPhone.text}",
                    }
                  );
                });
              }else if (state is RegisterErrorState) {
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
            },
            child: const SizedBox.shrink(),
          ),
          verticalSpace(24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getLang(context, "Do you already have an account?").toString(),
                style: TextStyles.gray100FS14FW400CairoTextStyle,
              ),
              horizontalSpace(5.w),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, RouteStrings.loginScreen);
                },
                child: Text(getLang(context, "login").toString(),
                    style: TextStyles.gray100FS14FW400CairoTextStyle
                        .copyWith(color: Colors.black, fontSize: 16.sp)),
              )
            ],
          ),
          verticalSpace(24),
          widget.userType == "user"
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OrWidget(),
                    verticalSpace(24.h),
                    DefaultButton(
                        color: ColorsManager.whiteColor,
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            RouteStrings.homeLayoutScreen,
                            arguments: {
                              "isGuest": true,
                              "isUser": true,
                            },
                          );
                        },
                        child: Text(
                          "الدخول كضيف",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: ColorsManager.gray950,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    verticalSpace(24.h),
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
