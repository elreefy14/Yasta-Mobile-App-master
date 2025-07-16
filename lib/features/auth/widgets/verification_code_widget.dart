import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/default_button.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';
import '../logic/auth_cubit/auth_cubit.dart';

class VerificationCodeWidget extends StatefulWidget {
  VerificationCodeWidget(
      {super.key,
      required this.onNextPressed,
      this.onCodeCompleted,
      required this.onResendPressed});

  final Function() onNextPressed;
  final Function() onResendPressed;
  final Function(String)? onCodeCompleted;

  @override
  State<VerificationCodeWidget> createState() => _VerificationCodeWidgetState();
}

class _VerificationCodeWidgetState extends State<VerificationCodeWidget> {
  int _remainingTime = 30; // Countdown timer (in seconds)
  late Timer _timer; // Timer instance
  bool _isButtonVisible = false; // Resend button visibility state

  @override
  void initState() {
    super.initState();
    startResendTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  void startResendTimer() {
    _remainingTime = 30; // Reset the countdown
    _isButtonVisible = false; // Hide the button initially

    // Start the timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--; // Decrease the countdown
        } else {
          _isButtonVisible = true; // Show the button when countdown ends
          _timer.cancel(); // Stop the timer
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(70),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              getLang(context, "Verify code").toString(),
              style: TextStyles.gray950FS18FW700TextStyle,
            ),
            verticalSpace(5),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                getLang(context,
                        "We have sent a code to your phone number. Please enter the code below")
                    .toString(),
                textAlign: TextAlign.center,
                style: TextStyles.gray100FS14FW400CairoTextStyle,
              ),
            ),
          ],
        ),
        verticalSpace(40),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: PinCodeTextField(
            length: 6,
            obscureText: false,
            animationType: AnimationType.fade,
            backgroundColor: Colors.transparent,
            cursorColor: AppColors.blackColor,
            enablePinAutofill: true,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.underline,
              selectedColor: AppColors.blackColor,
              disabledColor: Colors.transparent,
              activeColor: AppColors.gray100,
              inactiveColor: AppColors.blackColor,
              selectedFillColor: Colors.transparent,
              activeFillColor: Colors.transparent,
              inactiveFillColor: AppColors.gray100,
              fieldHeight: 60.h,
              fieldWidth: 50.w,
            ),
            animationDuration: const Duration(milliseconds: 100),
            enableActiveFill: true,
            onCompleted: (v) {
              debugPrint("Completed");
              if (widget.onCodeCompleted != null) {
                widget.onCodeCompleted!(v); // Invoke the callback
              } else {
                getIt<AuthCubit>().otp = v;
              }
            },
            onChanged: (value) {
              print(value);
              // isComplete = true;
              // setState(() {
              //   isComplete = true;
              // });
            },
            beforeTextPaste: (text) {
              print("Allowing to paste $text");
              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
              //but you can show anything you want here, like your pop up saying wrong paste format or etc
              return true;
            },
            appContext: context,
          ),
        ),
        verticalSpace(30),
        DefaultButton(
          onPressed: widget.onNextPressed,
          label: getLang(context, "next").toString(),
        ),
        verticalSpace(10),
        _isButtonVisible
            ? TextButton(
                onPressed: widget.onResendPressed,
                child: Text(
                  getLang(context, "Resend").toString(),
                  style: TextStyles.gray950FS16FW600CairoTextStyle,
                ),
              )
            : Text(
          "Please wait $_remainingTime seconds to resend.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
      ],
    );
  }
}
