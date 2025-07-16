import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/componant.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/features/auth/auth_layput_screen.dart';
import 'package:yasta/features/auth/data/models/resend_otp.dart';
import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';
import '../../../../core/componant/error_bottom_sheet_widget.dart';
import '../../../../core/componant/password_text_form_field_with_lable.dart';
import '../../../../core/componant/phone_number_Input.dart';
import '../../../../core/componant/success_bottom_sheet_widget.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helper/app_color/app_color.dart';
import '../../../../core/route/route_strings/route_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../data/models/login_request_body.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: AuthLayout(
        children: [
          Text(
            getLang(context, "login").toString(),
            style: TextStyles.blackFS18FW700CandaraTextStyle,
            textAlign: TextAlign.center,
          ),
          Text(
            getLang(context, "We are glad to have you back again.").toString(),
            style: TextStyles.gray100FS14FW400CairoTextStyle,
            textAlign: TextAlign.center,
          ),
          verticalSpace(33.h),
          // Text(
          //   getLang(context, "Phone number:").toString(),
          //   style: TextStyles.gray950FS16FW500CairoTextStyle,
          // ),
          // verticalSpace(5.h),
          // Row(
          //   children: [
          //     InkWell(
          //       onTap: () {
          //         showCountryPicker(
          //           context: context,
          //           showPhoneCode: true, // Show the country phone code
          //           onSelect: (Country country) {
          //             setState(() {
          //               _selectedCountry = '+${country.phoneCode}';
          //             });
          //           },
          //         );
          //       },
          //       child: Container(
          //         width: 60.w, // Set width to 88
          //         height: 53.h,
          //         color: Color(0xFFF9FAFB),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             SvgPicture.asset(
          //               "assets/icons/Frame (3).svg",
          //             ),
          //             Text(
          //               _selectedCountry ??
          //                   "+20", // Display country code or default
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     horizontalSpace(5.w),
          //     SizedBox(
          //       width: 268.w,
          //       child: CustomTextFormField(
          //         controller: phoneController,
          //         hintText: "010XXXXXXXX",
          //       ),
          //     ),
          //   ],
          // ),
          PhoneNumberInput(
            controller: getIt<AuthCubit>().loginPhoneController,
            onPhoneCodeChanged: (value) {
              getIt<AuthCubit>().onPhoneCodeChanged(value);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return getLang(context, "Please enter phone number");
              } else if (value.length != 11) {
                return getLang(context, "Please enter valid phone number");
              }
              return null;
            },
          ),
          verticalSpace(24.h),
          PasswordTextFormFieldWithLable(
            controller: getIt<AuthCubit>().loginPasswordController,
            hintText: getLang(context, "Enter your password:").toString(),
            label: getLang(context, "your password:").toString(),
          ),
          verticalSpace(7.h),
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                  context, RouteStrings.addPhoneInForgetPassword);
            },
            child: Text(
              getLang(context, "Forgot your password?").toString(),
              style: TextStyles.gray100FS14FW400CairoTextStyle,
              textAlign: CacheHelper.getdata(key: "lang") == "ar"
                  ? TextAlign.right
                  : TextAlign.left,
            ),
          ),
          verticalSpace(24.h),
          DefaultButton(
            color: ColorsManager.blackColor,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                getIt<AuthCubit>().login(
                  loginRequestBody: LoginRequestBody(
                      // phone:
                      //     "+${getIt<AuthCubit>().phoneCode}${getIt<AuthCubit>().loginPhoneController.text}",
                      phone: getIt<AuthCubit>().loginPhoneController.text,
                      password:
                          getIt<AuthCubit>().loginPasswordController.text),
                );
              }
            },
            child: Text(
              getLang(context, "next").toString(),
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is LoginSuccessState) {
                CacheHelper.saveData(
                        key: "id", value: state.data!.data?.id ?? "")
                    .then((value) {
                  CacheHelper.saveData(
                          key: "workshop_id",
                          value: state.data!.data?.workshop_id ?? "")
                      .then((value) {
                    CacheHelper.saveData(
                            key: "phone",
                            value: getIt<AuthCubit>().loginPhoneController.text)
                        .then((value) {
                      CacheHelper.saveData(
                              key: "userImage", value: state.data!.data!.image)
                          .then((value) {
                        CacheHelper.saveData(
                                key: "userName",
                                value:
                                    "${state.data!.data!.firstName} ${state.data!.data!.lastName}")
                            .then((value) {
                          CacheHelper.saveData(
                                  key: "userType",
                                  value: state.data!.data!.type!)
                              .then((value) {
                            CacheHelper.saveData(
                                    key: "token",
                                    value: state.data!.data!.token!)
                                .then((value) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                RouteStrings.homeLayoutScreen,
                                (Route<dynamic> route) => false,
                                // This clears all previous routes
                                arguments: {
                                  "isGuest": false,
                                  "isUser": state.data!.data!.type! == "user"
                                },
                              );
                            });
                          });
                        });
                      });
                    });
                  });
                });
              }

              if (state is LoginErrorState) {
                print(state.message.contains("Your phone number is not verified."));
                print(state.message.contains("Your phone number is not verified."));
                print(state.message.contains("Your phone number is not verified."));
                print(state.message.contains("Your phone number is not verified."));
                if (state.message
                    .contains("Your phone number is not verified")) {
                  String userType = state.message.split("type:").last;
                  Navigator.pushNamed(
                      context, RouteStrings.verificationCodeScreen,
                      arguments: {
                        "userType": userType,
                        "phone": "${getIt<AuthCubit>().loginPhoneController.text}",
                      });
                    getIt<AuthCubit>().reSendOtp(reSendOTPModel: ReSendOTPModel(
                      phone: getIt<AuthCubit>().loginPhoneController.text,
    ),
                  );
                } else {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(45.0.r)),
                    ),
                    builder: (context) => ErrorBottomSheetWidget(
                      errorText: state.message.toString(),
                    ),
                  );
                }

                debugPrint("");
              }
            },
            child: Container(),
          ),
          verticalSpace(24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getLang(context, "Don't have an account?").toString(),
                style: TextStyles.gray100FS14FW400CairoTextStyle,
              ),
              horizontalSpace(5.w),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteStrings.serviceType);
                },
                child: Text(getLang(context, "join us").toString(),
                    style: TextStyles.gray100FS14FW400CairoTextStyle
                        .copyWith(color: Colors.black, fontSize: 16.sp)),
              )
            ],
          )
        ],
      ),
    );
  }
}
