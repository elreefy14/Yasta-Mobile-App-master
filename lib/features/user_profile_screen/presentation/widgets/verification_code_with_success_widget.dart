import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/constants/constants.dart';
import 'package:yasta/features/user_profile_screen/logic/user_profile_cubit.dart';
import '../../../../core/componant/success_bottom_sheet_widget.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helper/cache_helper/cache_helper.dart';
import '../../../auth/widgets/verification_code_widget.dart';
import '../../data/models/verify_updated_phone_number_request_body.dart';

class VerificationCodeWithSuccessWidget extends StatefulWidget {
  const VerificationCodeWithSuccessWidget(
      {super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<VerificationCodeWithSuccessWidget> createState() =>
      _VerificationCodeWithSuccessWidgetState();
}

class _VerificationCodeWithSuccessWidgetState
    extends State<VerificationCodeWithSuccessWidget> {
  String otp = "";

  getCode(String code) {
    debugPrint("Received OTP: $code");
    setState(() {
      otp = code;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("OTP value in build: $otp"); // Ensure `otp` updates correctly
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Constants.hPadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              VerificationCodeWidget(
                onNextPressed: () {
                  debugPrint(
                      "Current OTP: $otp"); // Debug to ensure `otp` is set

                  getIt<UserProfileCubit>().verifyUpdatedPhoneNumber(
                      verifyUpdatedPhoneNumberRequestBody:
                          VerifyUpdatedPhoneNumberRequestBody(
                    phone: widget.phoneNumber,
                    otp: otp,
                  ));
                },
                onCodeCompleted: getCode,
                onResendPressed: () {},
              ),
              BlocListener<UserProfileCubit, UserProfileState>(
                listener: (context, state) {
                  if (state is VerifyUpdatePhoneNumberSuccessState) {
                    Navigator.pop(context);
                    CacheHelper.saveData(
                        key: "phone", value: widget.phoneNumber);
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(45.0.r)),
                      ),
                      builder: (context) => SuccessBottomSheetWidget(
                        successText: getLang(context,
                                "Your profile has been updated successfully.")
                            .toString(),
                      ),
                    );
                  }
                },
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
