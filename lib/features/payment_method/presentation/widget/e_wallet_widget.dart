import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/helper/spacing/spacing.dart';
import '../../../../core/theme/text_styles.dart';

class EWalletWidget extends StatelessWidget {
  const EWalletWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset("assets/image/Vector.svg"),
              horizontalSpace(40.w),
              Text(
                'E-wallet',
                style: TextStyles.gray700FS16FW500CairoTextStyle,
              ),
              Spacer(),
              SvgPicture.asset("assets/icons/Keyboard arrow up.svg"),
            ],
          ),
          verticalSpace(10.h),
          Text(
            'استخدم محفظتك الإلكترونية',
            textAlign: TextAlign.start,
            style: TextStyles.gray100FS14FW400CairoTextStyle,
          ),
          verticalSpace(10.h),
          Row(
            children: [
              SvgPicture.asset("assets/image/Ellipse 34 (1).svg"),
              horizontalSpace(8.w),
              SvgPicture.asset("assets/image/Ellipse 35.svg"),
              horizontalSpace(8.w),
              SvgPicture.asset("assets/image/Ellipse 36.svg"),
            ],
          ),
        ],
      ),
    );
  }
}
