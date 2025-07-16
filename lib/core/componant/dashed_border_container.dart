import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/theme/colors.dart';

import 'dashed_border_painter.dart';

class DashedBorderContainer extends StatelessWidget {
  final double width;
  final Color color;
  final Widget child;
  final BorderRadius borderRadius;

  const DashedBorderContainer({
    Key? key,
    required this.width,
    required this.color,
    required this.child,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: color,
        strokeWidth: 2,
        dashWidth: 20,
        dashSpace: 6,
        borderRadius: borderRadius,
      ),
      child: Container(
        width: width,
        height: 130.h,
        decoration: const BoxDecoration(
          color: Color(0xFFF9FAFB),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 1.w,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 15.h,
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
