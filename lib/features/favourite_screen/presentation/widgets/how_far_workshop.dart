import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';

import '../../../../core/helper/spacing/spacing.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class HowFarWorkshop extends StatelessWidget {
  const HowFarWorkshop({super.key, required this.far});

  final String far;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        horizontalSpace(5),
        Container(
          width: 5.w,
          height: 5.h,
          decoration: const BoxDecoration(
            color: AppColors.gray500,
            shape: BoxShape.rectangle,
          ),
        ),
        horizontalSpace(5),
        Text(
          getLang(context, "Far away").toString(),
          style: TextStyles.gray500FS14FW400CairoTextStyle,
        ),
        horizontalSpace(5),
        Text(
          "$far ",
          style: TextStyles.gray800FS14FW500CairoTextStyle,
        ),
        Text(
          getLang(context, "km").toString(),
          style: TextStyles.gray800FS14FW500CairoTextStyle,
        ),
      ],
    );
  }
}
