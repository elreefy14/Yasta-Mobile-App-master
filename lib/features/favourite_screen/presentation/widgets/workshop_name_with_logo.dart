import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/componant/user_image_widget.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class WorkshopNameWithLogo extends StatelessWidget {
  const WorkshopNameWithLogo({super.key, required this.workshopName,required this.onTap,required this.onTap2, required this.workshopImage});

  final String workshopName;
  final String workshopImage;
  final  Function() onTap;
  final  Function() onTap2;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            onTap: onTap,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserImageWidget(
                  imageUrl: workshopImage,
                  radius: 25.r,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    workshopName,
                    style: TextStyles.gray800FS16FW500CairoTextStyle,
                    overflow: TextOverflow.ellipsis, // Optional: Adds ellipsis if text is too long
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: onTap2,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: const BoxDecoration(
              color: AppColors.green300,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              "assets/icons/message_icon.svg",
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}
