import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/app_local/app_local.dart';
import '../../../../../../core/helper/spacing/spacing.dart';
import '../../../../../../core/theme/text_styles.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          textAlign: TextAlign.center,
          getLang(context, "Sign up as service provider").toString(),
          style: TextStyles.gray950FS18FW700TextStyle,
        ),
        verticalSpace(10),
        Text(
          textAlign: TextAlign.center,
          getLang(context,
                  "Record all your business details, expand your business, and make more profits")
              .toString(),
          style: TextStyles.gray600FS14FW400CairoTextStyle,
        ),
      ],
    );
  }
}

class HeaderWidget1 extends StatelessWidget {
  final String title; // Header title
  final String headerTitle; // Header title
  final int greenIndicators; // Number of green indicators
  final int totalIndicators; // Total number of indicators

  const HeaderWidget1({
    Key? key,
    required this.title,
    required this.headerTitle,
    required this.greenIndicators,
    this.totalIndicators = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Title Text
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            totalIndicators,
            (index) => Container(
              margin: const EdgeInsets.only(right: 4),
              width: 70.w,
              height: 6,
              decoration: BoxDecoration(
                color: index < greenIndicators
                    ? Colors.green // Active indicator
                    : Colors.grey.shade200, // Inactive indicator
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
        verticalSpace(10),
        Text(
          headerTitle,
          textAlign: TextAlign.center,
          style: TextStyles.gray950FS18FW700TextStyle,
        ),
        verticalSpace(10),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyles.gray600FS14FW400CairoTextStyle,
        ),

        // Indicators Row
      ],
    );
  }
}
