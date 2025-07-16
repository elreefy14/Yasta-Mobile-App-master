import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/theme/colors.dart';
import 'package:yasta/core/theme/text_styles.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton(
      {super.key, required this.onPressed, required this.label, this.backgroundColor, this.textColor,});

  final Function() onPressed;
  final String label;

  Color? backgroundColor;
  Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
        ),
        backgroundColor: backgroundColor ?? AppColors.blackColor,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),

        ),
      ),
      onPressed: onPressed,
      child: Center(
        child: Text(
          label,
          style: TextStyles.whiteFS16FW500CairoTextStyle.copyWith(
              color: textColor?? AppColors.whiteColor
          ),
        ),
      ),
    );
  }
}

class DefaultButton1 extends StatelessWidget {
  DefaultButton1({
    super.key,
    required this.onPressed,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.borderColor, // Added borderColor
  });

  final Function() onPressed;
  final String label;

  Color? backgroundColor;
  Color? textColor;
  Color? borderColor; // Added borderColor property

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
        ),
        backgroundColor: backgroundColor ?? AppColors.blackColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
          side: BorderSide(
            color: borderColor??Colors.grey , // Border color
            width: 2.0, // Border width
          ),
        ),
      ),
      onPressed: onPressed,
      child: Center(
        child: Text(
          label,
          style: TextStyles.whiteFS16FW500CairoTextStyle.copyWith(
            color: textColor ?? AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}