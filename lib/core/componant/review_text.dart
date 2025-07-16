import 'package:flutter/material.dart';

import '../theme/text_styles.dart';

class ReviewText extends StatelessWidget {
  const ReviewText({super.key, required this.reviewText});
  final String reviewText;

  @override
  Widget build(BuildContext context) {
    return Text(
      reviewText,
      style: TextStyles.gray700FS16FW500CairoTextStyle,
    );
  }
}
