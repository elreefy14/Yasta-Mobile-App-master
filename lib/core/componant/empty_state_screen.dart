import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:yasta/core/componant/default_button.dart';

import '../constants/constants.dart';
import '../helper/spacing/spacing.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class EmptyStateScreen extends StatelessWidget {
  final String message;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final String lottieAnimation;
  final Color? backgroundColor;

  const EmptyStateScreen({
    super.key,
    required this.message,
    this.backgroundColor,
    required this.buttonText,
    required this.onButtonPressed,
    this.lottieAnimation = 'assets/lottie/sad_face.json', // Default animation
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Container(
        color:backgroundColor ?? AppColors.whiteColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Constants.hPadding),
          child: ListView(
            children: [
              verticalSpace(MediaQuery.of(context).size.height * 0.15),
              LottieBuilder.asset(
                lottieAnimation,
                height: 200.h,
                width: 200.w,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .65,
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyles.gray700FS16FW500CairoTextStyle,
                  ),
                ),
              ),
              verticalSpace(30),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .7,
                  child: DefaultButton(
                    label: buttonText,
                    onPressed: onButtonPressed,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
