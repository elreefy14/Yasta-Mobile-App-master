import 'package:flutter/material.dart';

import '../../../../core/theme/text_styles.dart';

class MessagePreviewFromMe extends StatelessWidget {
  const MessagePreviewFromMe({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: TextStyles.gray800FS14FW500CairoTextStyle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
