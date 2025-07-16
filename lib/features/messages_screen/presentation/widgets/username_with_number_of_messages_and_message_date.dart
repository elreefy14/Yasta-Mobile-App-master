import 'package:flutter/material.dart';
import 'package:yasta/features/messages_screen/presentation/widgets/username_with_number_of_messages.dart';
import 'message_date.dart';

class UsernameWithNumberOfMessagesAndMessageDate extends StatelessWidget {
  const UsernameWithNumberOfMessagesAndMessageDate({super.key, required this.userName, required this.month,  required this.numberOfMessages});
  final String userName;
  final String numberOfMessages;
  final String month;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: UsernameWithNumberOfMessages(
            userName: userName,
            numberOfMessages: numberOfMessages,
          ),
        ),
        MessageDate(
          month: month,

        ),
      ],
    );
  }
}
