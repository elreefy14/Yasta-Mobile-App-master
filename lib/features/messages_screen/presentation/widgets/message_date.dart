import 'package:flutter/material.dart';

import '../../../../core/helper/spacing/spacing.dart';
import '../../../../core/theme/text_styles.dart';

class MessageDate extends StatelessWidget {
  const MessageDate({super.key, required this.month});
  final String month;
  // final String day;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          month,
          style: TextStyles.gray600FS14FW400CairoTextStyle,
        ),
        // horizontalSpace(4),
        // Text(
        //   day ,
        //   style: TextStyles.gray600FS14FW400CairoTextStyle,
        // ),
      ],
    );
  }
}
