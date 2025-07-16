import 'package:flutter/material.dart';
import 'package:yasta/features/messages_screen/presentation/widgets/username_without_number_of_messages_and_message_date.dart';

import '../../../../core/helper/spacing/spacing.dart';
import 'message_preview_with_unseen_sign.dart';

class UnseenMessage extends StatelessWidget {
  const UnseenMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UsernameWithoutNumberOfMessagesAndMessageDate(
          userName: "John Doe",
          month: "May",

        ),
        verticalSpace(10),
        const MessagePreviewWithUnseenSign(
          message: "This is a message preview, truncated if too long.",
        ),
      ],
    );
  }
}
