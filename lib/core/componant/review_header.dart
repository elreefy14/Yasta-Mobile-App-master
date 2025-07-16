import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../app_local/app_local.dart';
import '../helper/spacing/spacing.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class ReviewHeader extends StatelessWidget {
  const ReviewHeader({super.key, required this.onTap});
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          getLang(context, "Reviews").toString(),
          style: TextStyles.gray950FS18FW500TextStyle,
        ),
        InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(
                "assets/icons/edit.svg",
                color: AppColors.blackColor,
              ),
              horizontalSpace(5),
              Text(
                getLang(context, "Add your review").toString(),
                style: TextStyles.gray950FS16FW600CairoTextStyle.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
