import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/app_local/app_local.dart';
import '../../../../core/helper/app_color/app_color.dart';
import '../../../../core/helper/spacing/spacing.dart';
import '../../../../core/theme/text_styles.dart';

class FiltterButton extends StatelessWidget {
  const FiltterButton({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      height: 60.h,
      decoration: BoxDecoration(
        border: Border.all(color: ColorsManager.gray300),
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}
