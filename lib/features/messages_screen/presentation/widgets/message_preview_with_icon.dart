import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helper/spacing/spacing.dart';
import '../../../../core/theme/text_styles.dart';

class MessagePreviewWithIcon extends StatelessWidget {
  const MessagePreviewWithIcon({super.key, required this.icon, required this.message});
  final String icon ;
  final String message ;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        horizontalSpace(5),
        Expanded(
          child: Text(
            message,
            style: TextStyles.gray800FS14FW500CairoTextStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
