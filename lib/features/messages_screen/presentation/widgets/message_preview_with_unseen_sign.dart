import 'package:flutter/material.dart';
import 'package:yasta/features/messages_screen/presentation/widgets/message_preview_with_icon.dart';

class MessagePreviewWithUnseenSign extends StatelessWidget {
  const MessagePreviewWithUnseenSign({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return MessagePreviewWithIcon(
        icon: "assets/icons/unseen_icon.svg", message: message);
  }
}
