import 'package:flutter/material.dart';

import '../../../../core/theme/text_styles.dart';

class UsernameWithoutNumberOfMessages extends StatelessWidget {
  const UsernameWithoutNumberOfMessages({super.key, required this.userName});
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Text(
      userName,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyles.gray800FS16FW500CairoTextStyle,
    );
  }
}
