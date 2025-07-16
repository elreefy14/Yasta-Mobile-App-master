import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helper/spacing/spacing.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class LabeledInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const LabeledInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 5.w,
            height: 5.w,
            decoration: const BoxDecoration(
              color: AppColors.blackColor,
              shape: BoxShape.rectangle,
            ),
          ),
          horizontalSpace(10),
          Text(
            "$label ",
            style: TextStyles.gray950FS18FW500TextStyle,
          ),
          Text(
            value,
            style: TextStyles.gray800FS16FW500CairoTextStyle,
          ),
        ],
      ),
    );
  }
}
