import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/colors.dart';

class CustomHeaderBar extends StatelessWidget {
  final VoidCallback onBackPressed;
  Widget icon;

   CustomHeaderBar({
    super.key,
    required this.onBackPressed,
     required this.icon,

  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.02,
      left: 10.0.w,
      right: 10.0.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          InkWell(
            onTap: onBackPressed,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                border: Border.all(
                  color: AppColors.gray300,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.gray500,
              ),
            ),
          ),
          // Heart Button
          icon
          // InkWell(
          //   onTap: onFavoritePressed,
          //   child: Container(
          //     padding: EdgeInsets.all(8.0.w),
          //     decoration: BoxDecoration(
          //       color: AppColors.whiteColor,
          //       border: Border.all(
          //         color: AppColors.gray300,
          //       ),
          //       shape: BoxShape.circle,
          //     ),
          //     child: const Icon(
          //       Icons.favorite_border,
          //       color: AppColors.gray500,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
