import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import 'package:yasta/features/auth/auth_layput_screen.dart';
import 'package:yasta/features/auth/data/models/resend_otp.dart';
import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';
import '../../../core/componant/back_button_widget.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/route/route_strings/route_strings.dart';
import '../data/models/verify_request_body.dart';
import 'verification_code_widget.dart';

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen(
      {super.key, required this.userType, required this.phone});

  final String userType;
  final String phone;

  @override
  Widget build(BuildContext context) {
    debugPrint(phone);
    debugPrint(userType);
    return AuthLayout(
      children: [
        const BackButtonWidget(),
        VerificationCodeWidget(
          onResendPressed: () {
            getIt<AuthCubit>().reSendOtp(reSendOTPModel: ReSendOTPModel(
                phone: phone,
            ));
          },
          onNextPressed: () {
            userType=="Change Password"?
            getIt<AuthCubit>().verifyOtp(
              verifyRequestBody: VerifyRequestBody(
                phone: phone,
                otp: getIt<AuthCubit>().otp,
              ),
            ) : getIt<AuthCubit>().verify(
              verifyRequestBody: VerifyRequestBody(
                phone: phone,
                otp: getIt<AuthCubit>().otp,
              ),
            );
          },
        ),
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is VerifySuccessState) {
              CacheHelper.saveData(key: "id", value: state.data!.data?.id ?? "")
                  .then((value) {
                CacheHelper.saveData(
                        key: "workshop_id",
                        value: state.data!.data?.workshop_id ?? "")
                    .then((value) {
                  CacheHelper.saveData(
                          key: "phone",
                          value: phone??"")
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
                                key: "userType", value: state.data!.data!.type!)
                            .then((value) {
                          CacheHelper.saveData(
                                  key: "token", value: state.data!.data!.token!)
                              .then((value) {
                            userType == "provider"
                                ? Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    RouteStrings.addWorkshopData,
                                    (Route<dynamic> route) =>
                                        false, // This clears all previous routes
                                  )
                                : userType == "Change password"
                                    ? Navigator.pushReplacementNamed(
                                        context,
                                        RouteStrings.changePassword,
                                      )
                                    : Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        RouteStrings.addCarData,
                                        (Route<dynamic> route) => false,
                                      );
                          });
                        });
                      });
                    });
                  });
                });
              });

              // CacheHelper.saveData(key: "token", value: state.data!.data!.token)
              //     .then(
              //   (value) {
              //     userType == "provider"
              //         ? Navigator.pushReplacementNamed(
              //             context,
              //             RouteStrings.serviceProviderSignUpScreen,
              //           )
              //         : userType == "Change password"
              //             ? Navigator.pushReplacementNamed(
              //                 context,
              //                 RouteStrings.changePassword,
              //               )
              //             : Navigator.pushReplacementNamed(
              //                 context,
              //                 RouteStrings.addCarData,
              //               );
              //   },
              // );
            }
            if (state is VerifyErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            if (state is VerifyOTPSuccessState) {

              getIt<AuthCubit>().VerifyOTPForgetPassword=state.data!.data!.token!;
              Navigator.pushReplacementNamed(
                context,
                RouteStrings.changePassword,
              );
              // CacheHelper.saveData(key: "token", value: state.data!.data!.token)
              //     .then(
              //   (value) {
              //     userType == "provider"
              //         ? Navigator.pushReplacementNamed(
              //             context,
              //             RouteStrings.serviceProviderSignUpScreen,
              //           )
              //         : userType == "Change password"
              //             ? Navigator.pushReplacementNamed(
              //                 context,
              //                 RouteStrings.changePassword,
              //               )
              //             : Navigator.pushReplacementNamed(
              //                 context,
              //                 RouteStrings.addCarData,
              //               );
              //   },
              // );
            }
            if (state is VerifyOTPErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            if(state is ReSendSuccessState){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("otp sent successfully"),
                ),
              );
            }
            if(state is ReSendErrorState){
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
