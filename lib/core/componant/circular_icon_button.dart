import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CircularIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconPath; // Path to the icon
  final Color backgroundColor; // Background color of the button
  final Color iconColor; // Color of the icon
  final double size; // Size of the button

  const CircularIconButton({
    super.key,
    required this.onPressed,
    required this.iconPath,
    required this.backgroundColor,
    required this.iconColor,
    this.size = 55.0, // Default size
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size.w, // Use ScreenUtil for responsive size
        height: size.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        child: Center(
          child: iconPath.contains("svg")
              ? SvgPicture.asset(
                  iconPath,
                  color: iconColor,
                  width: (size * 0.6).w,
                  height: (size * 0.6).h,
                )
              : Image.asset(
                  iconPath,
                  color: iconColor,
                  width: (size * 0.6).w, // Set icon size based on button size
                  height: (size * 0.6).h,
                ),
        ),
      ),
    );
  }
}
