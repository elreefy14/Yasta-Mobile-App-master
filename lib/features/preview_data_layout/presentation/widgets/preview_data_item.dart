import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import '../../../../core/helper/spacing/spacing.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class PreviewDataItem extends StatelessWidget {
  const PreviewDataItem(
      {super.key,
      required this.child,
      this.editText,
      required this.title,
      required this.updateTap});

  final Widget child;
  final String title;
  final String? editText;
  final Function() updateTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 24.w, left: 24.w, top: 30.h),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: AppColors.gray200,
            width: 1.w,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyles.gray900FS16FW500CairoTextStyle,
              ),
              const Spacer(),
              InkWell(
                onTap: updateTap,
                child: Text(
                  editText ?? getLang(context, "Edit").toString(),
                  style: TextStyles.gray950FS16FW600CairoTextStyle.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          verticalSpace(30),
          child
        ],
      ),
    );
  }
}
