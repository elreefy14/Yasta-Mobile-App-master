import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../helper/spacing/spacing.dart';
import '../theme/text_styles.dart';

class ProfileItemWidget extends StatelessWidget {
  const ProfileItemWidget(
      {super.key,
      required this.text,
      required this.image,
      required this.onTap});

  final String text;
  final String image;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(image),
            horizontalSpace(10),
            Text(
              text,
              style: TextStyles.gray900FS16FW500CairoTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
