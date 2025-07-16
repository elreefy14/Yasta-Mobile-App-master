import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/text_styles.dart';

class CircleWithNumberOfMessages extends StatelessWidget {
  const CircleWithNumberOfMessages({super.key, required this.numberOfMessages});

  final String numberOfMessages;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green,
      ),
      child: Center(
        child: Text(
          numberOfMessages,
          style: TextStyles.whiteFS11FW500CairoTextStyle,
        ),
      ),
    );
  }
}
