import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/text_styles.dart';

class MandatoryText extends StatelessWidget {
  const MandatoryText({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Text(
          label,
          style: TextStyles.gray950FS16FW500CairoTextStyle,
        ),
        Text(
          "*",
          style: TextStyle(
            color: const Color(0xFFDC2626),
            fontSize: 16.sp,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
