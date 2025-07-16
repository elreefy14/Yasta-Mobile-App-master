import 'package:flutter/material.dart';

import 'message_date.dart';
import 'username_without_number_of_messages.dart';

class UsernameWithoutNumberOfMessagesAndMessageDate extends StatelessWidget {
  const UsernameWithoutNumberOfMessagesAndMessageDate(
      {super.key,
      required this.userName,
      required this.month,
      });

  final String userName;
  final String month;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: UsernameWithoutNumberOfMessages(
            userName: userName,
          ),
        ),
        MessageDate(
          month: month,

        ),
      ],
    );
  }
}
