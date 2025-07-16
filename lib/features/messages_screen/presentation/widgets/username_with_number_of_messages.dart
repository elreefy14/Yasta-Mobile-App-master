import 'package:flutter/material.dart';
import '../../../../core/helper/spacing/spacing.dart';
import '../../../../core/theme/text_styles.dart';
import 'circle_with_number_of_messages.dart';

class UsernameWithNumberOfMessages extends StatelessWidget {
  const UsernameWithNumberOfMessages({
    super.key,
    required this.userName,
    required this.numberOfMessages,
  });

  final String userName;
  final String numberOfMessages;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            userName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.gray800FS16FW500CairoTextStyle,
          ),
        ),
        horizontalSpace(5),
        CircleWithNumberOfMessages(
          numberOfMessages: numberOfMessages,
        ),
      ],
    );
  }
}
