import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yasta/core/theme/text_styles.dart';

class IconWithText extends StatelessWidget {
  const IconWithText({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor,
    this.textStyle,
    this.maxLines = 2,
    this.overflow = TextOverflow.ellipsis,
  });

  final String icon; // Accepts an Icon widget
  final String text; // The text to display
  final Color? iconColor; // Optional color for the icon
  final TextStyle? textStyle; // Optional custom text style
  final int maxLines; // Maximum lines for text
  final TextOverflow overflow; // Overflow behavior for text

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Using the provided icon with optional color
        SvgPicture.asset("assets/icons/$icon", color: iconColor),
        const SizedBox(width: 5), // Spacing between icon and text
        Expanded(
          child: Text(
            text,
            maxLines: maxLines,
            overflow: overflow,
            style: textStyle ?? TextStyles.gray800FS16FW500CairoTextStyle, // Default text style
          ),
        ),
      ],
    );
  }
}
